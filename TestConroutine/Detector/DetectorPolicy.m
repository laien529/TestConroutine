//
//  DetectorPolicy.m
//  TestConroutine
//
//  Created by chengsc on 2021/3/17.
//  Copyright © 2021 chengsc. All rights reserved.
//

#import "DetectorPolicy.h"
#import "DetectCache.h"

@implementation DetectorPolicy

+ (instancetype)sharedPolicy {
    static dispatch_once_t onceToken;
    static DetectorPolicy *policy;
    dispatch_once(&onceToken, ^{
        policy = [[DetectorPolicy alloc] init];
    });
    return policy;
}

- (void)inputHttprtt:(NSTimeInterval)httprtt {
    [[DetectCache sharedCache] insertDataToTableName:@"httprtt" data:@(httprtt)];
}

- (void)inputThroughput_up:(float)throughput {
    [[DetectCache sharedCache] insertDataToTableName:@"Throughput_up" data:@(throughput)];
}

- (void)inputThroughput_down:(float)throughput {
    [[DetectCache sharedCache] insertDataToTableName:@"Throughput_down" data:@(throughput)];

}

- (void)inputOriginDatas:(DetectDataModel *)detectData {}

@end
