//
//  BaseImportSorterRunner.h
//  ImportSorter
//
//  Created by jun.hashimoto on 2015/08/02.
//  Copyright (c) 2015年 Jun Hashimoto. All rights reserved.
//

// :: Framework ::
#import <AppKit/AppKit.h>
#import <Foundation/Foundation.h>
// :: Other ::
#import "XcodeComponents.h"

@interface BaseImportSorterRunner : NSObject
@property (nonatomic) NSTextView *sourceCodeView;
@property (nonatomic) IDESourceCodeDocument *sourceCodeDocument;
@property (nonatomic) NSString *importDeclarationPrefix;
@property (nonatomic) NSString *classRoleLabelPrefix;

- (NSArray *)exportImportDeclarations;
- (void)insertSortedImportDeclaration:(NSString *)importDeclarations;
- (NSRange)getReplacementRange;
@end
