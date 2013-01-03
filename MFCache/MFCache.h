//
//  MFCache.h
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

#import <Foundation/Foundation.h>

/**
 * Public Cache API.
 *
 */
@interface MFCache : NSObject

/**
 * Set a value into the cache.
 *
 * @param value Item value.
 */
+ (void)setValue:(NSObject *)value forKey:(NSString *)key;

/**
 * Set a value into the cache.
 *
 * @param value Item value.
 * @param expiration Expiration time in seconds (0 sec means eternity)
 */
+ (void)setValue:(NSObject *)value forKey:(NSString *)key expiration:(NSTimeInterval)expiration;

/**
 * Retrieve a value from the cache.
 *
 * @param key Item key.
 * @return value
 */
+ (NSObject *)valueForKey:(NSString *)key;

/**
 * Retrieve a value from the cache.
 *
 * @param key Item key.
 * @param defaultValue
 * @return value
 */
+ (NSObject *)valueForKey:(NSString *)key default:(NSObject *)defaultValue;

/**
 * Remove a value from the cache.
 *
 * @param key Item key.
 */
+ (void)removeForKey:(NSString *)key;

/**
 * Remove all value from the cache.
 */
+ (void)flushAll;

@end
