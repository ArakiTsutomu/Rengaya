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
    
    
    canvas = [[Canvas alloc] init];
    canvas.backgroundColor = [UIColor whiteColor];
    canvas.frame = self.view.bounds;
    [self.view addSubview:canvas];    
    SEL selector = @selector(buttonPushed:);
    
    //上のツールバー
    UIToolbar *topToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    topToolBar.tintColor = [UIColor blackColor];
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addView)];
    
        UIBarButtonItem *arrowRight = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:106 target:self action:nil];
    
    UIBarButtonItem *rewindButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRewind target:self
                                                                                  action:nil];
    
    UIBarButtonItem *fastForwardButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward target:self action:nil];
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
    
    UIBarButtonItem *pageCurlButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPageCurl target:self action:@selector(pageCurl)];
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

-(void)addView
{
    save = [[Save alloc] init];
    [save viewDidLoad];
    //[save create];
    [canvas.canvasImageView removeFromSuperview];
    canvas.canvasImageView = [[UIImageView alloc] init];
    canvas.canvasImageView.frame = CGRectMake(0, 0, 320, 420);
    [canvas addSubview:canvas.canvasImageView];
    
    

}


-(void)pageCurl
{
    HGPageScrollView *pageScrollView = [[[NSBundle mainBundle] loadNibNamed:@"HGPageScrollView" owner:self options:nil]
                                        objectAtIndex:0];
    [self.view addSubview:pageScrollView];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
