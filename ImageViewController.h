//
//  ImageViewController.h
//  ZXingDemo
//
//  Created by wangbin on 14-4-9.
//  Copyright (c) 2014年 Wei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageViewController : UIViewController
@property (retain, nonatomic) IBOutlet UIImageView *imageView;
@property (retain, nonatomic) IBOutlet UIView *toolView;
@property (retain, nonatomic) UIImage *originImage;

- (id)initWithImage:(UIImage *)image;
- (IBAction)saveButtonPressed:(UIButton *)sender;
- (IBAction)backButtonPressed:(UIButton *)sender;
- (IBAction)valueChange:(UISlider *)sender;

@end
