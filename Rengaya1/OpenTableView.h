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
    NSMutableArray *stringArray;
    NSUserDefaults *ud;
    NSString *title;
}

@end
