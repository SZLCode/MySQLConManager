//
//  PCSModel.m
//  SZLPCS
//
//  Created by 石智力 on 16/6/3.
//  Copyright © 2016年 upbest. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "mysql.h"

@interface MySqlDB : NSObject
{
    MYSQL *mysql;
}

@property (nonatomic, strong) NSString  *socket;
@property (nonatomic, strong) NSString  *serverName;
@property (nonatomic, strong) NSString  *dbName;
@property                 unsigned int  port;
@property (nonatomic, strong) NSString  *userName;
@property (nonatomic, strong) NSString  *password;

@property (readonly)          MYSQL     *mysql;

- (BOOL)connect;
- (void)disconnect;
- (void)mysqlError;
- (BOOL)isConnected;

@end
