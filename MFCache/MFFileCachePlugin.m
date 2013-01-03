//
//  MFFileCachePlugin.m
//
// Copyright (c) 2012 Ken Matsui (https://github.com/mkftr)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "MFFileCachePlugin.h"

#define kMFFileCachePluginDefaultFileName   @"MFCache.plist"

@interface MFFileCachePlugin ()
- (NSMutableDictionary *)cacheData;
- (BOOL)saveCacheData:(NSMutableDictionary *)cacheData;
- (NSString *)cacheFilePath;
@end

@implementation MFFileCachePlugin

- (id)init
{
    self = [super init];
    if (self)
    {
        self.fileName = kMFFileCachePluginDefaultFileName;
    }
    return self;
}

- (void)put:(MFCacheElement *)element
{
    NSMutableDictionary *cacheData = [self cacheData];
    [cacheData setObject:element forKey:element.key];
    [self saveCacheData:cacheData];
}

- (MFCacheElement *)get:(NSString *)key
{
    NSMutableDictionary *cacheData = [self cacheData];
    return (MFCacheElement *)[cacheData objectForKey:key];
}

- (void)remove:(NSString *)key
{
    NSMutableDictionary *cacheData = [self cacheData];
    [cacheData delete:key];
    [self saveCacheData:cacheData];
}

- (void)flushAll;
{
    NSURL *url = [NSURL fileURLWithPath:[self cacheFilePath]];
    
    NSError *error = nil;
    [[NSFileManager defaultManager] removeItemAtURL:url error:&error];
    
    if (error)
    {
        NSLog(@"MFCache Error : %@", error);
    }
}

- (NSMutableDictionary *)cacheData
{
    NSURL *fileURL = [NSURL fileURLWithPath:[self cacheFilePath]];
    
    NSError *error;
    NSData *data = [NSData dataWithContentsOfURL:fileURL options:NSDataReadingMappedIfSafe error:&error];
    
    NSMutableDictionary *cacheDictionary = (NSMutableDictionary *)[NSKeyedUnarchiver unarchiveObjectWithData:data];
    if (cacheDictionary == nil)
    {
        cacheDictionary = [NSMutableDictionary dictionary];
    }
    return cacheDictionary;
}

- (BOOL)saveCacheData:(NSMutableDictionary *)cacheData
{
    NSURL *fileURL = [NSURL fileURLWithPath:[self cacheFilePath]];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:cacheData];
    return [data writeToURL:fileURL atomically:YES];
}

- (NSString *)cacheFilePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cacheDir = [paths lastObject];
    return [cacheDir stringByAppendingPathComponent:self.fileName];
}

@end
