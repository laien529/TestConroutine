//
//  NetDetector.m
//  TestConroutine
//
//  Created by chengsc on 2021/3/16.
//  Copyright © 2021 chengsc. All rights reserved.
//

#import "NetDetector.h"

 NSString * const serviceName = @"NetworkDetect";

@interface NetDetector () {
    NSMutableDictionary *observersMap;
}

@end

@implementation NetDetector

+ (instancetype)sharedDetector {
    static dispatch_once_t onceToken;
    static NetDetector *detector;
    dispatch_once(&onceToken, ^{
        detector = [[NetDetector alloc] init];
    });
    return detector;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        observersMap = [[NSMutableDictionary alloc] init];
        __weak typeof(self) weakSelf = self;
        [[NetworkModel sharedModel] setMetricsBlock:^(MetricsModel * _Nonnull metrics) {
            [weakSelf inputMetricsData:metrics];
        }];
    }
    return self;
}

- (void)inputMetricsData:(MetricsModel*)metrics {
    
//    [[NSNotificationCenter defaultCenter] postNotificationName:serviceName object:metrics];
}

- (void)registService:(id)observer {
    [[NSNotificationCenter defaultCenter] addObserver:observer selector:@selector(statusDidChanged:) name:serviceName object:nil];
    [observersMap setObject:observer forKey:NSStringFromClass(observersMap.class)];
}

@end
