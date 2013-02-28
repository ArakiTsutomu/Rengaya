//
//  SharedData.m
//  Rengaya1
//
//  Created by T on 13/02/14.
//  Copyright (c) 2013年 荒木力. All rights reserved.
//

#import "SharedData.h"

@implementation SharedData
{
    NSMutableDictionary* dictionary;
}

// 初期化
- (id)init
{
    self =  [super init];
    if(self) {
        dictionary = [[NSMutableDictionary alloc] init];
    }
    return self;
}

// インスタンスの取得（外部のクラスからはこれを呼ぶ）
+ (id)instance
{
    static id _instance = nil;
    @synchronized(self) {
        if(!_instance) {
            _instance = [[self alloc] init];
        }
    }
    return _instance;
}

// データをキーとともに追加
- (void)setData:(id) anObject forKey:(id) aKey
{
    @synchronized(dictionary) {
        [dictionary setObject:anObject forKey:aKey];
    }
}

// 指定したキーに対応するデータを返す
- (id)getDataForKey:(id)aKey
{
    id retval = [dictionary objectForKey:aKey];
    return retval != [NSNull null] ? retval : nil;
}


@end
