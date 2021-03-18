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

struct DetectResult {
    NetDetectStatus status;
    float value;
};
typedef struct DetectResult DetectResult;

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

        DetectResult httprttResult = [self detectHttprtt];
        NetDetectStatus httprttStatus = httprttResult.status;
        
        DetectResult throughputResult = [self detectThroughtput_down];
        NetDetectStatus throughput_downStatus = throughputResult.status;
        
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
        status.httpRtt = @(httprttResult.value);
        status.throughput = @(throughputResult.value);
        _detectResultBlock(status);
        
        NSLog(@"judgeNetworkStatus %lu",(unsigned long)judgedStatus);
    }
}

- (DetectResult)detectHttprtt {
    NSArray *httprttArray = [[DetectCache sharedCache] fetchDataByTableName:table_httprtt];
    if (httprttArray.count > 0) {
        
        float avgHttprtt = [[httprttArray valueForKeyPath:@"@avg.floatValue"] floatValue];
        NetDetectStatus status = [self statusFromHttprttJudge:avgHttprtt];
        DetectResult _result = {status, avgHttprtt};
        return _result;
    }
    return (DetectResult){NetDetectStatusUnknown, 0.0};
}

- (DetectResult)detectThroughtput_down {
    NSArray *throughputArray = [[DetectCache sharedCache] fetchDataByTableName:table_throughput_down];
    if (throughputArray.count > 0) {
        float avgThroughput = [[throughputArray valueForKeyPath:@"@avg.floatValue"] floatValue];

        NetDetectStatus status = [self statusFromThroughputJudge:avgThroughput];
        DetectResult _result = {status, avgThroughput};

        return _result;
    }
    return (DetectResult){NetDetectStatusUnknown, 0.0};
}

- (NetDetectStatus)statusFromHttprttJudge:(float)httprtt {
    if (httprtt == 0) {
        return NetDetectStatusUnknown;
    }
    if (httprtt < 0.3) {
        return NetDetectStatusGreat;
    } else {
        return NetDetectStatusWeak;
    }
}

- (NetDetectStatus)statusFromThroughputJudge:(float)throughput {
    if (throughput == 0) {
        return NetDetectStatusUnknown;
    }
    if (throughput > 0.5) {
        return NetDetectStatusGreat;
    } else {
        return NetDetectStatusWeak;
    }
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
