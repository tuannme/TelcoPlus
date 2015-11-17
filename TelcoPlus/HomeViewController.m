//
//  HomeViewController.m
//  TelcoPlus
//
//  Created by Nguyễn Mạnh Tuấn on 11/16/15.
//  Copyright © 2015 Nguyễn Mạnh Tuấn. All rights reserved.
//

#import "HomeViewController.h"
#import "SWRevealViewController.h"
#import "PageContentViewController.h"

@interface HomeViewController (){

}

@end

@implementation HomeViewController{
    UIPageControl *pageControl;
    NSArray *arrPageImages;
    NSArray *arrItemImages;
}

@synthesize pageViewController;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"News";

    arrPageImages = @[@"banner_01.jpg", @"banner_02.jpg", @"banner_03.jpg", @"banner_04.jpg",@"banner_05.jpg"];
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.menubarBtn setTarget: self.revealViewController];
        [self.menubarBtn setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    [self loadPageViewController];
    [self loadCollectionViewController];

    [self performSelector:@selector(bannerChange) withObject:nil afterDelay:5.0];
}

static NSString *kCellReuseIdentifier = @"CollectionViewCell";
- (void) loadCollectionViewController{
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    [self.collectionView registerNib:[UINib nibWithNibName:kCellReuseIdentifier bundle:nil] forCellWithReuseIdentifier:kCellReuseIdentifier];
    
}

- (void) loadPageViewController{
    // Create page view controller
    self.pageViewController = [[UIPageViewController alloc]
                               initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                               navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                               options:nil];
    self.pageViewController.dataSource = self;
    
    
    PageContentViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionReverse animated:NO completion:nil];
    
    self.pageViewController.view.frame = CGRectMake(0, 0 , self.view.frame.size.width, self.pageView.frame.size.height + 35);
    
    [self addChildViewController:pageViewController];
    [self.pageView addSubview:pageViewController.view];
    [pageViewController didMoveToParentViewController:self];
    
    
    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(135, 165, 50, 30)];
    pageControl.numberOfPages = arrPageImages.count;
    pageControl.currentPage = 0;
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor blueColor];
    [self.view addSubview:pageControl];
}


- (void) bannerChange{
    
    NSInteger currentIndex = pageControl.currentPage;
    
    if(currentIndex == arrPageImages.count -1){
        currentIndex = 0;
    }else currentIndex ++;
    PageContentViewController *startingViewController = [self viewControllerAtIndex:currentIndex];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionReverse animated:NO completion:nil];
    pageControl.currentPage = currentIndex;
    
    [self performSelector:@selector(bannerChange) withObject:nil afterDelay:3.0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark - Page View Datasource Methods
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = ((PageContentViewController*) viewController).pageIndex;
    if ((index == 0) || (index == NSNotFound))
    {

        pageControl.currentPage = 0;
        return nil;
    }else{
        pageControl.currentPage = index;
        
    }
    index--;
    
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    
    NSUInteger index = ((PageContentViewController*) viewController).pageIndex;
    if (index == NSNotFound)
    {
        pageControl.currentPage = arrPageImages.count;
        return nil;
    }else{
         pageControl.currentPage = index;
    }
    
    index++;
    if (index == [arrPageImages count])
    {
        return nil;
    }
    
    return [self viewControllerAtIndex:index];
}

- (PageContentViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if (([arrPageImages count] == 0) || (index >= [arrPageImages count])) {
        return nil;
    }
    PageContentViewController *pageContentViewController = [[PageContentViewController alloc] initWithNibName:@"PageContentViewController" bundle:nil];
    
    pageContentViewController.imageName = arrPageImages[index];
    pageContentViewController.pageIndex = index;
    
    return pageContentViewController;
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return [arrPageImages count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}


#pragma CollectionView datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 2;
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellReuseIdentifier forIndexPath:indexPath];
    //UIImageView *imageView = (UIImageView *)[cell viewWithTag:100];
    
    
    switch (indexPath.row) {
        case 0:
            if(indexPath.section == 0){
                cell.backgroundColor = [UIColor redColor];
            }else if(indexPath.section == 1){
                cell.backgroundColor = [UIColor greenColor];
            }else{
                 cell.backgroundColor = [UIColor blueColor];
            }
            break;
        case 1:
            if(indexPath.section == 0){
                cell.backgroundColor = [UIColor blackColor];
            }else if(indexPath.section == 1){
                cell.backgroundColor = [UIColor orangeColor];
            }else{
                cell.backgroundColor = [UIColor grayColor];
            }
            break;
        default:
            break;
    }
    
    return cell;
}


//

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(self.view.bounds.size.width/2, self.collectionView.frame.size.height/3);
}

// Space between each row.
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

// Space between each section.
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
//    return 5;
//}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

}


@end
