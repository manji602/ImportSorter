//
//  XcodeHelper.h
//  ImportSorter
//
//  Created by Jun Hashimoto on 2015/03/10.
//  Copyright (c) 2015年 Jun Hashimoto. All rights reserved.
//

// :: Framework ::
#import <Foundation/Foundation.h>
// :: Other ::
#import "XcodeComponents.h"

@interface XcodeHelper : NSObject

+ (IDESourceCodeEditor*)currentEditor;
+ (IDESourceCodeDocument*)currentDocument;
+ (NSTextView*)currentSourceCodeView;

@end
