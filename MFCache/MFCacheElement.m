//
//  MFCacheElement.m
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

#import "MFCacheElement.h"

@implementation MFCacheElement

- (id)initWithKey:(NSString *)key value:(NSObject *)value
{
    self = [super init];
    if (self)
    {
        self.key = key;
        self.value = value;
    }
    return self;
}

- (void)setTimeToLive:(NSTimeInterval)expiration
{
    if (expiration == 0) self.ttl = 0;
    else self.ttl = [NSDate timeIntervalSinceReferenceDate] + expiration;
}

- (BOOL)hasExpired
{
    if (self.ttl == 0) return NO;
    
    NSTimeInterval currentTime = [NSDate timeIntervalSinceReferenceDate];
    return (currentTime <= self.ttl);
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.key   forKey:@"key"];
    [aCoder encodeObject:self.value forKey:@"value"];
    [aCoder encodeDouble:self.ttl   forKey:@"ttl"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.key   = [aDecoder decodeObjectForKey:@"key"];
        self.value = [aDecoder decodeObjectForKey:@"value"];
        self.ttl   = [aDecoder decodeDoubleForKey:@"ttl"];
    }
    return self;
}

@end
