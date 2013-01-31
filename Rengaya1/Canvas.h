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
    UIImageView *canvasImageView;
    CGPoint touchPoint;
    NSData *imageData;
    
    //ドキュメントのパス
    NSArray *paths;
    NSString *filePath;
    NSString *imageDir;
    
    NSInteger fileNumber;
    NSString *componentName;
    NSMutableArray *animArray;
    NSString *fileNumberStr;
    NSData *reData;
    UIImageView *animView;
    UIImage *image;
    
}

@property UIImageView *canvasImageView;

-(UIImage*)createImage;

@end
