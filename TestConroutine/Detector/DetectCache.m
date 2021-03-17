//
//  DetectCache.m
//  TestConroutine
//
//  Created by chengsc on 2021/3/17.
//  Copyright © 2021 chengsc. All rights reserved.
//

#import "DetectCache.h"

@interface DetectCache () {
    NSMutableDictionary *cacheMap;
}

@end

@implementation DetectCache

+ (instancetype)sharedCache {
    static dispatch_once_t onceToken;
    static DetectCache *cache;
    dispatch_once(&onceToken, ^{
        cache = [[DetectCache alloc] init];
    });
    return cache;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        cacheMap = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (NSArray*)fetchDataByTableName:(NSString*)tableName {
    if ([cacheMap objectForKey:tableName]) {
        return [cacheMap objectForKey:tableName];
    }
    return nil;
}

- (void)insertDataToTableName:(NSString*)tableName data:(id)data {
    NSLog(@"Try to insert %@ with %@",tableName, data );
    NSMutableArray *table = [cacheMap objectForKey:tableName];
    if (table) {
        [table addObject:data];
    } else {
        NSMutableArray *newTable = [[NSMutableArray alloc] init];
        [newTable addObject:data];
        [cacheMap setObject:newTable forKey:tableName];
    }
}

- (void)emptyTableByName:(NSString*)tableName {
    NSMutableArray *table = [cacheMap objectForKey:tableName];
    if (table) {
        [table removeAllObjects];
    }
}

@end
