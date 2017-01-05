//
//  NetworkRequest.m
//  项目框架 - by Candy
//
//  Created by Candy on 17/1/5.
//  Copyright © 2017年 Candy. All rights reserved.
//

#import "NetworkRequest.h"

@implementation NetworkRequest

#pragma mark -- 普通POST网络请求
//GET请求
+ (void)startGetRequest:(NSString *)urlString Parameters:(NSDictionary *)parameters DataKey:(NSString *)dataKey CompletionHandler:(RequestCompletion)comletionHandler {
    
}
//POST请求
+ (void)startPostRequest:(NSString *)urlString Parameters:(NSDictionary *)parameters                    DataKey:(NSString *)dataKey CompletionHandler:(RequestCompletion)comletionHandler {
    AFHTTPSessionManager *manager = [self sessionManager];
    [manager POST:[NSString stringWithFormat:@"%@%@",SEVER_URL,urlString] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handlerResponse:responseObject error:nil DataKey:dataKey CompletionHandler:comletionHandler];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self handlerResponse:nil error:error DataKey:dataKey CompletionHandler:comletionHandler];
    }];
}

#pragma mark -- 单文件上传

+ (void)startUploadRequest:(NSString *)urlString ImageUrl:(NSString *)imageUrl Parameters:(NSDictionary *)parameters DataKey:(NSString *)dataKey CompletionHandler:(RequestCompletion)completionHandler {
    
}

#pragma mark -- Private(私有方法)

+ (AFHTTPSessionManager * )sessionManager {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/html",@"text/javascript", nil];
    manager.requestSerializer.timeoutInterval = 15.0;
    return manager;
}

//处理请求
+ (void)handlerResponse:(id)responseObject error:(NSError *)error DataKey:(NSString *)dataKey CompletionHandler:(RequestCompletion)comletionHandler{
    Response * response = [[Response alloc] init];
    if (error) {
        //请求失败
        response.resultDesc = error.localizedDescription;
        if (error.code == NSURLErrorNotConnectedToInternet) {
            response.resultDesc = @"无网络连接";
        } else if (error.code == NSURLErrorTimedOut){
            response.resultDesc = @"网络连接超时";
        }
    } else{
        NSInteger resultCode = [responseObject[@"statusCode"] integerValue];
        if (resultCode == 0) {
            response.success = YES;
            response.resultVaule = responseObject[dataKey];
            response.resultDesc = responseObject[@"msg"];
        }else{
            NSString * message = responseObject[@"msg"];
            if (message) {
                response.resultDesc = message;
            }else{
                response.resultDesc = @"网络请求失败";
            }
        }
        
        if (resultCode == -1) {
            NSString * message = responseObject[@"msg"];
            if (message) {
                response.resultDesc = message;
            } else {
                response.resultDesc = @"token验证失败";
            }
            
        }
    }
    if (comletionHandler) {
        comletionHandler(response);
    }
}



@end
