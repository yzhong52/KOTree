//
//  TreeNode.m
//  KOTree
//
//  Created by Yuchen on 2014-10-27.
//  Copyright (c) 2014 Adam Horacek. All rights reserved.
//

#import "TreeNode.h"
#import <CoreFoundation/CFTree.h>

@interface TreeNode()

@end

@implementation TreeNode

- (instancetype)init
{
    self = [super init];
    if (self) {
        _title = @"Unknow Title";
    }
    return self;
}


- (instancetype) initWithTitle: (NSString*)title
{
    self = [super init];
    if (self) {
        _title = title;
    }
    return self;
}

- (void)addNextSibling:(TreeNode *)treeNode
{
    if (self.nextSibling) {
        [self.nextSibling addNextSibling:treeNode];
    } else {
        self.nextSibling = treeNode;
    }
}

- (void)addChild:(TreeNode *)treeNode
{
    if (self.firstChild) {
        [self.firstChild addNextSibling:treeNode];
    } else {
        self.firstChild = treeNode;
        self.firstChild.depth = treeNode.depth + 1;
    }
}


@end
