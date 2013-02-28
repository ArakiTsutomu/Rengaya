//
//  Canvas.h
//  Rengaya1
//
//  Created by T on 13/01/20.
//  Copyright (c) 2013年 荒木力. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Canvas : UIView
{
    NSUserDefaults *ud;
    
    UIImageView *canvasImageView;
    CGPoint touchPoint;
    
    NSMutableArray *lineContainer;
    NSMutableArray *line;
    float penLineWeight;
}


- (UIImage*)createImage;
- (void)undoLine;
-(void)createImageView;

@property UIImageView *canvasImageView;

@end
