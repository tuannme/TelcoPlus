//
//  HomeViewController.h
//  TelcoPlus
//
//  Created by Nguyễn Mạnh Tuấn on 11/16/15.
//  Copyright © 2015 Nguyễn Mạnh Tuấn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageContentViewController.h"

@interface HomeViewController : UIViewController <UIPageViewControllerDataSource,UICollectionViewDataSource,UICollectionViewDelegate>
//UICollectionViewDataSource

@property (weak, nonatomic) IBOutlet UIBarButtonItem *menubarBtn;
@property (weak, nonatomic) IBOutlet UIView *pageView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;


@property (nonatomic,strong) UIPageViewController *pageViewController;

- (PageContentViewController *)viewControllerAtIndex:(NSUInteger)index;


@end
