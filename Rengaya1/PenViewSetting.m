//
//  PenViewSetting.m
//  Rengaya1
//
//  Created by T on 13/02/25.
//  Copyright (c) 2013年 荒木力. All rights reserved.
//

#import "PenViewSetting.h"
#import <QuartzCore/QuartzCore.h>

@implementation PenViewSetting

- (id)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        if (ud == NULL) {
            ud = [NSUserDefaults standardUserDefaults];
        }
        backColor = [[UIColor alloc] initWithRed:0.1 green:0.1 blue:0.1 alpha:0.4];
        self.backgroundColor = backColor;
        
        penSlider = [[UISlider alloc] init];
        penSlider.minimumValue = 1.0;
        penSlider.maximumValue = 30.0;
        penSlider.value = [ud floatForKey:@"PENLINEWEIGHT"];
        penSlider.frame = CGRectMake(10, 30, 200, 10);
        [penSlider addTarget:self action:@selector(drawRect:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:penSlider];
        
        UIView *blackView = [[UIView alloc] initWithFrame:CGRectMake(10, 100, 45, 45)];
        blackView.backgroundColor = [UIColor colorWithHue:1.0 saturation:1.0 brightness:0 alpha:1.0];
        [self addSubview:blackView];
        blackView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(getPenColor:)];
        tapGesture.numberOfTapsRequired = 1;
        [blackView addGestureRecognizer:tapGesture];
        
        CGRect r = CGRectMake(10, 150, 35, 35);
        for (int i = 0; i < 24; i++) {
            bt1 = [[UIView alloc] init];;
            bt1.frame = r;
            bt1.backgroundColor = [UIColor colorWithHue:(float)i/24.0 saturation:1.0 brightness:1.0 alpha:1.0];
            [self addSubview:bt1];
            
            //次の位置を計算
            r.origin.x += r.size.width;
            if (i == 7 || i == 15 || i == 23) {
                r.origin.x = 10;
                r.origin.y += r.size.height;
            }
            
            bt1.tag = tag1;
            tag1++;
            bt1.userInteractionEnabled = YES;
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(getPenColor:)];
            tapGesture.numberOfTapsRequired = 1;
            [bt1 addGestureRecognizer:tapGesture];

        }
        CGRect rb = CGRectMake(10, 255, 35, 35);
        for (int i = 0; i < 16; i++) {
            bt2 = [[UIView alloc] init];
            bt2.frame = rb;
            bt2.backgroundColor = [UIColor colorWithHue:(float)i/16 saturation:0.5 brightness:0.5 alpha:1.0];
            [self addSubview:bt2];
            rb.origin.x += r.size.height;
            if (i == 7 || 1== 15) {
                rb.origin.x = 10;
                rb.origin.y += r.size.height;
            }
            bt2.tag = tag2;
            tag2++;
            bt2.userInteractionEnabled = YES;
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(getPenColor:)];
            tapGesture.numberOfTapsRequired = 1;
            [bt2 addGestureRecognizer:tapGesture];
        }
    }
    return self;
}

-(void)drawRect:(CGRect)rect
{
//    CGContextSetRGBStrokeColor(context, [ud floatForKey:@"RED"],
//                               [ud floatForKey:@"GREEN"],
//                               [ud floatForKey:@"BLUE"],
//                               1.0);

    [self changePenWidth];
    
    [self setNeedsDisplay];

    if (ud == NULL) {
        ud = [NSUserDefaults standardUserDefaults];
    }
    [ud setFloat:penSlider.value forKey:@"PENLINEWEIGHT"];    
}

-(void)changePenWidth
{
    //  描画先情報を得る。
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(context, [ud floatForKey:@"RED"],
                             [ud floatForKey:@"GREEN"],
                             [ud floatForKey:@"BLUE"],
                             1.0);  // 塗りつぶしの色を指定
    //ペンの太さの真円を描く。
    CGContextFillEllipseInRect(context, CGRectMake(250-penSlider.value/2, 35-penSlider.value/2, penSlider.value+3, penSlider.value+3));

}

-(void)getPenColor:(id)sender
{
   // NSLog(@"age%d", [(UIGestureRecognizer*)sender view].tag);
    penColor = [(UIGestureRecognizer*)sender view].backgroundColor;
    const CGFloat* floatPenColor = CGColorGetComponents(penColor.CGColor);
    [ud setFloat:floatPenColor[0] forKey:@"RED"];
    [ud setFloat:floatPenColor[1] forKey:@"GREEN"];
    [ud setFloat:floatPenColor[2] forKey:@"BLUE"];
    [ud synchronize];
    [self changePenWidth];
    NSLog(@"%@", [(UIGestureRecognizer*)sender view].backgroundColor);
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


@end
