//
//  YCTableViewController2.m
//  KOTree
//
//  Created by Yuchen on 2014-10-27.
//  Copyright (c) 2014 Adam Horacek. All rights reserved.
//

#import "TreeViewController.h"
#import "KOTreeItem.h"
#import "TreeCellView.h"

#import "TreeNode.h"

@interface TreeViewController ()

@property (nonatomic, strong) TreeNode* root;
@property (nonatomic, strong) NSMutableArray *treeNodesForCells;

@end

@implementation TreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.root = [self testTree];
    
    self.treeNodesForCells = [[NSMutableArray alloc] init];
    [self.treeNodesForCells addObject:self.root];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.treeNodesForCells count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TreeviewCellReuseIdentifier" forIndexPath:indexPath];
    
    // Configure the cell...
    TreeCellView *cell = [tableView dequeueReusableCellWithIdentifier:@"TreeviewCellReuseIdentifier"];
    if (!cell){
        cell = [[TreeCellView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TreeviewCellReuseIdentifier"];
    }
    
    TreeNode* item = (TreeNode* )[self.treeNodesForCells objectAtIndex:indexPath.row];
    
    cell.treeNode = item;
    [cell updateCell];
    
    return cell;
}


- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // Get the table cell
    TreeCellView *cell = (TreeCellView *)[tableView cellForRowAtIndexPath:indexPath];
    
    TreeNode* treeNode = cell.treeNode;
    treeNode.isOpened = !treeNode.isOpened;
    
    if ([treeNode isOpened]) {
        // to open a folder
        NSArray* treeNodesToInsert = [treeNode getChildren];
        
        const NSInteger numberOfNodesToInsert = [treeNodesToInsert count];
        if (numberOfNodesToInsert!=0) {
            NSMutableArray* indexPathsToInsert = [[NSMutableArray alloc] initWithCapacity:numberOfNodesToInsert];
            for (NSInteger i=0; i<numberOfNodesToInsert; i++) {
                TreeNode* node = [treeNodesToInsert objectAtIndex:i];
                NSUInteger ridx = indexPath.row+i+1;  // row index for the TreeNode
                
                // Update the array for display
                [self.treeNodesForCells insertObject:node atIndex:ridx];
                
                // keep track of the indexpath that need to be updated in the table
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:ridx inSection:0];
                [indexPathsToInsert insertObject:indexPath atIndex:i];
            }
            
            [tableView insertRowsAtIndexPaths:indexPathsToInsert withRowAnimation:UITableViewRowAnimationFade];
        }
    } else {
        // to close a folder
        NSArray* treeNodesToHide = [treeNode getAllVisibleChildren];
        
        const NSInteger numberOfNodesToHide = [treeNodesToHide count];
        if (numberOfNodesToHide!=0) {
            NSMutableArray* indexPathsToHide = [[NSMutableArray alloc] initWithCapacity:numberOfNodesToHide];
            for (NSInteger i=0; i<numberOfNodesToHide; i++) {
                TreeNode* node = [treeNodesToHide objectAtIndex:i];
                NSUInteger ridx = indexPath.row+i+1;  // row index for the TreeNode
                
                // keep track of the indexpath that need to be updated in the table
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:ridx inSection:0];
                [indexPathsToHide insertObject:indexPath atIndex:i];
                
                // hide this treenode
                node.isOpened = false;
            }
            
            NSRange range = NSMakeRange(indexPath.row+1, numberOfNodesToHide);
            [self.treeNodesForCells removeObjectsInRange:range];
            
            NSLog(@"%tu", [indexPathsToHide count]);
            NSLog(@"%@", indexPathsToHide);
            [tableView deleteRowsAtIndexPaths:indexPathsToHide withRowAnimation:UITableViewRowAnimationFade];
        }
    }
    
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    return;
}

- (void)selectingItemsToDelete:(KOTreeItem *)selItems saveToArray:(NSMutableArray *)deleteSelectingItems{
    // Recursive algorithm
    for (KOTreeItem *obj in selItems.ancestorSelectingItems) {
        [self selectingItemsToDelete:obj saveToArray:deleteSelectingItems];
    }
    
    [deleteSelectingItems addObject:selItems];
}


- (NSMutableArray *)removeIndexPathForTreeItems:(NSMutableArray *)treeItemsToRemove forTableView:(UITableView*) tableView {
    NSMutableArray *result = [NSMutableArray array];
    
    for (NSInteger i = 0; i < [tableView numberOfRowsInSection:0]; ++i) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        TreeCellView *cell = (TreeCellView *)[tableView cellForRowAtIndexPath:indexPath];
        
        for (KOTreeItem *tmpTreeItem in treeItemsToRemove) {
            if ([cell.treeItem isEqualToSelectingItem:tmpTreeItem]){
                [result addObject:indexPath];
            }
        }
    }
    
    return result;
}

-(TreeNode*) testTree{
    TreeNode* root = [[TreeNode alloc] initWithTitle:@"Root"];
    
    TreeNode* child1 = [[TreeNode alloc] initWithTitle:@"Child 1"];
    TreeNode* child2 = [[TreeNode alloc] initWithTitle:@"Child 2"];
    
    [root addChild:child1];
    [root addChild:child2];
    
    TreeNode* grandChild1 = [[TreeNode alloc] initWithTitle:@"Grandchild 1"];
    TreeNode* grandChild2 = [[TreeNode alloc] initWithTitle:@"Grandchild 2"];
    [child1 addChild:grandChild1];
    [child1 addChild:grandChild2];
    
    return root;
}

@end
