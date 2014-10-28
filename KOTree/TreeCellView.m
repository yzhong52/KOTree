//
//  TreeCellView.m
//  KOTree
//
//  Created by Yuchen on 2014-10-27.
//  Copyright (c) 2014 Adam Horacek. All rights reserved.
//

#import "TreeCellView.h"
#import "TreeNode.h"
#import "KOTreeItem.h"

@interface TreeCellView()
@property (weak, nonatomic) IBOutlet UIView *bigContentView;
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftSpacing;
@end

@implementation TreeCellView

- (void)awakeFromNib {
    // Initialization code
    // NSLog( @"awakeFromNib for TreeCellView is called. " );
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
    }
    
    return self;
}
- (IBAction)tapOnCheckbox:(id)sender {
    self.checkbox.selected = !self.checkbox.selected;
}


-(void) updateCell{
    self.titleLabel.text = self.treeNode.title;
    self.iconImage.image = [UIImage imageNamed: self.treeNode.isOpened ? @"FolderOpen.png" : @"FolderClose.png"];
    
    self.leftSpacing.constant = 25 * self.treeNode.depth;
    [self.contentView needsUpdateConstraints];
    
}

@end
