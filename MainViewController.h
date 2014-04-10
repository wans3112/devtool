//
//  MainViewController.h
//  ZXingDemo
//
//  Created by wangbin on 14-4-9.
//  Copyright (c) 2014年 Wei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, retain) UITableView *theTableView;

@end
