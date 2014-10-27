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
@property (nonatomic, strong) NSMutableArray *selectedTreeItems;

@property (nonatomic, strong) TreeNode* root;
@property (nonatomic, strong) NSMutableArray *treeNodes;

@end

@implementation TreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.selectedTreeItems = [NSMutableArray array];
    // Do any additional setup after loading the view.
    
    self.treeItems = [self listItemsAtPath:@"/"];
    
    
    self.root = [self testTree];
    
    self.treeNodes = [[NSMutableArray alloc] init];
    [self.treeNodes addObject:self.root];
    NSLog(@"%d", [self.treeNodes count]);
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
    return [self.treeNodes count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TreeviewCellReuseIdentifier" forIndexPath:indexPath];
    
    // Configure the cell...
    TreeCellView *cell = [tableView dequeueReusableCellWithIdentifier:@"TreeviewCellReuseIdentifier"];
    if (!cell){
        cell = [[TreeCellView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TreeviewCellReuseIdentifier"];
    }
    
    TreeNode* item = (TreeNode* )[self.treeNodes objectAtIndex:indexPath.row];
    
    cell.titleLabel.text = item.title;
//    cell.treeItem = item;
    
    [cell setIsOpened: NO];
    
    return cell;
}


- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // Get the table cell
    TreeCellView *cell = (TreeCellView *)[tableView cellForRowAtIndexPath:indexPath];
    [cell setIsOpened: YES];

    // Obtain index to insert the items
    NSInteger insertTreeItemIndex = [self.treeItems indexOfObject:cell.treeItem];
    NSMutableArray *insertIndexPaths = [NSMutableArray array];
    
    // Get items to be insert
    NSMutableArray *insertselectingItems = [self listItemsAtPath:[cell.treeItem.path stringByAppendingPathComponent:cell.treeItem.base]];

    // Index Path to remove items
    NSMutableArray *removeIndexPaths = [NSMutableArray array];
    
    // Items to be removed
    NSMutableArray *treeItemsToRemove = [NSMutableArray array];
    
    
    for (KOTreeItem *tmpTreeItem in insertselectingItems) {
        [tmpTreeItem setPath:[cell.treeItem.path stringByAppendingPathComponent:cell.treeItem.base]];
        
        // A pointer to the parent
        [tmpTreeItem setParentSelectingItem:cell.treeItem];
        
        // A array of children
        [cell.treeItem.ancestorSelectingItems removeAllObjects];
        [cell.treeItem.ancestorSelectingItems addObjectsFromArray:insertselectingItems];
        
        // What's this for?
        insertTreeItemIndex++;
        
        // ?
        BOOL contains = NO;
        
        // Time to update the data structure in self.treeItems
        for (KOTreeItem *tmp2TreeItem in self.treeItems) {
            if ([tmp2TreeItem isEqualToSelectingItem:tmpTreeItem]) {
                contains = YES;
                
                [self selectingItemsToDelete:tmp2TreeItem saveToArray:treeItemsToRemove];
                
                removeIndexPaths = [self removeIndexPathForTreeItems:(NSMutableArray *)treeItemsToRemove forTableView:tableView];
            }
        }
        
        for (KOTreeItem *tmp2TreeItem in treeItemsToRemove) {
            [self.treeItems removeObject:tmp2TreeItem];
            
            for (KOTreeItem *tmp3TreeItem in self.selectedTreeItems) {
                if ([tmp3TreeItem isEqualToSelectingItem:tmp2TreeItem]) {
                    NSLog(@"%@", tmp3TreeItem.base);
                    [self.selectedTreeItems removeObject:tmp2TreeItem];
                    break;
                }
            }
        }
        
        if (!contains) {
            [tmpTreeItem setSubmersionLevel:tmpTreeItem.submersionLevel];
            
            [self.treeItems insertObject:tmpTreeItem atIndex:insertTreeItemIndex];
            
            NSIndexPath *indexPth = [NSIndexPath indexPathForRow:insertTreeItemIndex inSection:0];
            [insertIndexPaths addObject:indexPth];
        }
    }
    
    if ([insertIndexPaths count])
        [tableView insertRowsAtIndexPaths:insertIndexPaths withRowAnimation:UITableViewRowAnimationBottom];
    
    if ([removeIndexPaths count])
        [tableView deleteRowsAtIndexPaths:removeIndexPaths withRowAnimation:UITableViewRowAnimationBottom];
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

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



- (NSMutableArray *)listItemsAtPath:(NSString *)path {
    KOTreeItem *item0, *item1, *item1_1, *item1_2, *item1_2_1, *item2, *item3;
    
    item0 = [[KOTreeItem alloc] init];
    [item0 setBase:@"Item 0"];
    [item0 setPath:@"/"];          // Yuchen: root view
    [item0 setSubmersionLevel:0];  // Count the number of '/'s above? Why not?
    [item0 setParentSelectingItem:nil];
    [item0 setAncestorSelectingItems:[NSMutableArray arrayWithObjects:item1, item2, item3, nil]];
    [item0 setNumberOfSubitems:3]; // Yuchen: get from [item0.ancestorSelectingItems count]?

    
    item1 = [[KOTreeItem alloc] init];
    [item1 setBase:@"Item 1"];
    [item1 setPath:@"/Item 0"];
    [item1 setSubmersionLevel:1];
    [item1 setParentSelectingItem:item0];
    [item1 setAncestorSelectingItems:[NSMutableArray arrayWithObjects:item1_1, item1_2, nil]];
    [item1 setNumberOfSubitems:2];
    
    item1_1 = [[KOTreeItem alloc] init];
    [item1_1 setBase:@"Item 1 1"];
    [item1_1 setPath:@"/Item 0/Item 1"];
    [item1_1 setSubmersionLevel:2];
    [item1_1 setParentSelectingItem:item1];
    [item1_1 setAncestorSelectingItems:[NSMutableArray array]];
    [item1_1 setNumberOfSubitems:0];
    
    item1_2 = [[KOTreeItem alloc] init];
    [item1_2 setBase:@"Item 1 2"];
    [item1_2 setPath:@"/Item 0/Item 1"];
    [item1_2 setSubmersionLevel:2];
    [item1_2 setParentSelectingItem:item1];
    [item1_2 setAncestorSelectingItems:[NSMutableArray arrayWithObjects:item1_2_1, nil]];
    [item1_2 setNumberOfSubitems:1];
    
    item1_2_1 = [[KOTreeItem alloc] init];
    [item1_2_1 setBase:@"Item 1 2 1"];
    [item1_2_1 setPath:@"/Item 0/Item 1/Item 1 2"];
    [item1_2_1 setSubmersionLevel:3];
    [item1_2_1 setParentSelectingItem:item1_2];
    [item1_2_1 setAncestorSelectingItems:[NSMutableArray array]];
    [item1_2_1 setNumberOfSubitems:0];
    
    item2 = [[KOTreeItem alloc] init];
    [item2 setBase:@"Item 2"];
    [item2 setPath:@"/Item 0"];
    [item2 setSubmersionLevel:1];
    [item2 setParentSelectingItem:item0];
    [item2 setAncestorSelectingItems:[NSMutableArray array]];
    [item2 setNumberOfSubitems:0];
    
    item3 = [[KOTreeItem alloc] init];
    [item3 setBase:@"Item 3"];
    [item3 setPath:@"/Item 0"];
    [item3 setSubmersionLevel:1];
    [item3 setParentSelectingItem:item0];
    [item3 setAncestorSelectingItems:[NSMutableArray array]];
    [item3 setNumberOfSubitems:0];
    
    NSLog(@"%@", path);
    if ([path isEqualToString:@"/"]) {
        return [NSMutableArray arrayWithObject:item0];
    } else if ([path isEqualToString:@"/Item 0"]) {
        return [NSMutableArray arrayWithObjects:item1, item2, item3, nil];
    } else if ([path isEqualToString:@"/Item 0/Item 1"]) {
        return [NSMutableArray arrayWithObjects:item1_1, item1_2, nil];
    } else if ([path isEqualToString:@"/Item 0/Item 1/Item 1 2"]) {
        return [NSMutableArray arrayWithObjects:item1_2_1, nil];
    } else {
        return [NSMutableArray array];
    }
}


-(TreeNode*) testTree{
    TreeNode* root = [[TreeNode alloc] initWithTitle:@"Root"];
    
    TreeNode* child1 = [[TreeNode alloc] initWithTitle:@"Child 1"];
    TreeNode* child2 = [[TreeNode alloc] initWithTitle:@"Child 2"];
    
    [root addChild:child1];
    [root addChild:child2];
    
    return root;
}

@end
