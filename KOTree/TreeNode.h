//
//  TreeNode.h
//  KOTree
//
//  Created by Yuchen on 2014-10-27.
//  Copyright (c) 2014 Adam Horacek. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TreeNode : NSObject

@property(nonatomic, weak) TreeNode* parent;
@property(nonatomic, strong) TreeNode* nextSibling;
@property(nonatomic, strong) TreeNode* firstChild;

- (void)addNextSibling:(TreeNode *)treeNode;
- (void)addChild:(TreeNode *)treeNode;
- (NSArray*) getChildren;
- (NSArray*) getAllVisibleChildren;

@property(nonatomic, assign) NSUInteger depth;
@property(nonatomic, strong) NSString* title;
@property(nonatomic, assign) BOOL isOpened;

- (instancetype) initWithTitle: (NSString*)title;

@end
