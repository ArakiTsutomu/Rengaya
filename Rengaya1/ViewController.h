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

@interface ViewController : UIViewController
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
    
}

//-(NSMutableArray*)imageArray;
-(void)deleteImageArray;
-(void)newDraw;



@end
