//
//  CPlusPlusClassRole.m
//  ImportSorter
//
//  Created by jun.hashimoto on 2015/08/02.
//  Copyright (c) 2015年 Jun Hashimoto. All rights reserved.
//

#import "CPlusPlusClassRole.h"

@interface CPlusPlusClassRole ()
@property (nonatomic) NSString *originalClassName;
@end

@implementation CPlusPlusClassRole

static NSString *const kFrameworkLibraryRegExp = @"#include <.*>";
/**
 * NOTE : if you customize original role, labelForClassRole must
 * begin with kClassRoleLabelPrefix.
 */
static NSString *const kClassRoleLabelPrefix = @"// :: ";
static NSString *const kClassRoleLabelSuffix = @" ::\n";

#pragma mark - public methods
- (instancetype)initWithOriginalClassName:(NSString *)originalClassName
{
    self = [super init];
    
    if (self) {
        _originalClassName = originalClassName;
    }
    
    return self;
}

/**
 * NOTE : please edit this method if you want customize role.
 */
- (CPlusPlusImportClassRole)getImportClassRole:(NSString *)targetString
{
    NSString *selfClassRegExp =
    [NSString stringWithFormat:@"%@%@%@", @"#include \"", _originalClassName, @".h\""];
    if ([self isMatchPattern:selfClassRegExp targetString:targetString]) {
        return CPlusPlusImportClassRoleSelf;
    }
    
    
    if ([self isMatchPattern:kFrameworkLibraryRegExp targetString:targetString]) {
        return CPlusPlusImportClassRoleFramework;
    }
    
    return CPlusPlusImportClassRoleOther;
}

/**
 * NOTE : please edit this method if you want customize role.
 */
- (NSString *)labelForClassRole:(CPlusPlusImportClassRole)classRole
{
    switch (classRole) {
        case CPlusPlusImportClassRoleSelf:
            return @"";
        case CPlusPlusImportClassRoleFramework:
            return [NSString stringWithFormat:@"%@%@%@", kClassRoleLabelPrefix, @"Framework",
                    kClassRoleLabelSuffix];
        case CPlusPlusImportClassRoleOther:
            return [NSString
                    stringWithFormat:@"%@%@%@", kClassRoleLabelPrefix, @"Other", kClassRoleLabelSuffix];
    }
}

/**
 * NOTE : please edit this method if you want customize role.
 */
- (NSInteger)lastImportClassRoleIndex
{
    return CPlusPlusImportClassRoleOther;
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
