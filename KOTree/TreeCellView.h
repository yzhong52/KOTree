//
//  TreeCellView.h
//  KOTree
//
//  Created by Yuchen on 2014-10-27.
//  Copyright (c) 2014 Adam Horacek. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KOTreeItem;
@class TreeNode;

@interface TreeCellView : UITableViewCell

@property (nonatomic, strong) KOTreeItem *treeItem;

@property (nonatomic, weak) TreeNode* treeNode;

@property (weak, nonatomic) IBOutlet UIButton *checkbox;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

-(void) updateCell;

@end
