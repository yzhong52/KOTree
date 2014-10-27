//
//  TreeCellView.m
//  KOTree
//
//  Created by Yuchen on 2014-10-27.
//  Copyright (c) 2014 Adam Horacek. All rights reserved.
//

#import "TreeCellView.h"
#import "KOTreeItem.h"

@interface TreeCellView()
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@end

@implementation TreeCellView

- (void)awakeFromNib {
    // Initialization code
    NSLog( @"awakeFromNib for TreeCellView is called. Or NOT? " );
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


- (void)setIsOpened: (BOOL)flag {
    self.iconImage.image = [UIImage imageNamed: flag ? @"FolderOpen.png" : @"FolderClose.png"];
}

@end
