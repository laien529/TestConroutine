//
//  DetectorPolicy.h
//  TestConroutine
//
//  Created by chengsc on 2021/3/17.
//  Copyright © 2021 chengsc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DetectDataModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetectorPolicy : NSObject

+ (instancetype)sharedPolicy;

- (void)inputOriginDatas:(DetectDataModel*)detectData;
- (void)inputHttprtt:(NSTimeInterval)httprtt;
- (void)inputThroughput_up:(float)throughput;
- (void)inputThroughput_down:(float)throughput;

@end

NS_ASSUME_NONNULL_END
