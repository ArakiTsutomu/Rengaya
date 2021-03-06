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
        ud = [NSUserDefaults standardUserDefaults];
        
    }
    return self;
}

-(void)createImageView
{
    lineContainer = [[NSMutableArray alloc] init];
    canvasImageView = [[UIImageView alloc] init];
//    canvasImageView.contentMode = UIViewContentModeScaleAspectFit;
    canvasImageView.frame = CGRectMake(0, 44, 320, 377);
    [self addSubview:canvasImageView];
}

- (void)undoLine
{
    if ([lineContainer count] > 0) {
        [lineContainer removeLastObject];
        
        canvasImageView.image = nil;
        for (NSArray *requiredLine in lineContainer) {
            
            CGPoint startingPoint = [[requiredLine objectAtIndex:0] CGPointValue];
            for (int i = 0; i < [requiredLine count]; i++) {
                CGPoint endPoint = [[requiredLine objectAtIndex:i] CGPointValue];
                
                UIGraphicsBeginImageContext(canvasImageView.frame.size);
                
                [canvasImageView.image drawInRect:
                 CGRectMake(0, 0, canvasImageView.frame.size.width, canvasImageView.frame.size.height)];
                
                //線の角を丸くする
                CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
                
                //線の太さを指定
                CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 10.0);
                
                //線の色を指定(RGB)
                CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 0.0, 0.0, 0.0, 1.0);
                
                //線の描画開始座標をセット
                CGContextMoveToPoint(UIGraphicsGetCurrentContext(), startingPoint.x, startingPoint.y);
                
                //線の終了座標をセット
                CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), endPoint.x, endPoint.y);
                
                //描画の開始〜終了座標まで線を引く
                CGContextStrokePath(UIGraphicsGetCurrentContext());
                
                //描画領域を画像(UIImage)としてcanvasにセット
                canvasImageView.image = UIGraphicsGetImageFromCurrentImageContext();
                
                //描画領域のクリア
                UIGraphicsEndImageContext();
                
                startingPoint = endPoint;
            }
        }
    }
}

//画面に指をタッチした時
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    line = [[NSMutableArray alloc] init];
    
    //タッチ開始座標をインスタンス変数touchPointに保持
    UITouch *touch = [touches anyObject];
    touchPoint = [touch locationInView:canvasImageView];
    
    [line addObject:[NSValue valueWithCGPoint:touchPoint]];
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
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), [ud floatForKey:@"PENLINEWEIGHT"]);
    
    //線の色を指定(RGB)
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), [ud floatForKey:@"RED"],
                                                              [ud floatForKey:@"GREEN"],
                                                              [ud floatForKey:@"BLUE"],
                                                              1.0);
    
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
    
    [line addObject:[NSValue valueWithCGPoint:touchPoint]];
}

-(void)getcolor
{
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [lineContainer addObject:line];
}

-(UIImage*)createImage
{
    return canvasImageView.image;
    
}
                                     
                                     
@end