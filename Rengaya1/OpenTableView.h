//
//  OpenTableView.h
//  Rengaya1
//
//  Created by T on 13/02/06.
//  Copyright (c) 2013年 荒木力. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OpenTableView : UITableViewController<UITableViewDataSource, UITableViewDelegate>
{
    
    UITableViewCell *cell;
    NSMutableArray *stringArray;
    NSUserDefaults *ud;
    NSString *title;
    NSArray *array;
    
    NSArray *paths;
    NSString *documentsDirectory;
    NSString *filePath;
    NSString *imageDir;
    
    NSData *redata;
    UIImage *reimage;
    NSMutableArray *animMArray;
    NSArray *animArray;
}

@end
