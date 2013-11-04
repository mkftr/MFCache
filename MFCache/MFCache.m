//
//  MFCache.m
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

#import "MFCache.h"
#import "MFCacheManager.h"
#import "MFCacheElement.h"

@implementation MFCache


+ (void)setValue:(NSObject *)value forKey:(NSString *)key
{
    [MFCache setValue:value forKey:key expiration:0];
}

+ (void)setValue:(NSObject *)value forKey:(NSString *)key expiration:(NSTimeInterval)expiration
{
    MFCacheElement *element = [[MFCacheElement alloc] initWithKey:key value:value];
    [element setTimeToLive:expiration];
    [[MFCacheManager defaultManager] put:element];
}

+ (NSObject *)valueForKey:(NSString *)key
{
    return [[MFCacheManager defaultManager] get:key];
}

+ (NSObject *)valueForKey:(NSString *)key default:(NSObject *)defaultValue
{
    NSObject *value = [[MFCacheManager defaultManager] get:key];
    if (value == nil)
    {
        MFCacheElement *element = [[MFCacheElement alloc] initWithKey:key value:defaultValue];
        [[MFCacheManager defaultManager] put:element];
        value = [self valueForKey:key];
    }
    return value;
}

+ (void)removeForKey:(NSString *)key
{
    [[MFCacheManager defaultManager] remove:key];
}

+ (void)flushAll
{
    [[MFCacheManager defaultManager] flushAll];
}


@end
