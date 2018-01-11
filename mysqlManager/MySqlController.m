//
//  PCSModel.m
//  SZLPCS
//
//  Created by 石智力 on 16/6/3.
//  Copyright © 2016年 upbest. All rights reserved.
//

#import "MySqlController.h"
#import "MySqlDB.h"
#import "MySqlQuery.h"

static MySqlController *_mysqlController;

@interface MySqlController (){


}

@property (nonatomic, strong) MySqlQuery *query;

@end
@implementation MySqlController

+(MySqlController *)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _mysqlController = [[MySqlController alloc] init];
    });
    return _mysqlController;
    
}


- (BOOL)connectToServer:(NSString *)serverName withDbName:(NSString *)dbName
             withSocket:(NSString *)socket withPort:(unsigned int)port
           withUsername:(NSString *)username withPassword:(NSString *)password
{
     db= [[MySqlDB alloc] init];
    
    [db setSocket:socket];
    [db setServerName:serverName];
    [db setDbName:dbName];
    [db setPort:port];
    [db setUserName:username];
    [db setPassword:password];
    if ([db connect]) {
        [self.delegate successConnectSQL];
    }else{
        [self.delegate faildConnectSQL];
    }
    return [db connect];
}

- (NSDictionary *)selectRowsFromTable:(NSString*)tableName{
    NSString *queryString = [NSString stringWithFormat:@"SELECT * FROM %@;", tableName];
    self.query = [[MySqlQuery alloc]init];
    if (![self.query execQuery:queryString toDB:db]) {
        NSLog(@"数据库查询：failed");
    };
    
    NSDictionary *dict = [self.query getResult];
    if (dict) {
        return dict;
    }
    return nil;
}


-(BOOL)updataTable:(NSString *)tableName rowValue:(NSString*)rowValue ColumnValue:(NSString *)colValue withValue:(NSString *)value{

    NSString *updataString = [NSString stringWithFormat:@"UPDATE %@ SET %@=%@ WHERE type=%@", tableName,colValue,value,rowValue];

    NSLog(@"updataString===%@",updataString);
    self.query = [[MySqlQuery alloc]init];
    if ([self.query execQuery:updataString toDB:db]) {
        NSLog(@"数据库更新：success");

        return TRUE;
    };
    return FALSE;
}
-(BOOL)updataTableArr:(NSString *)tableName rowValue:(NSString*)rowValue ColumnValueArr:(NSArray *)colValueArr withValueArr:(NSArray *)valueArr{
    NSMutableString * sqlParams = [NSMutableString string];
    for (int i=0; i<colValueArr.count; i++) {
        NSString * keyAndVal = [NSString stringWithFormat:@"%@=%@,",colValueArr[i],valueArr[i]];
        [sqlParams appendString:keyAndVal];
    }
    NSString * sqlParam = [sqlParams substringToIndex:sqlParams.length-1];
    NSString *updataString = [NSString stringWithFormat:@"UPDATE %@ SET %@ WHERE type=%@", tableName,sqlParam,rowValue];
    
    NSLog(@"updataString===%@",updataString);
    self.query = [[MySqlQuery alloc]init];
    if ([self.query execQuery:updataString toDB:db]) {
        NSLog(@"数据库更新：success");
        
        return TRUE;
    };
    return FALSE;
}
-(BOOL)userMakeTableSQL:(NSString *)sql{
    self.query = [[MySqlQuery alloc]init];
    if ([self.query execQuery:sql toDB:db]) {
        NSLog(@"数据库自定义操作：success");
        return TRUE;
    };
    NSLog(@"数据库自定义操作：failed");
    return FALSE;
}

- (void)disconnect
{
    [db disconnect];
}


@end
