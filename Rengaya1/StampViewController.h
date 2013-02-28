//
//  StampViewController.h
//  Rengaya1
//
//  Created by T on 13/02/26.
//  Copyright (c) 2013年 荒木力. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StampViewController : UIViewController
{
    NSUserDefaults *ud;
    NSArray *stampArray;
    NSMutableArray *stampMArray;
    UIImageView *imageView;
    int tag;
}

@property NSMutableArray *stampMArray;


@end
