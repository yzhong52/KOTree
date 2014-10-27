//
//  TreeCellView.h
//  KOTree
//
//  Created by Yuchen on 2014-10-27.
//  Copyright (c) 2014 Adam Horacek. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KOTreeItem;

@interface TreeCellView : UITableViewCell

@property (nonatomic, strong) KOTreeItem *treeItem;

@property (weak, nonatomic) IBOutlet UIButton *checkbox;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

- (void)setIsOpened: (BOOL)flag;

@end
