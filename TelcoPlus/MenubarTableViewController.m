//
//  MenubarTableViewController.m
//  TelcoPlus
//
//  Created by Nguyễn Mạnh Tuấn on 11/16/15.
//  Copyright © 2015 Nguyễn Mạnh Tuấn. All rights reserved.
//

#import "MenubarTableViewController.h"

@interface MenubarTableViewController ()

@end

@implementation MenubarTableViewController{
     NSArray *menuItems;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    menuItems = @[@"title", @"news", @"comments", @"map", @"calendar", @"wishlist", @"bookmark", @"tag"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return menuItems.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    NSString *CellIdentifier = [menuItems objectAtIndex:indexPath.row];
    cell.textLabel.text = CellIdentifier;

    
    return cell;
    
/*
    NSString *CellIdentifier = [menuItems objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    return cell;
 */
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    // Set the title of navigation bar by using the menu items
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    UINavigationController *destViewController = (UINavigationController*)segue.destinationViewController;
    destViewController.title = [[menuItems objectAtIndex:indexPath.row] capitalizedString];
    
    // Set the photo if it navigates to the PhotoView
    if ([segue.identifier isEqualToString:@"showPhoto"]) {
//        UINavigationController *navController = segue.destinationViewController;
//        PhotoViewController *photoController = [navController childViewControllers].firstObject;
//        NSString *photoFilename = [NSString stringWithFormat:@"%@_photo", [menuItems objectAtIndex:indexPath.row]];
//        photoController.photoFilename = photoFilename;
    }
}


@end
