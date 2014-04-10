//
//  MainViewController.m
//  ZXingDemo
//
//  Created by wangbin on 14-4-9.
//  Copyright (c) 2014年 Wei. All rights reserved.
//

#import "MainViewController.h"
#import "ViewController.h"
#import "ImageViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController
@synthesize theTableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    theTableView = [[[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320,  CGRectGetHeight(self.view.bounds)) style:UITableViewStyleGrouped]autorelease];
    theTableView.scrollEnabled = YES;
    theTableView.delegate = self;
    theTableView.dataSource = self;
    theTableView.backgroundView.alpha=0.0;
    [self.view addSubview:theTableView];
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=NO;
    [[UIApplication sharedApplication] setStatusBarHidden:self.navigationController.navigationBarHidden withAnimation:UIStatusBarAnimationNone];
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"camerainfoCell2";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
	if (!cell) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
									   reuseIdentifier:identifier] autorelease];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.backgroundColor = [UIColor whiteColor];
    
    switch ([indexPath section]) {
        case 0:
            cell.textLabel.text = @"二维码";
            break;
        case 1:
            cell.textLabel.text = @"高斯模糊";
            break;
        default:
            break;
    }
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.theTableView deselectRowAtIndexPath:indexPath animated:YES];
    switch ([indexPath section]) {
        case 0:
        {
            ViewController *vc=[[[ViewController alloc]init]autorelease];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
        {
            UIImagePickerController *imagePickerController = [[[UIImagePickerController alloc] init]autorelease];
            
            imagePickerController.delegate = self;
            imagePickerController.allowsEditing = NO;
            imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:imagePickerController animated:YES completion:^{}];

        }
            break;
        default:
            break;
    }
}

#pragma mark - image picker delegte
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	[picker dismissViewControllerAnimated:YES completion:^{}];
    
    //    UIImage *savedImage = [info objectForKey:UIImagePickerControllerEditedImage];
    
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    if ([mediaType isEqualToString:@"public.image"]){
        
        //切忌不可直接使用originImage，因为这是没有经过格式化的图片数据，可能会导致选择的图片颠倒或是失真等现象的发生，从UIImagePickerControllerOriginalImage中的Origin可以看出，很原始，哈哈
        UIImage *originImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        
        ImageViewController *vc=[[[ImageViewController alloc]initWithImage:originImage]autorelease];
        [self.navigationController pushViewController:vc animated:YES];
       
    }
    
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
	[self dismissViewControllerAnimated:YES completion:^{}];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
