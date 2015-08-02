//
//  BaseImportSorterRunner.m
//  ImportSorter
//
//  Created by jun.hashimoto on 2015/08/02.
//  Copyright (c) 2015年 Jun Hashimoto. All rights reserved.
//

#import "BaseImportSorterRunner.h"

@implementation BaseImportSorterRunner

- (NSArray *)exportImportDeclarations
{
    NSString *sourceString = _sourceCodeView.textStorage.string;
    NSRange range = NSMakeRange(0, sourceString.length);

    NSMutableArray *importDeclarationsArray = [NSMutableArray array];
    while (range.length > 0) {
        NSRange subRange = [sourceString lineRangeForRange:NSMakeRange(range.location, 0)];

        NSString *line = [sourceString substringWithRange:subRange];
        if ([line hasPrefix:_importDeclarationPrefix]) {
            [importDeclarationsArray addObject:line];
        }

        range.location = NSMaxRange(subRange);
        range.length -= subRange.length;
    }

    return [importDeclarationsArray copy];
}

- (void)insertSortedImportDeclaration:(NSString *)importDeclarations
{
    NSRange replacementRange = [self getReplacementRange];
    [_sourceCodeView insertText:importDeclarations replacementRange:replacementRange];
}

- (NSRange)getReplacementRange
{
    NSInteger replaceLength = 0;
    NSInteger replaceBeginLocation = 0;
    NSInteger replaceEndLocation = 0;
    BOOL hasSetBeginLocation = NO;

    NSString *sourceString = _sourceCodeView.textStorage.string;
    NSRange range = NSMakeRange(0, sourceString.length);

    NSMutableArray *importDeclarationsArray = [NSMutableArray array];
    while (range.length > 0) {
        NSRange subRange = [sourceString lineRangeForRange:NSMakeRange(range.location, 0)];

        NSString *line = [sourceString substringWithRange:subRange];
        if ([line hasPrefix:_importDeclarationPrefix] || [line hasPrefix:_classRoleLabelPrefix]) {
            [importDeclarationsArray addObject:line];
            if (!hasSetBeginLocation) {
                hasSetBeginLocation = YES;
                replaceBeginLocation = subRange.location;
            }
            replaceEndLocation = subRange.location + subRange.length;
        }

        range.location = NSMaxRange(subRange);
        range.length -= subRange.length;
    }
    replaceLength = MAX(replaceEndLocation - replaceBeginLocation, 0);

    return NSMakeRange(replaceBeginLocation, replaceLength);
}

@end
