//
//  ViewController.h
//  Rengaya1
//
//  Created by T on 13/01/16.
//  Copyright (c) 2013年 荒木力. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Canvas.h"
#import "Save.h"
#import "PenViewSetting.h"
#import "StampViewController.h"

@interface ViewController : UIViewController<NSObject>
{
    //右向き戻るボタン
    UIBarButtonItem *rewindButton;
    //左向き進むボタン
    UIBarButtonItem *fastForwardButton;
    
    Save *save;
    Canvas *canvas;
    UIImage *image;
//    NSMutableArray *imageArray;
    NSData *imageData;
    NSUserDefaults *ud;
    int imageCount;
    UIImage *canvasImage;
    UIImageView *imageView;
    UIImage *reimage;
    int back;
    int next;
    UIImageView *animImageView;
    NSArray *animArray;
    NSMutableArray *animMArray;
    
    Save *savevc;
    
    NSArray *paths;
    NSString *documentsDirectory;
    NSString *filePath;
    NSString *imageDir;
    
    NSArray *list;
    NSString *title;
    
    NSData *nextData;
    
    NSMutableArray *addAfterMArray;
    NSString *componentName;

    UILabel *titleLabel;
    
    PenViewSetting *penSetting;
    
    int penFlg;
    
    UIToolbar *bottomToolBar;
    
    StampViewController *stampViewC;
    NSData *stampData;
    UIImage *stamp;
    UIImageView *stampImageView;
    
    UIImage *composeImage;
}


+(NSMutableArray*)getImageArray;
-(void)deleteImageArray;
-(void)newDraw;
-(void)createLabel;
-(void)deleteTitle;
-(void)putStamp;




@end
