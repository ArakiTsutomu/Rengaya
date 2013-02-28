//
//  PenViewSetting.h
//  Rengaya1
//
//  Created by T on 13/02/25.
//  Copyright (c) 2013年 荒木力. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Canvas.h"

@interface PenViewSetting : UIView
{
    NSUserDefaults *ud;
    UIColor *backColor;
    int penFlg;
    UISlider *penSlider;
    int penNum;
    Canvas *canvas;
    
    int tag1;
    int tag2;
    
    UIView *bt1;
    UIView *bt2;
    
    UIColor *penColor;
    
}
@end
