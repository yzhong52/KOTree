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
        _isOpened = false;
    }
    return self;
}

- (void)addNextSibling:(TreeNode *)treeNode
{
    // find the last sibling
    TreeNode *lastSibling = self;
    while (lastSibling.nextSibling) {
        lastSibling = lastSibling.nextSibling;
    }
    
    // Add one more sibling
    lastSibling.nextSibling = treeNode;
    lastSibling.nextSibling.parent = lastSibling.parent;
    lastSibling.nextSibling.depth = lastSibling.depth;
}

- (void)addChild:(TreeNode *)treeNode
{
    if (self.firstChild) {
        [self.firstChild addNextSibling:treeNode];
    } else {
        self.firstChild = treeNode;
        self.firstChild.depth = self.depth + 1;
    }
}

- (NSArray*)getChildren {
    NSMutableArray* children = [[NSMutableArray alloc] init];
    
    TreeNode* child = self.firstChild;
    while (child) {
        [children addObject:child];
        child = child.nextSibling;
    }
    
    return children;
}


- (NSArray*) getAllVisibleChildren
{
    NSMutableArray* children = [[NSMutableArray alloc] init];
    
    TreeNode* child = self.firstChild;
    while (child) {
        [children addObject:child];
        
        if ( child.isOpened ) {
            NSArray* grandChildren = [child getAllVisibleChildren];
            [children addObjectsFromArray:grandChildren];
        }
        
        child = child.nextSibling;
    }
    
    
    return children;
}

@end
