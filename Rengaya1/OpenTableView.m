//
//  OpenTableView.m
//  Rengaya1
//
//  Created by T on 13/02/06.
//  Copyright (c) 2013年 荒木力. All rights reserved.
//

#import "OpenTableView.h"
#import "Save.h"
#import "ViewController.h"

@interface OpenTableView ()

@end

@implementation OpenTableView

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    if (ud == NULL) {
        ud = [NSUserDefaults standardUserDefaults];
    }
    
    //テキストフィールドに入力された@"TITLE"を開くセルに追加する
    stringArray = [NSMutableArray array];
    array = [ud arrayForKey:@"ARRAY"];
    NSLog(@"array%@", stringArray);
    title = [ud objectForKey:@"TITLE"];
    NSLog(@"%@", title);
    [stringArray addObjectsFromArray:array];

    if (![stringArray containsObject:title]) {
        [stringArray addObject:title];
        [ud setObject:stringArray forKey:@"ARRAY"];
    }
            
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
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
    return [stringArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    cell.textLabel.text = [stringArray objectAtIndex:indexPath.row];

    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        
        [stringArray removeObjectAtIndex:indexPath.row];
        [ud setObject:stringArray forKey:@"ARRAY"];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"titletext%@", [stringArray objectAtIndex:indexPath.row]);
//    
    ud = [NSUserDefaults standardUserDefaults];
    paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    documentsDirectory = [paths objectAtIndex:0];
    
    NSString *fileName = [NSString stringWithFormat:@"%@", [stringArray objectAtIndex:indexPath.row]];
    
    imageDir = [documentsDirectory stringByAppendingPathComponent:fileName];
    
    NSError *error = nil;
    NSArray* list = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:imageDir error:&error];
    
    [ud removeObjectForKey:@"ANIME"];

    for (int i = 0; i < [list count]; i++) {
        NSString *number = [NSString stringWithFormat:@"image%d.png", i];
        NSString *path = [imageDir stringByAppendingPathComponent:number];
        NSFileManager *filemanager = [NSFileManager defaultManager];
        BOOL success = [filemanager fileExistsAtPath:path];
        if (success) {
            animMArray = [[NSMutableArray alloc] init];
            animArray = [ud arrayForKey:@"ANIME"];
            redata = [[NSData alloc] initWithContentsOfFile:path];
            reimage = [UIImage imageWithData:redata];
            [animMArray addObjectsFromArray:animArray];
            [animMArray addObject:redata];
            [ud setObject:animMArray forKey:@"ANIME"];
            
        }
    }

        [self list];
    /*
     TitleTextField.textのフォルダの中にaaaaというフォルダが出来る。
     NSString *imageFir = [imageDir stringByAppendingPathComponent:@"aaaa"];
     [[NSFileManager defaultManager] createDirectoryAtPath:imageFir withIntermediateDirectories:YES attributes:nil error:&error];
     */
    
    [self dismissViewControllerAnimated:YES completion:nil];

}

-(void)list
{
    NSError *error = nil;
    NSArray* list = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:imageDir error:&error];
    printf("list images\n");
    for (NSString* name in list) {
        printf("%s\n", [name UTF8String]);
    }
    NSLog(@"%d", [list count]);
}

@end
