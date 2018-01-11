//
//  PCSModel.m
//  SZLPCS
//
//  Created by 石智力 on 16/6/3.
//  Copyright © 2016年 upbest. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MySqlDB;

@interface MySqlQuery : NSObject
{
    NSMutableDictionary *result;
}

- (BOOL)execQuery:(NSString *)query toDB:(MySqlDB *)db;
- (NSMutableDictionary *)getResult;

@end
