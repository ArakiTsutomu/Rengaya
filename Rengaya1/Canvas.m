//
//  Canvas.m
//  Rengaya1
//
//  Created by T on 13/01/20.
//  Copyright (c) 2013年 荒木力. All rights reserved.
//

#import "Canvas.h"

@implementation Canvas
@synthesize canvasImageView;

-(id)init
{
    if ([super init]) {
        [self createImageView];
    }
    return self;
}

-(void)createImageView
{
    canvasImageView = [[UIImageView alloc] init];
    canvasImageView.frame = CGRectMake(0, 0, 320, 420);
    [canvasImageView setBackgroundColor:[UIColor yellowColor]];
    [self addSubview:canvasImageView];
}

//画面に指をタッチした時
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //タッチ開始座標をインスタンス変数touchPointに保持
    UITouch *touch = [touches anyObject];
    touchPoint = [touch locationInView:canvasImageView];
}


//画面に指がタッチされた状態で動かしている時
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    //現在のタッチ座標をローカル変数currentPointに保持
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:canvasImageView];
    
    //描画領域をcanvasの大きさで生成
    UIGraphicsBeginImageContext(canvasImageView.frame.size);
    
    //canvasにセットされている画像(UIImage)を描画
    [canvasImageView.image drawInRect:
     CGRectMake(0, 0, canvasImageView.frame.size.width, canvasImageView.frame.size.height)];
    
    //線の角を丸くする
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    
    //線の太さを指定
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 10.0);
    
    //線の色を指定(RGB)
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 0.0, 0.0, 0.0, 1.0);
    
    //線の描画開始座標をセット
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), touchPoint.x, touchPoint.y);
    
    //線の終了座標をセット
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
    
    //描画の開始〜終了座標まで線を引く
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    
    //描画領域を画像(UIImage)としてcanvasにセット
    canvasImageView.image = UIGraphicsGetImageFromCurrentImageContext();
    
    //描画領域のクリア
    UIGraphicsEndImageContext();
    
    //現在のタッチ座標を次の座標の開始座標にセット
    touchPoint = currentPoint;
}


-(UIImage*)createImage
{
    UIImage *pngImage = canvasImageView.image;
    NSLog(@"ppp%@", pngImage);
    return pngImage;
}

@end
