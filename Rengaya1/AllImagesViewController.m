//
//  AllImagesViewController.m
//  Rengaya1
//
//  Created by T on 13/02/11.
//  Copyright (c) 2013年 荒木力. All rights reserved.
//

#import "AllImagesViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface AllImagesViewController ()

@end

@implementation AllImagesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor = [UIColor grayColor];
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
    
    ud =[NSUserDefaults standardUserDefaults];
    animArray = [ud objectForKey:@"ANIME"];
    int x = 0;
    int y = 0;
    int width = self.view.frame.size.width / 3;
    int height = self.view.frame.size.height / 3;
    int tag = 0;

    
    //animArrayが空だったら保存していないud @"PREVIEW"を表示
    if (animArray != NULL) {
    for (int i = 0; i < [animArray count]; i++) {
        if (i%3 == 0 && i != 0) {
            x = 0;
            y += height;
        }
        NSData *data = [animArray objectAtIndex:i];
        image = [UIImage imageWithData:data];
        imageView = [[UIImageView alloc] initWithImage:image];
        imageView.backgroundColor = [UIColor whiteColor];
        imageView.frame = CGRectMake(x, y, width, height);
        imageView.tag = tag;
        tag++;
        [sv addSubview:imageView];
        [imageView.layer setBorderWidth:1.0f];
        [imageView.layer setBorderColor:[UIColor blackColor].CGColor];
        
        //タップを反応するようにしてタグを渡す
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(getTag:)];
        tapGesture.numberOfTapsRequired = 1;
        [imageView addGestureRecognizer:tapGesture];
        
        x += width;
    }
    }else if (animArray == NULL){
        animArray = [ud arrayForKey:@"PREVIEW"];
        for (int i = 0; i < [animArray count]; i++) {
            if (i%3 == 0 && i != 0) {
                x = 0;
                y += height;
            }
            NSData *data = [animArray objectAtIndex:i];
            image = [UIImage imageWithData:data];
            imageView = [[UIImageView alloc] initWithImage:image];
            imageView.backgroundColor = [UIColor whiteColor];
            imageView.frame = CGRectMake(x, y, width, height);
            imageView.tag = tag;
            tag++;
            [sv addSubview:imageView];
            [imageView.layer setBorderWidth:1.0f];
            [imageView.layer setBorderColor:[UIColor blackColor].CGColor];
            
            //タップを反応するようにしてタグを渡す
            imageView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(getTag:)];
            tapGesture.numberOfTapsRequired = 1;
            [imageView addGestureRecognizer:tapGesture];
            
            x += width;
        }
    }
        sv.contentSize = CGSizeMake(self.view.bounds.size.width, ([animArray count]/3 + 1)*imageView.frame.size.height + 50);
}


-(void)getTag:(id)sender
{
    NSLog(@"age%d", [(UIGestureRecognizer*)sender view].tag);
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
