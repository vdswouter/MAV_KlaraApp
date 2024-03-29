/**********************************************************************************
 AudioPlayer.m
 
 Created by Thong Nguyen on 14/05/2012.
 https://github.com/tumtumtum/audjustable
 
 Copyright (c) 2012 Thong Nguyen (tumtumtum@gmail.com). All rights reserved.
 
 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:
 1. Redistributions of source code must retain the above copyright
 notice, this list of conditions and the following disclaimer.
 2. Redistributions in binary form must reproduce the above copyright
 notice, this list of conditions and the following disclaimer in the
 documentation and/or other materials provided with the distribution.
 3. All advertising materials mentioning features or use of this software
 must display the following acknowledgement:
 This product includes software developed by Thong Nguyen (tumtumtum@gmail.com)
 4. Neither the name of Thong Nguyen nor the
 names of its contributors may be used to endorse or promote products
 derived from this software without specific prior written permission.
 
 THIS SOFTWARE IS PROVIDED BY Thong Nguyen ''AS IS'' AND ANY
 EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 DISCLAIMED. IN NO EVENT SHALL THONG NGUYEN BE LIABLE FOR ANY
 DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 **********************************************************************************/

#import "STKHTTPDataSource.h"
#import "STKLocalFileDataSource.h"

@interface STKHTTPDataSource()
{
@private
    long long seekStart;
    long long relativePosition;
    long long fileLength;
    int discontinuous;
    NSURL* currentUrl;
    STKAsyncURLProvider asyncUrlProvider;
    NSDictionary* httpHeaders;
    AudioFileTypeID audioFileTypeHint;
}
-(void) open;

@end

@implementation STKHTTPDataSource

-(id) initWithURL:(NSURL*)urlIn
{
    return [self initWithURLProvider:^NSURL* { return urlIn; }];
}

-(id) initWithURLProvider:(STKURLProvider)urlProviderIn
{
	urlProviderIn = [urlProviderIn copy];
    
    return [self initWithAsyncURLProvider:^(STKHTTPDataSource* dataSource, BOOL forSeek, STKURLBlock block)
    {
        block(urlProviderIn());
    }];
}

-(id) initWithAsyncURLProvider:(STKAsyncURLProvider)asyncUrlProviderIn
{
    if (self = [super init])
    {
        seekStart = 0;
        relativePosition = 0;
        fileLength = -1;
        
        self->asyncUrlProvider = [asyncUrlProviderIn copy];
        
        audioFileTypeHint = [STKLocalFileDataSource audioFileTypeHintFromFileExtension:self->currentUrl.pathExtension];
    }
    
    return self;
}

-(void) dealloc
{
    NSLog(@"STKHTTPDataSource dealloc");
}

-(NSURL*) url
{
    return self->currentUrl;
}

+(AudioFileTypeID) audioFileTypeHintFromMimeType:(NSString*)mimeType
{
    static dispatch_once_t onceToken;
    static NSDictionary* fileTypesByMimeType;
    
    dispatch_once(&onceToken, ^
    {
        fileTypesByMimeType =
        @{
            @"audio/mp3": @(kAudioFileMP3Type),
            @"audio/mpg": @(kAudioFileMP3Type),
            @"audio/mpeg": @(kAudioFileMP3Type),
            @"audio/wav": @(kAudioFileWAVEType),
            @"audio/aifc": @(kAudioFileAIFCType),
            @"audio/aiff": @(kAudioFileAIFFType),
            @"audio/x-m4a": @(kAudioFileM4AType),
            @"audio/x-mp4": @(kAudioFileMPEG4Type),
            @"audio/aacp": @(kAudioFileAAC_ADTSType),
            @"audio/m4a": @(kAudioFileM4AType),
            @"audio/mp4": @(kAudioFileMPEG4Type),
            @"audio/caf": @(kAudioFileCAFType),
            @"audio/aac": @(kAudioFileAAC_ADTSType),
            @"audio/ac3": @(kAudioFileAC3Type),
            @"audio/3gp": @(kAudioFile3GPType)
        };
    });
    
    NSNumber* number = [fileTypesByMimeType objectForKey:mimeType];
    
    if (!number)
    {
        return 0;
    }
    
    return (AudioFileTypeID)number.intValue;
}

-(AudioFileTypeID) audioFileTypeHint
{
    return audioFileTypeHint;
}

-(void) dataAvailable
{
//    NSLog(@"dataAvailable");
    
    if (fileLength < 0)
    {
        CFTypeRef response = CFReadStreamCopyProperty(stream, kCFStreamPropertyHTTPResponseHeader);
        
        httpHeaders = (__bridge_transfer NSDictionary*)CFHTTPMessageCopyAllHeaderFields((CFHTTPMessageRef)response);
        
        self.httpStatusCode = CFHTTPMessageGetResponseStatusCode((CFHTTPMessageRef)response);
        
        CFRelease(response);
        
        if (self.httpStatusCode == 200)
        {
            if (seekStart == 0)
            {
                fileLength = (long long)[[httpHeaders objectForKey:@"Content-Length"] integerValue];
            }
            
            NSString* contentType = [httpHeaders objectForKey:@"Content-Type"];
            AudioFileTypeID typeIdFromMimeType = [STKHTTPDataSource audioFileTypeHintFromMimeType:contentType];
            
            if (typeIdFromMimeType != 0)
            {
                audioFileTypeHint = typeIdFromMimeType;
            }
        }
        else
        {
            [self errorOccured];
            
            return;
        }
    }
    
    [super dataAvailable];
}

-(long long) position
{
    return seekStart + relativePosition;
}

-(long long) length
{
    return fileLength >= 0 ? fileLength : 0;
}

-(void) seekToOffset:(long long)offset
{
    if (eventsRunLoop)
    {
        [self unregisterForEvents];
    }
    
    if (stream)
    {
        CFReadStreamClose(stream);
        CFRelease(stream);
    }
    
    NSAssert(!(eventsRunLoop != nil && [NSRunLoop currentRunLoop] != eventsRunLoop), @"Seek called on wrong thread");
    
    stream = 0;
    relativePosition = 0;
    seekStart = offset;
    
    self->isInErrorState = NO;
    
    [self openForSeek:YES];
}

-(int) readIntoBuffer:(UInt8*)buffer withSize:(int)size
{
    if (size == 0)
    {
        return 0;
    }
    
    int read = (int)CFReadStreamRead(stream, buffer, size);
    
    if (read < 0)
    {
        return read;
    }
    
    relativePosition += read;
    
//    NSLog(@"relative position: %lld, read: %d, position: %lld, length: %lld", relativePosition, read, self.position, self.length);
    
    return read;
}

-(void) open
{
    return [self openForSeek:NO];
}

-(void) openForSeek:(BOOL)forSeek
{
    asyncUrlProvider(self, forSeek, ^(NSURL* url)
    {
        self->currentUrl = url;

        if (url == nil)
        {
            return;
        }

        CFHTTPMessageRef message = CFHTTPMessageCreateRequest(NULL, (CFStringRef)@"GET", (__bridge CFURLRef)self->currentUrl, kCFHTTPVersion1_1);

        if (seekStart > 0)
        {
            CFHTTPMessageSetHeaderFieldValue(message, CFSTR("Range"), (__bridge CFStringRef)[NSString stringWithFormat:@"bytes=%lld-", seekStart]);

            discontinuous = YES;
        }

        stream = CFReadStreamCreateForHTTPRequest(NULL, message);

        if (stream == nil)
        {
            CFRelease(message);

            [self errorOccured];

            return;
        }

        if (!CFReadStreamSetProperty(stream, kCFStreamPropertyHTTPShouldAutoredirect, kCFBooleanTrue))
        {
            CFRelease(message);

            [self errorOccured];

            return;
        }

        // Proxy support

        CFDictionaryRef proxySettings = CFNetworkCopySystemProxySettings();
        CFReadStreamSetProperty(stream, kCFStreamPropertyHTTPProxy, proxySettings);
        CFRelease(proxySettings);

        // SSL support

        if ([self->currentUrl.scheme caseInsensitiveCompare:@"https"] == NSOrderedSame)
        {
            NSDictionary* sslSettings = [NSDictionary dictionaryWithObjectsAndKeys:
            (NSString*)kCFStreamSocketSecurityLevelNegotiatedSSL, kCFStreamSSLLevel,
            [NSNumber numberWithBool:YES], kCFStreamSSLAllowsExpiredCertificates,
            [NSNumber numberWithBool:YES], kCFStreamSSLAllowsExpiredRoots,
            [NSNumber numberWithBool:YES], kCFStreamSSLAllowsAnyRoot,
            [NSNumber numberWithBool:NO], kCFStreamSSLValidatesCertificateChain,
            [NSNull null], kCFStreamSSLPeerName,
            nil];

            CFReadStreamSetProperty(stream, kCFStreamPropertySSLSettings, (__bridge CFTypeRef)sslSettings);
        }

        [self reregisterForEvents];
        
        // Open

        if (!CFReadStreamOpen(stream))
        {
            CFRelease(stream);
            CFRelease(message);

            [self errorOccured];

            return;
        }
        
        self->isInErrorState = NO;
        
        CFRelease(message);
    });
}

-(NSRunLoop*) eventsRunLoop
{
    return self->eventsRunLoop;
}

-(NSString*) description
{
    return [NSString stringWithFormat:@"HTTP data source with file length: %lld and position: %lld", self.length, self.position];
}

@end
