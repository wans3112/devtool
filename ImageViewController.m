//
//  ImageViewController.m
//  ZXingDemo
//
//  Created by wangbin on 14-4-9.
//  Copyright (c) 2014年 Wei. All rights reserved.
//

#import "ImageViewController.h"
#import "UIImage+BlurredFrame.h"

@interface ImageViewController ()

@end

@implementation ImageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithImage:(UIImage *)image{
    
    self=[super init];
    if (self) {
        self.originImage=image;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=YES;
    [[UIApplication sharedApplication] setStatusBarHidden:self.navigationController.navigationBarHidden withAnimation:UIStatusBarAnimationNone];
    self.toolView.backgroundColor=[UIColor colorWithWhite:1.0 alpha:0.5];

    UITapGestureRecognizer *singleTap=[[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)]autorelease];
    [singleTap setNumberOfTapsRequired:1];
    [self.imageView addGestureRecognizer:singleTap];
    
    self.imageView.image=self.originImage;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
      
        self.originImage=[self.originImage applyLightEffectAtFrame:CGRectMake(0, 0, self.originImage.size.width, self.originImage.size.height)];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageView.image=self.originImage;
        });
        
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_imageView release];
    [_toolView release];
    [super dealloc];
}

- (void)viewDidUnload {
    [self setImageView:nil];
    [self setToolView:nil];
    [super viewDidUnload];
}

- (IBAction)saveButtonPressed:(UIButton *)sender {
    [self saveImageToPhotos:self.originImage];
}

- (IBAction)backButtonPressed:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)valueChange:(UISlider *)sender {
    NSLog(@"sender:%f",sender.value);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        self.originImage=[self.originImage applyLightEffectAtFrame:CGRectMake(0, 0, self.originImage.size.width, self.originImage.size.height) withAlpha:sender.value];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageView.image=self.originImage;
        });
    });
}

- (void)saveImageToPhotos:(UIImage*)savedImage
{
    UIImageWriteToSavedPhotosAlbum(savedImage, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
}
// 指定回调方法
- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo
{
//    NSString *msg = nil ;
//    if(error != NULL){
//        msg = @"save image succesed" ;
//    }else{
//        msg = @"save image failed!" ;
//    }
//    [[[[UIAlertView alloc] initWithTitle:nil message:msg delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil] autorelease] show];
}

-(void)handleSingleTap:(UITapGestureRecognizer *)gestureRecognizer{
    self.toolView.hidden=!self.toolView.hidden;
    self.navigationController.navigationBarHidden=self.toolView.hidden;
    [[UIApplication sharedApplication] setStatusBarHidden:self.toolView.hidden withAnimation:UIStatusBarAnimationNone];
}
@end
