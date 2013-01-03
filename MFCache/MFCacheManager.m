//
//  MFCacheManager.m
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

#import "MFCacheManager.h"
#import "MFFileCachePlugin.h"

static MFCacheManager *_instance;


@interface MFCacheManager ()
@property (nonatomic, retain) NSObject<MFCachePlugin> *cachePlugin;
@end


@implementation MFCacheManager

+ (MFCacheManager *)defaultManager
{
    if (_instance == nil)
    {
        _instance = [[MFCacheManager alloc] init];
        NSObject<MFCachePlugin> *plugin = [[MFFileCachePlugin alloc] init];
        [_instance setSharedCachePlugin:plugin];
    }
    return _instance;
}

- (void)setSharedCachePlugin:(NSObject<MFCachePlugin> *)newCachePlugin
{
    self.cachePlugin = newCachePlugin;
}

- (void)put:(MFCacheElement *)element
{
    [self.cachePlugin put:element];
}

- (NSObject *)get:(NSString *)key
{
    MFCacheElement *ele = [self.cachePlugin get:key];
    if ([ele hasExpired])
    {
        [self remove:ele.key];
        return nil;
    }
    return ele.value;
}

- (void)remove:(NSString *)key
{
    [self.cachePlugin remove:key];
}

- (void)flushAll
{
    [self.cachePlugin flushAll];
}

@end
