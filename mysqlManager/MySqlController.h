//
//  PCSModel.m
//  SZLPCS
//
//  Created by 石智力 on 16/6/3.
//  Copyright © 2016年 upbest. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MySqlDB;
@class MySqlTable;

@protocol ConnectMYSQLDelegate <NSObject>

-(void)successConnectSQL;
@optional
-(void)faildConnectSQL;

@end



@interface MySqlController : NSObject
{
    MySqlDB * db;
}
@property(weak)id<ConnectMYSQLDelegate>delegate;

+(MySqlController *)shareInstance;


- (BOOL)connectToServer:(NSString *)serverName withDbName:(NSString *)dbName
             withSocket:(NSString *)socket withPort:(unsigned int)port
           withUsername:(NSString *)username withPassword:(NSString *)password;

- (NSDictionary *)selectRowsFromTable:(NSString*)tableName;

-(BOOL)updataTable:(NSString *)tableName rowValue:(NSString*)rowValue ColumnValue:(NSString *)colValue withValue:(NSString *)value;

-(BOOL)updataTableArr:(NSString *)tableName rowValue:(NSString*)rowValue ColumnValueArr:(NSArray *)colValueArr withValueArr:(NSArray *)valueArr;

-(BOOL)userMakeTableSQL:(NSString *)sql;

- (void)disconnect;


@end
