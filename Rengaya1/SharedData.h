//
//  SharedData.h
//  Rengaya1
//
//  Created by T on 13/02/14.
//  Copyright (c) 2013年 荒木力. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SharedData : NSObject

+ (id)instance;
- (void)setData:(id)anObject forKey:(id) aKey;
- (id)getDataForKey:(id)aKey;

@end
