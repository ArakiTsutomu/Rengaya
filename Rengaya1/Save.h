//
//  Save.h
//  Rengaya1
//
//  Created by T on 13/01/17.
//  Copyright (c) 2013年 荒木力. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Canvas;

@interface Save : UITableViewController<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
{
    UITextField *titleTextField;
    NSIndexPath *settingIndexPath;
    NSString *filename;
    Canvas *canvas;
    NSMutableArray *documents;
    NSInteger fileNumber;
    NSString *fileNumberStr;
    NSString *componentName;
    NSString *fileDir;
    NSString* imageDir;
    NSData *imageData;
    NSMutableArray *imageArray;
    NSString *title;
    
    NSUserDefaults *ud;
    
    NSMutableArray *stringArray;
    
}

- (id)initWithStyle:(UITableViewStyle)style selectedIndexPath:(NSIndexPath *)selectedIndexPath;
-(NSMutableArray*)create;
//@property (nonatomic, strong) NSIndexPath *SettingIndexPath;
@end
