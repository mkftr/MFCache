MFCache
=======

MFCache is a simple / lightweight Cache API for iOS. It's built on plugin architecture. For example, here's how to cache any data.

``` objective-c

// Save data into cache
NSArray *items = [NSArray array];
[MFCache setValue:items forKey:@"LoadedItems"];

// Save data with expiration time 
[MFCache setValue:items forKey:@"LoadedItems" expiration:60];

// Retrieve data from cache
NSArray *restoredItems = [MFCache valueForKey:@"LoadedItems"];

// Clear
[MFCache flushAll];

```

## How To Get Started

- [Download MFCache](https://github.com/mkftr/MFCache/zipball/master) and try out the included an iPhone example app