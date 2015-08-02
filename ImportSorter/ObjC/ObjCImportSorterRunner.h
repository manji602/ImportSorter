//
//  ObjCImportSorterRunner.h
//  ImportSorter
//
//  Created by Jun Hashimoto on 2015/03/10.
//  Copyright (c) 2015年 Jun Hashimoto. All rights reserved.
//

// :: Framework ::
#import <AppKit/AppKit.h>
#import <Foundation/Foundation.h>
// :: Other ::
#import "BaseImportSorterRunner.h"
#import "XcodeComponents.h"

@interface ObjCImportSorterRunner : BaseImportSorterRunner
- (instancetype)initWithTextView:(NSTextView *)textView document:(IDESourceCodeDocument *)document;
- (void)run;
@end
