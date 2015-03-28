//
//  SwiftClassRole.m
//  ImportSorter
//
//  Created by jun.hashimoto on 2015/03/28.
//  Copyright (c) 2015年 Jun Hashimoto. All rights reserved.
//

#import "SwiftClassRole.h"

@implementation SwiftClassRole

/**
 * NOTE : if you customize original role, labelForClassRole must
 * begin with kClassRoleLabelPrefix and end with kClassRoleLabelSuffix.
 */
static NSString *const kClassRoleLabelPrefix = @"// :: ";
static NSString *const kClassRoleLabelSuffix = @" ::\n";

#pragma mark - public methods

/**
 * NOTE : please edit this method if you want customize role.
 */
- (SwiftImportClassRole)getImportClassRole:(NSString *)targetString
{
    return SwiftImportClassRoleOther;
}

/**
 * NOTE : please edit this method if you want customize role.
 */
- (NSString *)labelForClassRole:(SwiftImportClassRole)classRole
{
    return @"";
}

/**
 * NOTE : please edit this method if you want customize role.
 */
- (NSInteger)lastImportClassRoleIndex
{
    return SwiftImportClassRoleOther;
}

#pragma mark - private methods
- (BOOL)isMatchPattern:(NSString *)regExpPattern targetString:(NSString *)targetString
{
    NSRegularExpression *regExp =
        [NSRegularExpression regularExpressionWithPattern:regExpPattern
                                                  options:NSRegularExpressionCaseInsensitive
                                                    error:nil];

    NSArray *matchString =
        [regExp matchesInString:targetString options:0 range:NSMakeRange(0, targetString.length)];
    return ([matchString count] != 0) ? YES : NO;
}

@end
