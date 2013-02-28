//
//  PenSettingHandler.h
//  Rengaya1
//
//  Created by T on 13/02/25.
//  Copyright (c) 2013年 荒木力. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PenSettingHandler : NSObject
{
    NSMutableDictionary *targetActionDic;
}

-(void)setTarget:(id)target action:(SEL)action forEvent:(int)event;
-(void)sendAction:(int)event sender:(id)sender;

@end
