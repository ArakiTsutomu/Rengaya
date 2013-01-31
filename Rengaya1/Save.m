//
//  Save.m
//  Rengaya1
//
//  Created by T on 13/01/17.
//  Copyright (c) 2013年 荒木力. All rights reserved.
//

#import "Save.h"
#import "Canvas.h"

@interface Save ()

@end

@implementation Save


- (id)initWithStyle:(UITableViewStyle)style selectedIndexPath:(NSIndexPath *)selectedIndexPath
{
    self = [super initWithStyle:style];
    if (self) {
        settingIndexPath = selectedIndexPath;
        documents = [[NSMutableArray alloc] init];
        canvas = [[Canvas alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    canvas = [[Canvas alloc] init];
    [canvas createImage];

    [self fileNames];
    [self save];
    [self create];
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    if ([ud integerForKey:@"NUMBER"] == 0) {
        fileNumber = 0;
    }else{
        fileNumber = [ud integerForKey:@"NUMBER"] + 1;
    }
    NSLog(@"filenumber%d",fileNumber);
}

//Canvasから画像データを受け取る
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    }

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    if (settingIndexPath.section == 0) {
        if (settingIndexPath.row == 0) {
            return 0;
        }else if(settingIndexPath.row == 1){
            //保存のセル
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(save)];
            return 1;
        }
    }else if (settingIndexPath.section == 1){
        if (settingIndexPath.row == 0) {
            return 0;
        }
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            if (settingIndexPath.section == 0) {
                if (settingIndexPath.row == 0) {
                    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 250, 30)];
                    [lbl setText:@"てきすと"];
                    [cell.contentView addSubview:lbl];
                }else if (settingIndexPath.row == 1){
                    //保存画面
                    titleTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 10, 250, 30)];
                    titleTextField.returnKeyType = UIReturnKeyDone;
                    titleTextField.delegate = self;
                    [cell.contentView addSubview:titleTextField];
//                    NSString *titleStr = titleTextField.text;
//                    filename = [NSString stringWithFormat:@"%@",titleStr];
                }
            }
    }
    return cell;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [titleTextField resignFirstResponder];
    return YES;
}

-(NSString*)save
{
    NSString *titleStr = titleTextField.text;
    filename = [NSString stringWithFormat:@"%@",titleStr];
    
    //  Documetsディレクトリのパス取り出し。
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];

    //   Documets/imagesディレクトリのパス作成。
    imageDir = [documentsDirectory stringByAppendingPathComponent:filename];
    NSError* error = nil;

    
    //  Documets/imagesディレクトリ作成。2回目以降は意味の無い作業。
    [[NSFileManager defaultManager] createDirectoryAtPath:imageDir withIntermediateDirectories:YES attributes:nil error:&error];
    
    /*
     TitleTextField.textのフォルダの中にaaaaというフォルダが出来る。
    NSString *imageFir = [imageDir stringByAppendingPathComponent:@"aaaa"];
    [[NSFileManager defaultManager] createDirectoryAtPath:imageFir withIntermediateDirectories:YES attributes:nil error:&error];
     */
    
//    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
//    
//    //filenameの初期化
//    [ud setInteger:fileNumber forKey:@"NUMBER"];
//    fileNumber = [ud integerForKey:@"NUMBER"];
//    
//    [ud synchronize];
//        
//    NSLog(@"kkkk%d", fileNumber);
//        
//    fileNumber++;
//        
//    componentName = [NSString stringWithFormat:@"image%d.png", fileNumber];
//    fileNumberStr = [NSString stringWithFormat:@"%d", fileNumber];
    
    return imageDir;
        
//        imageData = UIImagePNGRepresentation(canvas.image);
//        [[NSUserDefaults standardUserDefaults] setObject:imageData forKey:fileNumberStr];
//        
//        
//        //  PNG保存
//        filePath = [imageDir stringByAppendingPathComponent:componentName];
//        imageData = UIImagePNGRepresentation(canvas.image);
//        [imageData writeToFile:filePath atomically:YES];
//        
    
}

-(NSMutableArray*)create
{
    //imageDirにはパスが入っている
    NSString *filePath;
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    //filenameの初期化
    [ud setInteger:fileNumber forKey:@"NUMBER"];
    fileNumber = [ud integerForKey:@"NUMBER"];
    
    [ud synchronize];
        
    fileNumber++;

    componentName = [NSString stringWithFormat:@"image%d.png", fileNumber];
    fileNumberStr = [NSString stringWithFormat:@"%d", fileNumber];
    
    //  PNG保存
    filePath = [imageDir stringByAppendingPathComponent:componentName];
    UIImage *image;
    [[NSUserDefaults standardUserDefaults] setObject:imageData forKey:fileNumberStr];
    imageData = UIImagePNGRepresentation(image);
    [imageData writeToFile:filePath atomically:YES];
    [imageArray addObject:imageData];

    return imageArray;
}


////画用紙の追加
//-(void)add:(NSMutableDictionary*)document
//{
//    [documents addObject:document];
//}

////ファイル名で指定した画用紙の削除
//-(void)deleateForFileName:(NSString*)fileName
//{
//    NSDictionary *dic = [self documentForFileName:fileName];
//    if (dic) {
//        //見つけた
//        [[NSFileManager defaultManager] removeItemAtPath:[self.imageDir stringByAppendingPathComponent:fileName] error :nil];
//        [documents removeObject:dic];
//    }
//}

-(NSArray*)fileNames
{
    NSMutableArray *fileNames = [NSMutableArray array];
    for (NSDictionary *dic in documents) {
        //ファイル名だけ追加していく
        [fileNames addObject:[dic objectForKey:@"name"]];
    }
    NSLog(@"filenames%@", fileNames);
    return fileNames;
}

////画像ファイルを保存するディレクトリパスを返す
//-(NSString*)imageDir
//{
//    //imagesっていうフォルダをdocumentDirで作ったフォルダの中に作ってる。
//    NSString *path = [self.documentDir stringByAppendingPathComponent:@"images"];
//    [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:0 error:nil];
//    return path;
//}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
