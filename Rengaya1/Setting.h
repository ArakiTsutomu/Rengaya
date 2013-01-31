//
//  Setting.h
//  Rengaya1
//
//  Created by T on 13/01/17.
//  Copyright (c) 2013年 荒木力. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Save.h"

@interface Setting : UITableViewController<UITableViewDataSource, UITableViewDelegate>
{
    int indexPathFlg;
}

@property int indexPathFlg;
 
@end
