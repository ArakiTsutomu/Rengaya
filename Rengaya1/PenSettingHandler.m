//
//  PenSettingHandler.m
//  Rengaya1
//
//  Created by T on 13/02/25.
//  Copyright (c) 2013年 荒木力. All rights reserved.
//

#import "PenSettingHandler.h"

@interface PenAndAction : NSObject
{
    @public
    id target;
    SEL action;
}
@end
@implementation PenAndAction
@end

@implementation PenSettingHandler
-(id)init
{
    self = [super init];
    if (self) {
        targetActionDic = [[NSMutableDictionary alloc] init];
    }
    return self;
}


-(void)setTarget:(id)target action:(SEL)action forEvent:(int)event
{
    PenAndAction *penAction = [[PenAndAction alloc] init];
    penAction->target = target;
    penAction->action = action;
    NSString *key = [NSString stringWithFormat:@"%d", event];
    [targetActionDic setObject:penAction forKey:key];
}

-(void)sendAction:(int)event sender:(id)sender
{
    NSString *key = [NSString stringWithFormat:@"%d",event];
    PenAndAction *penAction = [targetActionDic objectForKey:key];
    if (penAction) {
       // [penAction->target performSelector:penAction->action withObject:sender];
    }
}
@end
