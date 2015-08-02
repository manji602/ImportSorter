//
//  CPlusPlusImportSorterRunner.h
//  ImportSorter
//
//  Created by jun.hashimoto on 2015/08/02.
//  Copyright (c) 2015年 Jun Hashimoto. All rights reserved.
//

// :: Framework ::
#import <AppKit/AppKit.h>
#import <Foundation/Foundation.h>
// :: Other ::
#import "BaseImportSorterRunner.h"
#import "XcodeComponents.h"

@interface CPlusPlusImportSorterRunner : BaseImportSorterRunner
- (instancetype)initWithTextView:(NSTextView *)textView document:(IDESourceCodeDocument *)document;
- (void)run;
@end
