//
//  YCTableViewController2.m
//  KOTree
//
//  Created by Yuchen on 2014-10-27.
//  Copyright (c) 2014 Adam Horacek. All rights reserved.
//

#import "TreeViewController.h"
#import "KOTreeTableViewCell.h"
#import "KOTreeItem.h"
#import "TreeCellView.h"

@interface TreeViewController ()
@property (nonatomic, strong) NSMutableArray *selectedTreeItems;
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
    return [self.treeItems count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TreeviewCellReuseIdentifier" forIndexPath:indexPath];
    
    // Configure the cell...
    TreeCellView *cell = [tableView dequeueReusableCellWithIdentifier:@"TreeviewCellReuseIdentifier"];
    if (!cell){
        cell = [[TreeCellView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TreeviewCellReuseIdentifier"];
    }
    
    cell.titleLabel.text = @"CCSS";
    [cell setIsOpened: NO];
    
    return cell;
}


- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
    [item0 setPath:@"/"];
    [item0 setSubmersionLevel:0];
    [item0 setParentSelectingItem:nil];
    [item0 setAncestorSelectingItems:[NSMutableArray arrayWithObjects:item1, item2, item3, nil]];
    [item0 setNumberOfSubitems:3];
    
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


@end
