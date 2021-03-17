//
//  DetectorPolicy.m
//  TestConroutine
//
//  Created by chengsc on 2021/3/17.
//  Copyright © 2021 chengsc. All rights reserved.
//

#import "DetectorPolicy.h"
#import "DetectCache.h"

@implementation NetStatus

@end

NSTimeInterval const triggerInterval = 10; //seconds 下发触发间隔
NSString* const table_httprtt = @"httprtt";
NSString* const table_throughput_down = @"Throughput_down";
NSString* const table_throughput_up = @"Throughput_up";

@interface DetectorPolicy () {
    NSTimer *triggerTimer;
}

@end

@implementation DetectorPolicy

+ (instancetype)sharedPolicy {
    static dispatch_once_t onceToken;
    static DetectorPolicy *policy;
    dispatch_once(&onceToken, ^{
        policy = [[DetectorPolicy alloc] init];
    });
    return policy;
}

- (instancetype)init {
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)startDetectTrigger {
    triggerTimer = [NSTimer scheduledTimerWithTimeInterval:triggerInterval repeats:YES block:^(NSTimer * _Nonnull timer) {
        [self judgeNetworkStatus];
    }];
    [triggerTimer fire];
}

- (void)stopDetectTrigger {
    [triggerTimer invalidate];
}

- (void)judgeNetworkStatus {
    
    if (_detectResultBlock) {
        
        NetStatus *status = [[NetStatus alloc] init];
        NetDetectStatus judgedStatus = NetDetectStatusUnknown;
        
        NetDetectStatus httprttStatus = [self detectHttprtt];
        NetDetectStatus throughput_downStatus = [self detectThroughtput_down];
        
        if (httprttStatus == NetDetectStatusGreat && throughput_downStatus == NetDetectStatusGreat) {
            judgedStatus = NetDetectStatusGreat;
        } else if (httprttStatus == NetDetectStatusWeak || throughput_downStatus == NetDetectStatusWeak) {
            judgedStatus = NetDetectStatusWeak;
        } else if (httprttStatus == NetDetectStatusUnknown || throughput_downStatus == NetDetectStatusUnknown){
            judgedStatus = NetDetectStatusUnknown;
        } else {
            judgedStatus = NetDetectStatusNormal;
        }
        status.netStatus = judgedStatus;
//        status.httpRtt = htt
        _detectResultBlock(status);
    }
}

- (NetDetectStatus)detectHttprtt {
    NSArray *httprttArray = [[DetectCache sharedCache] fetchDataByTableName:table_httprtt];
    if (httprttArray.count > 0) {
        float avgHttprtt = [[httprttArray valueForKeyPath:@"avg.floatValue"] floatValue];
        NetDetectStatus status = [self statusFromHttprttJudge:avgHttprtt];
        return status;
    }
    return NetDetectStatusUnknown;
}

- (NetDetectStatus)detectThroughtput_down {
    NSArray *throughputArray = [[DetectCache sharedCache] fetchDataByTableName:table_throughput_down];
    if (throughputArray.count > 0) {
        float avgThroughput = [[throughputArray valueForKeyPath:@"avg.floatValue"] floatValue];
        NetDetectStatus status = [self statusFromHttprttJudge:avgThroughput];
        return status;
    }
    return NetDetectStatusUnknown;
}

- (NetDetectStatus)statusFromHttprttJudge:(float)httprtt {
    return NetDetectStatusGreat;
}

- (void)inputHttprtt:(NSTimeInterval)httprtt {
    [[DetectCache sharedCache] insertDataToTableName:table_httprtt data:@(httprtt)];
}

- (void)inputThroughput_up:(float)throughput {
    [[DetectCache sharedCache] insertDataToTableName:table_throughput_up data:@(throughput)];
}

- (void)inputThroughput_down:(float)throughput {
    [[DetectCache sharedCache] insertDataToTableName:table_throughput_down data:@(throughput)];
}

- (void)inputOriginDatas:(DetectDataModel *)detectData {}

@end
