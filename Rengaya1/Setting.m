//
//  Setting.m
//  Rengaya1
//
//  Created by T on 13/01/17.
//  Copyright (c) 2013年 荒木力. All rights reserved.
//

#import "Setting.h"
#import "OpenTableView.h"
#import "ViewController.h"

@interface Setting ()

@end

@implementation Setting
@synthesize indexPathFlg;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonItemStylePlain target:self action:@selector(endSetting)];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    //self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    //self.navigationItem.rightBarButtonItem = self.editButtonItem;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"保存";

        }else if(indexPath.row == 1){
            cell.textLabel.text = @"開く";
        }else if(indexPath.row == 2){
            cell.textLabel.text = @"新規作成";
        }
    }
    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


-(void)endSetting
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            ud = [NSUserDefaults standardUserDefaults];
            NSString *titleCheck;
            titleCheck = [ud objectForKey:@"GETTITLE"];
            NSLog(@"TITL%@",titleCheck);
            if (titleCheck == NULL){
                Save *save = [[Save alloc]
                              initWithStyle:UITableViewStyleGrouped];
                [self.navigationController pushViewController:save animated:YES];
            }else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                                message:@"新規作成をしてから保存してください"
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];
            }
        }else if (indexPath.row == 1){
            OpenTableView *openTableView = [[OpenTableView alloc]
                                initWithStyle:UITableViewStylePlain];
            [self.navigationController pushViewController:openTableView animated:YES];
        }else if (indexPath.row == 2){
            ud = [NSUserDefaults standardUserDefaults];
            [ud removeObjectForKey:@"ANIME"];
            [ud removeObjectForKey:@"PREVIEW"];
            [ud removeObjectForKey:@"DIRECTRY"];
            [ud removeObjectForKey:@"GETTITLE"];
            
            [ud synchronize];
            ViewController *viewC = [[ViewController alloc] init];
            [viewC deleteImageArray];
            
            [self dismissViewControllerAnimated:YES completion:nil];

        }
    }
}



//-(void)list
//{
//    
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
//    
//    NSError *error = nil;
//    NSArray* list = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:imageDir error:&error];
//    printf("list images\n");
//    for (NSString* name in list) {
//        printf("%s\n", [name UTF8String]);
//    }
//    NSLog(@"listcount%d", [list count] - 2);
//    //ここまで 今入っているフォルダの名前やimageの数を得る
//    
//}



@end
