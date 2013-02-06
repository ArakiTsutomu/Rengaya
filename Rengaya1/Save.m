//
//  Save.m
//  Rengaya1
//
//  Created by T on 13/01/17.
//  Copyright (c) 2013年 荒木力. All rights reserved.
//

#import "Save.h"
#import "Canvas.h"
#import "Setting.h"
#import "OpenTableView.h"

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
        stringArray = [[NSMutableArray alloc] init];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self fileNames];
    
    if (!stringArray) {
        stringArray = [[NSMutableArray alloc] init];
    }
    
    self.tableView.delegate = self;
    
    if (ud == NULL) {
        ud = [NSUserDefaults standardUserDefaults];
    }
        
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
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            if (indexPath.section == 0) {
                if (indexPath.row == 0) {
                    //保存画面
                    titleTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 10, 250, 30)];
                    titleTextField.returnKeyType = UIReturnKeyDone;
                    titleTextField.delegate = self;
                    [cell.contentView addSubview:titleTextField];
                    
                    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(save)];
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

-(void)save
{
    NSString *titleStr = titleTextField.text;
    filename = [NSString stringWithFormat:@"%@",titleStr];
    
    ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:filename forKey:@"TITLE"];
    title = [ud stringForKey:@"TITLE"];
    
    //  Documetsディレクトリのパス取り出し。
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];

    //   Documets/imagesディレクトリのパス作成。
    imageDir = [documentsDirectory stringByAppendingPathComponent:filename];
    NSError* error = nil;
    
    //  Documets/imagesディレクトリ作成。2回目以降は意味の無い作業。
    [[NSFileManager defaultManager] createDirectoryAtPath:imageDir withIntermediateDirectories:YES attributes:nil error:&error];
    
    
    
    [self create];
    
//    [stringArray addObject:title];
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:stringArray.count inSection:0];
//    NSArray *indexPaths = [NSArray arrayWithObjects:indexPath,nil];
//    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
//    

    
    
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
    
        
//        imageData = UIImagePNGRepresentation(canvas.image);
//        [[NSUserDefaults standardUserDefaults] setObject:imageData forKey:fileNumberStr];
//        
//        
//        //  PNG保存
//        filePath = [imageDir stringByAppendingPathComponent:componentName];
//        imageData = UIImagePNGRepresentation(canvas.image);
//        [imageData writeToFile:filePath atomically:YES];
//
    
    //[self.navigationController popViewControllerAnimated:YES];
}


-(NSMutableArray*)create
{
    canvas = [[Canvas alloc] init];
    UIImage *image = [canvas createImage];
    //imageDirにはパスが入っている
    NSString *filePath;
    
    //filenameの初期化
    [ud setInteger:fileNumber forKey:@"NUMBER"];
    fileNumber = [ud integerForKey:@"NUMBER"];
    [ud synchronize];
        
    componentName = [NSString stringWithFormat:@"image%d.png", fileNumber];
    fileNumberStr = [NSString stringWithFormat:@"%d", fileNumber];
        
    //  PNG保存
    filePath = [imageDir stringByAppendingPathComponent:componentName];
    
    [[NSUserDefaults standardUserDefaults] setObject:imageData forKey:fileNumberStr];
    imageData = UIImagePNGRepresentation(image);
    [imageData writeToFile:filePath atomically:YES];
    [imageArray addObject:imageData];
    
    fileNumber++;
    //プラスした数字を格納
    [ud setInteger:fileNumber forKey:@"NUMBER"];
    
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

//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (settingIndexPath.section == 0) {
//        if (settingIndexPath.row == 1) {
//            OpenTableView *openTableView = [[OpenTableView alloc] initWithStyle:UITableViewStylePlain];
//            [self.navigationController pushViewController:openTableView animated:YES];
//            NSLog(@"aaa");
//        }
//    }
//}


@end
