//
//  StampViewController.m
//  Rengaya1
//
//  Created by T on 13/02/26.
//  Copyright (c) 2013年 荒木力. All rights reserved.
//

#import "StampViewController.h"
#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface StampViewController ()

@end

@implementation StampViewController
@synthesize stampMArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor = [UIColor whiteColor];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonItemStylePlain target:self action:@selector(done)];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    UIScrollView *sv = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:sv];
    
    UIImage *stampImage0 = [UIImage imageNamed:@"0.png"];
    UIImage *stampImage1 = [UIImage imageNamed:@"1.png"];
    UIImage *stampImage2 = [UIImage imageNamed:@"2.png"];
    UIImage *stampImage3 = [UIImage imageNamed:@"3.png"];
    UIImage *stampImage4 = [UIImage imageNamed:@"4.png"];
    UIImage *stampImage5 = [UIImage imageNamed:@"5.png"];
    UIImage *stampImage6 = [UIImage imageNamed:@"6.png"];
    UIImage *stampImage7 = [UIImage imageNamed:@"7.png"];
    UIImage *stampImage8 = [UIImage imageNamed:@"8.png"];
    UIImage *stampImage9 = [UIImage imageNamed:@"9.png"];
    UIImage *stampImage10 = [UIImage imageNamed:@"10.png"];
    UIImage *stampImage11 = [UIImage imageNamed:@"11.png"];
    UIImage *stampImage12 = [UIImage imageNamed:@"12.png"];
    UIImage *stampImage13 = [UIImage imageNamed:@"13.png"];
    UIImage *stampImage14 = [UIImage imageNamed:@"14.png"];
    UIImage *stampImage15 = [UIImage imageNamed:@"15.png"];
    UIImage *stampImage16 = [UIImage imageNamed:@"16.png"];
    UIImage *stampImage17 = [UIImage imageNamed:@"17.png"];
    UIImage *stampImage18 = [UIImage imageNamed:@"18.png"];
    UIImage *stampImage19 = [UIImage imageNamed:@"19.png"];
    UIImage *stampImage20 = [UIImage imageNamed:@"20.png"];
    UIImage *stampImage21 = [UIImage imageNamed:@"21.png"];
    UIImage *stampImage22 = [UIImage imageNamed:@"22.png"];
    UIImage *stampImage23 = [UIImage imageNamed:@"23.png"];
    UIImage *stampImage24 = [UIImage imageNamed:@"24.png"];
    UIImage *stampImage25 = [UIImage imageNamed:@"25.png"];



    stampMArray = [[NSMutableArray alloc] init];
    [stampMArray addObject:stampImage0];
    [stampMArray addObject:stampImage1];
    [stampMArray addObject:stampImage2];
    [stampMArray addObject:stampImage3];
    [stampMArray addObject:stampImage4];
    [stampMArray addObject:stampImage5];
    [stampMArray addObject:stampImage6];
    [stampMArray addObject:stampImage7];
    [stampMArray addObject:stampImage8];
    [stampMArray addObject:stampImage9];
    [stampMArray addObject:stampImage10];
    [stampMArray addObject:stampImage11];
    [stampMArray addObject:stampImage12];
    [stampMArray addObject:stampImage13];
    [stampMArray addObject:stampImage14];
    [stampMArray addObject:stampImage15];
    [stampMArray addObject:stampImage16];
    [stampMArray addObject:stampImage17];
    [stampMArray addObject:stampImage18];
    [stampMArray addObject:stampImage19];
    [stampMArray addObject:stampImage20];
    [stampMArray addObject:stampImage21];
    [stampMArray addObject:stampImage22];
    [stampMArray addObject:stampImage23];
    [stampMArray addObject:stampImage24];
    [stampMArray addObject:stampImage25];


    
    int x = 0;
    int y = 0;
    int width = self.view.frame.size.width / 3;
    int height = self.view.frame.size.height / 3;
    tag = 0;
    
    for (int i = 0; i < [stampMArray count]; i++) {
        if (i%3 == 0 && i != 0) {
            x = 0;
            y += height;
        }
        imageView = [[UIImageView alloc] initWithImage:[stampMArray objectAtIndex:i]];
        imageView.frame = CGRectMake(x, y, width, height);
        imageView.tag = tag;
        [sv addSubview:imageView];
        [imageView.layer setBorderWidth:0.5f];
        [imageView.layer setBorderColor:[UIColor blackColor].CGColor];
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(putStamp:)];
        tapGesture.numberOfTapsRequired = 1;
        [imageView addGestureRecognizer:tapGesture];
        tag++;
        
        x += width;
    }
    sv.contentSize = CGSizeMake(self.view.bounds.size.width, ([stampMArray count]/3 + 1)*imageView.frame.size.height + 50);
}

-(void)putStamp:sender
{
    ud = [NSUserDefaults standardUserDefaults];
    
    NSData *imageData = UIImagePNGRepresentation([stampMArray objectAtIndex:[(UITapGestureRecognizer*)sender view].tag]);
    [ud setObject:imageData forKey:@"STAMP"];
    
    ViewController *viewC = [[ViewController alloc] init];
    [viewC putStamp];
    [self dismissViewControllerAnimated:YES completion:nil];    
}

-(void)done
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
