//
//  ImportSorter.h
//  ImportSorter
//
//  Created by Jun Hashimoto on 2015/03/09.
//  Copyright (c) 2015年 Jun Hashimoto. All rights reserved.
//

// :: Framework ::
#import <AppKit/AppKit.h>

@interface ImportSorter : NSObject

+ (instancetype)sharedPlugin;

@property (nonatomic, strong, readonly) NSBundle* bundle;
@end