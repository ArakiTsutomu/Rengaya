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
#import "Save.h"
#import "AllImagesViewController.h"
#import "SharedData.h"
#import "StampViewController.h"

NSMutableArray *imageArray;

@interface ViewController ()
{        
    SharedData* sharedData;
}

@end

@implementation ViewController

@synthesize title;


- (void)viewDidLoad
{
    [super viewDidLoad];
    if (ud == NULL) {
        ud = [NSUserDefaults standardUserDefaults];
    }
    [ud removeObjectForKey:@"STAMP"];
//    [ud setInteger:0 forKey:@"COUNT"];
    
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
    
    UIButton *addBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    [addBtn setImage:[UIImage imageNamed:@"PlusBtn.png"] forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(addView) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithCustomView:addBtn];
//    UIButton *addButtonView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
//    [addButtonView setImage:[UIImage imageNamed:@"addbtn.png"] forState:UIControlStateNormal];
//    [addButtonView addTarget:self action:@selector(addView) forControlEvents:UIControlEventTouchDown];
//    
//    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithCustomView:addButtonView];
    
    UIButton *animBtn = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 60.0f, 30.0f)];
    [animBtn setImage:[UIImage imageNamed:@"PlayBtn.png"] forState:UIControlStateNormal];
    [animBtn addTarget:self action:@selector(animation) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *animBarBtn = [[UIBarButtonItem alloc] initWithCustomView:animBtn];
    
    //右向きボタン（戻る）
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [leftBtn setImage:[UIImage imageNamed:@"RegoBtn.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(backImage) forControlEvents:UIControlEventTouchUpInside];
    rewindButton = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    //左向きボタン（進む）
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [rightBtn setImage:[UIImage imageNamed:@"GoBtn.png"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(nextImage) forControlEvents:UIControlEventTouchUpInside];
    fastForwardButton = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    UIBarButtonItem *flexibleSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *BigFlexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    BigFlexible.width += 10;
    UIBarButtonItem *noSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    noSpace.width = -10.8f;
        NSArray *topToolBarItems = [NSArray arrayWithObjects:noSpace, animBarBtn,BigFlexible, rewindButton, fastForwardButton, BigFlexible, addButton,noSpace, nil];
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 0, 60, 44)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:20];
    [topToolBar setItems:topToolBarItems];
    [topToolBar addSubview:titleLabel];
    addButton.tag = 1;
    
    [self.view addSubview:topToolBar];

    //下のツールバー
    bottomToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 420, 320, 44)];
    bottomToolBar.tintColor = [UIColor blackColor];
    bottomToolBar.translucent = NO;
    UIBarButtonItem *settingButton = [[UIBarButtonItem alloc] initWithTitle:@"設定" style:UIBarButtonItemStylePlain target:self action:selector];
    
    UIBarButtonItem *pageCurlButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemUndo target:self action:@selector(undo)];
    UIBarButtonItem *allImages = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPageCurl target:self action:@selector(viewAllImages)];
    
    UIButton *stampB = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [stampB setImage:[UIImage imageNamed:@"stamp.png"] forState:UIControlStateNormal];
    [stampB addTarget:self action:@selector(createStampViewC) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *stampBtn = [[UIBarButtonItem alloc] initWithCustomView:stampB];
    settingButton.tag = 0;
    
    UIButton *penButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [penButton setImage:[UIImage imageNamed:@"color.png"] forState:UIControlStateNormal];
    [penButton addTarget:self action:@selector(penSetting) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *penBarButton = [[UIBarButtonItem alloc] initWithCustomView:penButton];
    /*タブバーボタン　セッティング0*/
    NSArray *buttomToolBarItems = [NSArray arrayWithObjects:settingButton,flexibleSpacer, noSpace, stampBtn,penBarButton,flexibleSpacer, allImages, pageCurlButton, nil];
    [bottomToolBar setItems:buttomToolBarItems];
    [self.view addSubview:bottomToolBar];
    
//    sharedData = [SharedData instance];
//    title = [sharedData getDataForKey:@"TITLE"];
    
    [ud removeObjectForKey:@"ANIME"];
}

+(NSMutableArray*)getImageArray
{
    return imageArray;
}

-(void)buttonPushed:(UIBarButtonItem*)sender
{
    if (sender.tag == 0) {
        Setting *setting = [[Setting alloc] initWithStyle:UITableViewStyleGrouped];
        UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:setting];
        [self presentViewController:navigation animated:YES completion:nil];
    }
}

//配列に入れてImageViewを足していく
-(void)addView
{
//    sharedData = [SharedData instance];
//    title = [sharedData getDataForKey:@"TITLE"];
//        
//    if (title == NULL) {
//        NSLog(@"NULL");
//    }else{
//        NSLog(@"title,%@", title);
//        NSLog(@"count%d",[list count]);
//
//            }
    
    if (canvas.canvasImageView.image != nil) {
        save = [[Save alloc] init];
        image = [canvas createImage];
        NSLog(@"title%@", title);
        if (title == NULL) {
            //[self composeImage];
            imageData = UIImagePNGRepresentation(image);
            reimage = [UIImage imageWithData:imageData];
            [imageArray addObject:reimage];
            [canvas.canvasImageView removeFromSuperview];
            [canvas createImageView];
            imageCount = [ud integerForKey:@"COUNT"];
            imageCount++;
            [ud setInteger:[imageArray count] forKey:@"COUNT"];
            NSLog(@"imagecountaddview:%d",imageCount);
            NSLog(@"imageArray:%d", [imageArray count]);
            [ud setObject:imageData forKey:@"IMAGE"];
            [ud synchronize];
            [save imageDataArray];
            stamp = nil;
        }else{
            imageData = UIImagePNGRepresentation(image);
            reimage = [UIImage imageWithData:imageData];
            [animMArray addObject:reimage];
            [canvas.canvasImageView removeFromSuperview];
            [canvas createImageView];
            imageCount = [ud integerForKey:@"COUNT"];
            imageCount++;
            [ud setInteger:[animMArray count] forKey:@"COUNT"];
            NSLog(@"imagecountaddview:%d",imageCount);
            NSLog(@"imageArray:%d", [imageArray count]);
            //[ud setObject:imageData forKey:@"IMAGE"];
           // [save imageDataArray];

            [self getImageFromTitle];
            //ここまで 今入っているフォルダの名前やimageの数を得る
            int nextImage = [list count];
            componentName = [NSString stringWithFormat:@"image%d.png", nextImage];
            
            //  PNG保存
            filePath = [imageDir stringByAppendingPathComponent:componentName];
            [imageData writeToFile:filePath atomically:YES];
            reimage = [UIImage imageWithData:imageData];
            
            NSArray *addAfterArray = [ud arrayForKey:@"ANIME"];
            addAfterMArray = [[NSMutableArray alloc] init];
            [addAfterMArray addObjectsFromArray:addAfterArray];
            [addAfterMArray addObject:imageData];
            //[animMArray addObjectsFromArray:addAfterMArray];
            [ud setObject:addAfterMArray forKey:@"ANIME"];
            
            if (addAfterMArray != NULL) {
                //            [animMArray addObjectsFromArray:addAfterMArray];
                //            [addAfterMArray removeAllObjects];
                //animMArrayにaddAfterMArrayを入れてその後addafterarrayを加えた後のanimmarrayをどこかのudに入れる？
                
//                [ud setObject:animMArray forKey:@"PREVIEW"];
            }
            
            [ud synchronize];
            addAfterArray = nil;
            [addAfterMArray removeAllObjects];

            //animMArrayにaddAfterMArrayを入れてその後addafterarrayを加えた後のanimmarrayをどこかのudに入れる？
            //今animmarrayが空になっている？
            
            
//            NSArray *previewArray = [ud arrayForKey:@"PREVIEW"];
//            NSMutableArray *previewMArray = [[NSMutableArray alloc] init];
//            [previewMArray addObjectsFromArray:previewArray];
//            [previewMArray addObject:animMArray];
//            
//            [ud setObject:previewMArray forKey:@"PREVIEW"];

        }
    }
}

-(void)overWright
{
    canvas = [[Canvas alloc] init];
    image = [canvas createImage];
    if (title == nil) {
        
    }
}


//-(void)composeImage
//{
//    int widthA = CGImageGetWidth(image.CGImage);
//    int widthB = CGImageGetWidth(stamp.CGImage);
//    int height = CGImageGetWidth(image.CGImage);
//    int width = CGImageGetWidth(image.CGImage);
//    
//    //CGContextを作成
//    int widthC = widthA + widthB;
//    unsigned char *bitmap = malloc(widthC*height*sizeof(unsigned char)*4);
//    CGContextRef bitmapContext = CGBitmapContextCreate(bitmap,
//                                                       widthA,
//                                                       height,
//                                                       8,
//                                                       width*4,
//                                                       CGColorSpaceCreateDeviceRGB(),
//                                                       kCGImageAlphaPremultipliedFirst);
//    //imageAをbitmapContextに描画
//    CGContextDrawImage(bitmapContext, CGRectMake(imageView.frame.origin.x, imageView.frame.origin.y, widthA, height), image.CGImage);
//    //imageBを描画
//    CGContextDrawImage(bitmapContext, CGRectMake(stampImageView.frame.origin.x, stampImageView.frame.origin.y, stampImageView.frame.size.width, stampImageView.frame.size.height), stamp.CGImage);
//    
//    //CGContextからCGImageを作成
//    CGImageRef imgRef = CGBitmapContextCreateImage (bitmapContext);
//    
//    //CGImageからUIImageを作成
//    composeImage = [UIImage imageWithCGImage:imgRef];
//    
//    //bitmapを解放（paellaさんのコメントを受けて追記）
//}


-(void)deleteImageArray
{
    NSLog(@"pre%@", imageArray);
    [imageArray removeAllObjects];
    NSLog(@"after%@", imageArray);
}

-(void)newDraw
{
    [self deleteImageArray];
}

-(void)animation
{
    if (canvas.canvasImageView.image != nil) {
        [self addView];
    }
    NSLog(@"animmaaraycount%d", [animMArray count]);
    if ([animMArray count] == 0) {
        if ([animImageView isAnimating]) {
            [animImageView stopAnimating];
            [animImageView removeFromSuperview];
        }else{
            animImageView = [[UIImageView alloc] init];
//            animImageView.contentMode = UIViewContentModeScaleAspectFit;
            animImageView.frame = CGRectMake(0, 44, 320, 377);
            [self.view addSubview:animImageView];
            [animImageView setAnimationImages:imageArray];
            [animImageView setAnimationDuration:[imageArray count]/2];
            [animImageView setAnimationRepeatCount:1];
            [animImageView startAnimating];
        }
    }else{
       //[self deleteImageArray];
        
        
        if ([animImageView isAnimating]) {
            [animImageView stopAnimating];
            [animImageView removeFromSuperview];
        }else{
            animImageView = [[UIImageView alloc] init];
            animImageView.frame = CGRectMake(0, 44, 320, 377);
            [self.view addSubview:animImageView];
            [animImageView setAnimationImages:animMArray];
            [UIView setAnimationCurve:UIViewAnimationCurveLinear];
            [animImageView setAnimationDuration:[animMArray count]/2];
            [animImageView setAnimationRepeatCount:1];
            [animImageView startAnimating];
        }
    }
}

-(void)makeAnimeArray
{
    animMArray = [[NSMutableArray alloc] init];
    animArray = [ud objectForKey:@"ANIME"];
    
    for (int i = 0; i < [animArray count]; i++) {
        NSLog(@"animArray :%d", i);
        NSData *redata = [animArray objectAtIndex:i];
        reimage = [UIImage imageWithData:redata];
        [animMArray addObject:reimage];
        
        NSLog(@"filename%@",[animMArray objectAtIndex:i]);
    }
//    if ([animMArray objectAtIndex:3]) {
//        NSLog(@"filename%@",[animMArray objectAtIndex:3]);
//
//    }

    NSLog(@"%@", animMArray);
}

-(void)nextImage
{
    if (title == nil) {
        if (imageCount >= [imageArray count] - 1 || [imageArray count] == 0) {
            imageCount = [imageArray count];
            [canvas.canvasImageView removeFromSuperview];
            [canvas createImageView];
            return;
        }
        imageCount++;
        [canvas.canvasImageView removeFromSuperview];
        [canvas createImageView];
        [canvas.canvasImageView setImage:[imageArray objectAtIndex:imageCount]];
        NSLog(@"%d",imageCount);
        NSLog(@"%d",[imageArray count]);
    }else{
        if (imageCount >= [animMArray count] - 1 || [animMArray count] == 0) {
            imageCount = [animMArray count];
            [canvas.canvasImageView removeFromSuperview];
            [canvas createImageView];
            return;
        }
        imageCount++;
        [canvas.canvasImageView removeFromSuperview];
        [canvas createImageView];
        [canvas.canvasImageView setImage:[animMArray objectAtIndex:imageCount]];
        NSLog(@"%d",imageCount);
        NSLog(@"%d",[imageArray count]);
    }
}

-(void)backImage
{
    NSLog(@"%@", title);

    if (title == nil) {
        if (imageCount < 1) {
            return;
        }
        imageCount--;
        [canvas.canvasImageView removeFromSuperview];
        [canvas createImageView];
        [canvas.canvasImageView setImage:[imageArray objectAtIndex:imageCount]];
        NSLog(@"%d",imageCount);
        NSLog(@"%d", [imageArray count]);
    }else{
        if (imageCount < 1) {
            
            return;
        }
        imageCount--;
        [canvas.canvasImageView removeFromSuperview];
        [canvas createImageView];
        [canvas.canvasImageView setImage:[animMArray objectAtIndex:imageCount]];
        NSLog(@"%d",imageCount);
        NSLog(@"%d", [animMArray count]);

    }
}

-(void)viewAllImages
{
    AllImagesViewController *allimagesVcr = [[AllImagesViewController alloc] init];    
    UINavigationController *navcon = [[UINavigationController alloc] initWithRootViewController:allimagesVcr];
    [self presentViewController:navcon animated:YES completion:nil];
}

-(void)createStampViewC
{
    stampViewC = [[StampViewController alloc] init];
    UINavigationController *navcon = [[UINavigationController alloc] initWithRootViewController:stampViewC];
    [self presentViewController:navcon animated:YES completion:nil];
}

-(void)putStamp
{
   
}

- (void)undo
{
    [canvas undoLine];
}

-(void)createLabel
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    label.backgroundColor = [UIColor blackColor];
    [self.view addSubview:label];
}

//-(void)list
//{
//    //今入っているフォルダの名前やimageの数を得る
//    ud = [NSUserDefaults standardUserDefaults];
//    paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    documentsDirectory = [paths objectAtIndex:0];
//    
//    title = [ud objectForKey:@"DIRECTRY"];
//    NSLog(@"directrytitile%@", title);
//    
//    NSString *fileName = [NSString stringWithFormat:@"%@",title];
//    
//    imageDir = [documentsDirectory stringByAppendingPathComponent:fileName];
//    NSError *error = nil;
//    list = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:imageDir error:&error];
//    printf("list images\n");
//    for (NSString* name in list) {
//        printf("%s\n", [name UTF8String]);
//    }
//    NSLog(@"listcount%d", [list count] - 2);
//    //ここまで 今入っているフォルダの名前やimageの数を得る
//}   


//penViewを出したり消したり
-(void)penSetting
{
    if (penFlg == 0) {
        penFlg = 1;
    }else{
        penFlg = 0;
    }
        
    if(penFlg == 1){
        penSetting = [[PenViewSetting alloc] init];
        penSetting.frame = CGRectMake(10, 55, 300, 350);
        [self.view addSubview:penSetting];
    }else{
        [penSetting removeFromSuperview];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    
    if (ud == NULL) {
        ud = [NSUserDefaults standardUserDefaults];
    }
    
    [self makeAnimeArray];
    
    if ([ud objectForKey:@"STAMP"]) {
        stamp = [UIImage imageWithData:[ud objectForKey:@"STAMP"]];
        [canvas.canvasImageView setImage:stamp];
//        stampImageView = [[UIImageView alloc] initWithImage:stamp];
//        stampImageView.frame = CGRectMake(100, 100, 100, 100);
//        [canvas.canvasImageView addSubview:stampImageView];
    }
    
    [ud removeObjectForKey:@"STAMP"];
    
    NSInteger i = [ud objectForKey:@"CREATEFLG"];
    if (i != 0) {
        [canvas.canvasImageView removeFromSuperview];
        [canvas createImageView];
    }
    [ud removeObjectForKey:@"CREATEFLG"];
    
    title = [ud objectForKey:@"GETTITLE"];
    NSLog(@"title%@",title);
    
    [titleLabel setText:title];
    
    [self setImageCount];
    
    
}

-(void)setImageCount
{
    //画像を戻る進むのカウント
    if (title ==nil) {
        [ud setInteger:[imageArray count] forKey:@"COUNT"];
    }else{
        [ud setInteger:[animMArray count] forKey:@"COUNT"];
        NSLog(@"animmarray%d", [animMArray count]);
    }
    imageCount = [ud integerForKey:@"COUNT"];

}

-(void)deleteTitle
{
    [ud removeObjectForKey:@"GETTITLE"];
}

-(void)getImageFromTitle
{
    //今入っているフォルダの名前やimageの数を得る
    ud = [NSUserDefaults standardUserDefaults];
    paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    documentsDirectory = [paths objectAtIndex:0];
    
    NSLog(@"directrytitile%@", title);
    
    NSString *fileName = [NSString stringWithFormat:@"%@",title];
    
    imageDir = [documentsDirectory stringByAppendingPathComponent:fileName];
    NSError *error = nil;
    list = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:imageDir error:&error];
    printf("list images\n");
    for (NSString* name in list) {
        printf("%s\n", [name UTF8String]);
    }
    NSLog(@"%@", [list objectAtIndex:3]);

    NSLog(@"listcount%d", [list count] - 1);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
