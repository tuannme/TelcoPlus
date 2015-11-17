//
//  PageContentViewController.h
//  TelcoPlus
//
//  Created by Nguyễn Mạnh Tuấn on 11/16/15.
//  Copyright © 2015 Nguyễn Mạnh Tuấn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageContentViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *bannerImageView;

@property  NSUInteger pageIndex;
@property  (strong,nonatomic) NSString *imageName;

@end
