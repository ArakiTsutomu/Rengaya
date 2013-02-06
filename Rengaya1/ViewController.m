//
//  ViewController.m
//  Rengaya1
//
//  Created by T on 13/01/16.
//  Copyright (c) 2013年 荒木力. All rights reserved.
//

#import "ViewController.h"
#import "Setting.h"
#import "HGPageScrollView.h"

@interface ViewController ()

@end

@implementation ViewController




- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    ud = [NSUserDefaults standardUserDefaults];

    [ud setInteger:0 forKey:@"COUNT"];
    
    //画像をNSDataに変換して入れておくためのarray
    imageArray = [[NSMutableArray alloc] init];

    canvas = [[Canvas alloc] init];
    canvas.backgroundColor = [UIColor whiteColor];
    canvas.frame = self.view.bounds;
    [self.view addSubview:canvas];    
    SEL selector = @selector(buttonPushed:);
    
    //上のツールバー
    UIToolbar *topToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    topToolBar.tintColor = [UIColor blackColor];
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addView)];
    
    UIBarButtonItem *arrowRight = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:106 target:self action:@selector(animation)];
    
    //右向きボタン（戻る）
    rewindButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRewind target:self
                                                                                  action:@selector(backImage)];
    //左向きボタン（進む）
    fastForwardButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward target:self action:@selector(nextImage)];
    UIBarButtonItem *flexibleSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *flexibleSpacer2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    
    NSArray *topToolBarItems = [NSArray arrayWithObjects:arrowRight,flexibleSpacer2, rewindButton, fastForwardButton, flexibleSpacer, addButton, nil];
    [topToolBar setItems:topToolBarItems];
    addButton.tag = 1;
    [self.view addSubview:topToolBar];

    //下のツールバー
    UIToolbar *bottomToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 420, 320, 44)];
    bottomToolBar.tintColor = [UIColor blackColor];
    bottomToolBar.translucent = NO;
    UIBarButtonItem *settingButton = [[UIBarButtonItem alloc] initWithTitle:@"SET" style:UIBarButtonItemStylePlain target:self action:selector];
    
    UIBarButtonItem *pageCurlButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPageCurl target:self action:@selector(undo)];
    UIBarButtonItem *flexibleSpacer3 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    settingButton.tag = 0;
    /*タブバーボタン　セッティング0*/
    NSArray *buttomToolBarItems = [NSArray arrayWithObjects:settingButton,flexibleSpacer3, pageCurlButton, nil];
    [bottomToolBar setItems:buttomToolBarItems];
    [self.view addSubview:bottomToolBar];
    
    }


-(void)buttonPushed:(UIBarButtonItem*)sender
{
    if (sender.tag == 0) {
        Setting *setting = [[Setting alloc] initWithStyle:UITableViewStyleGrouped];
        UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:setting];
        [self presentViewController:navigation animated:YES completion:nil];
    }
}

//imageを配列に入れていく

//配列に入れてImageViewを足していく
-(void)addView
{
    
    if (canvas.canvasImageView.image != nil) {
        save = [[Save alloc] init];
        [save create];
        image = [canvas createImage];
        NSLog(@"image%@",image);
        
        imageData = UIImagePNGRepresentation(image);
        reimage = [UIImage imageWithData:imageData];
        [imageArray addObject:reimage];
        [canvas.canvasImageView removeFromSuperview];
        [canvas createImageView];
        imageCount = [ud integerForKey:@"COUNT"];
        imageCount++;
        [ud setInteger:[imageArray count] forKey:@"COUNT"];
        [ud synchronize];
        NSLog(@"imagecountaddview:%d",imageCount);
        NSLog(@"imageArray:%d", [imageArray count]);
        
        
    }  
}

-(void)animation
{
    if ([animImageView isAnimating]) {
        [animImageView stopAnimating];
        [animImageView removeFromSuperview];
    }else{
        animImageView = [[UIImageView alloc] init];
        animImageView.frame = self.view.bounds;
        [self.view addSubview:animImageView];
        
        [animImageView setAnimationImages:imageArray];
        
        [animImageView setAnimationDuration:2.0];
        [animImageView setAnimationRepeatCount:1];
        [animImageView startAnimating];
    }
    
}

-(void)nextImage
{

//    if (imageArray != nil && canvas.canvasImageView.image != nil) {
//        save = [[Save alloc] init];
//        [save create];
//        image = [canvas createImage];
//        
//        imageData = UIImagePNGRepresentation(image);
//
//        [imageArray addObject:imageData];
//        [canvas createImageView];
//        imageCount = [ud integerForKey:@"COUNT"];
//        imageCount++;
//
//        [ud setInteger:[imageArray count] forKey:@"COUNT"];
//        [ud synchronize];
//        [canvas.canvasImageView removeFromSuperview];
//        NSLog(@"nextimage");
//    }
    
    
    if (imageCount + 1 < [imageArray count] -1) {
        [fastForwardButton setEnabled:NO];
    }
    NSLog(@"aaa%d",[imageArray count]);
    [canvas.canvasImageView removeFromSuperview];
    [canvas createImageView];

    imageCount++;
    NSLog(@"imageCount%d",imageCount);
    NSData *reData = [imageArray objectAtIndex:imageCount];
    reimage = [UIImage imageWithData:reData];
    [canvas.canvasImageView setImage:reimage];

    
        
}

-(void)backImage
{
//    if (imageArray != nil && canvas.canvasImageView.image != nil) {
//        save = [[Save alloc] init];
//        [save create];
//        image = [canvas createImage];
//        
//        imageData = UIImagePNGRepresentation(image);
//        
//        [imageArray addObject:imageData];
//        [canvas createImageView];
//        imageCount = [ud integerForKey:@"COUNT"];
//        imageCount++;
//        [ud setInteger:[imageArray count] forKey:@"COUNT"];
//        [ud synchronize];
//        [canvas.canvasImageView removeFromSuperview];
//        
//        NSLog(@"backimage");
//    }
    if (imageCount < [imageArray count] -1) {
        [rewindButton setEnabled:NO];
    }
        [canvas.canvasImageView removeFromSuperview];
        
        imageCount--;
        NSLog(@"imageCount%d",imageCount);
        [canvas createImageView];
        NSData *reData = [imageArray objectAtIndex:imageCount];
        reimage = [UIImage imageWithData:reData];
        [canvas.canvasImageView setImage:reimage];
    
}


- (void)undo
{
    [canvas undoLine];
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
