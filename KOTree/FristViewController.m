//
//  YCTableViewController.m
//  KOTree
//
//  Created by Yuchen on 2014-10-27.
//  Copyright (c) 2014 Adam Horacek. All rights reserved.
//

#import "FristViewController.h"
#import "TreeViewController.h"

@implementation FristViewController

- (IBAction)pushToTreeViewStoryboard:(id)sender {
    // Get the storyboard named secondStoryBoard from the main bundle:
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"TreeViewStoryboard" bundle:nil];
    
    // Load the initial view controller from the storyboard.
    // Set this by selecting 'Is Initial View Controller' on the appropriate view controller in the storyboard.
    UINavigationController* nav = [secondStoryBoard instantiateInitialViewController];
    TreeViewController* theInitialViewController = [nav.viewControllers objectAtIndex:0];
    
    // Then push the new view controller in the usual way:
    [self.navigationController pushViewController:theInitialViewController animated:YES];
}

@end
