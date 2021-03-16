//
//  NetworkModel.h
//  TestConroutine
//
//  Created by chengsc on 2021/3/16.
//  Copyright © 2021 chengsc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface MetricsModel : NSObject
@property(nonatomic, strong) NSString *domainIP;
@property(nonatomic, strong) NSString *url;
@property(nonatomic, assign) NSTimeInterval time_DNS;
@property(nonatomic, assign) NSTimeInterval time_TCP;
@property(nonatomic, assign) NSTimeInterval time_Request;
@property(nonatomic, assign) NSTimeInterval time_HTTP;
@property(nonatomic, assign) NSTimeInterval time_Response;
@property(nonatomic, assign) NSTimeInterval taskInterval;

@end

typedef void(^MetricsBlock)(MetricsModel* metrics);


@interface NetworkModel : NSObject

@property(nonatomic, copy) MetricsBlock metricsBlock;

+ (instancetype)sharedModel;
- (void)requestWithMethod:(nonnull NSString*)method url:(nonnull NSString*)url params:(nullable NSDictionary*)params;
@end

NS_ASSUME_NONNULL_END
