//
//  PCSModel.m
//  SZLPCS
//
//  Created by 石智力 on 16/6/3.
//  Copyright © 2016年 upbest. All rights reserved.
//

#import "MySqlQuery.h"
#import "MySqlDB.h"

@implementation MySqlQuery

- (instancetype)init
{
    self = [super init];
    if (self) {
        result = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (BOOL)execQuery:(NSString *)query toDB:(MySqlDB *)db
{
    [result removeAllObjects];
    
    if (mysql_query(db.mysql, query.UTF8String)) {
        [db mysqlError];
        return FALSE;
    }
    
    MYSQL_RES *res = mysql_use_result(db.mysql);
    if (res) {
        const unsigned int num_fields = mysql_num_fields(res);
        MYSQL_FIELD *field;
        NSMutableArray *data = [[NSMutableArray alloc] init];
        char *headers[num_fields];
        for (unsigned int i = 0; (field = mysql_fetch_field(res)); ++i) {
            headers[i] = field->name;
            NSMutableArray *rowData = [[NSMutableArray alloc] init];
            [data addObject:rowData];
        }
        
        MYSQL_ROW row;
        while ((row = mysql_fetch_row(res))) {
            for (unsigned int i = 0; i < [data count]; ++i) {
//                NSString *sField = @(row[i]);
//                [data[i] addObject:sField];

#pragma 我增加的这里
                if (row[i]) {
                    NSString *sField = @(row[i]);
                    [data[i] addObject:sField];
                }else{//无值得话全部存储为0
                    [data[i] addObject:@"0"];
                }
            }
        }
        
        for (unsigned int i = 0; i < [data count]; ++i) {
            result[@(headers[i])] = data[i];
        }
        
        mysql_free_result(res);
    }
    return TRUE;
}

- (NSMutableDictionary *)getResult
{
    return [result copy];
}

@end
