//
//  ObjCClassRole.m
//  ImportSorter
//
//  Created by Jun Hashimoto on 2015/03/10.
//  Copyright (c) 2015年 Jun Hashimoto. All rights reserved.
//

#import "ObjCClassRole.h"

@interface ObjCClassRole ()
@property (nonatomic) NSString *originalClassName;
@end

@implementation ObjCClassRole

static NSString *const kFrameworkLibraryRegExp = @"#import <.*>";
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
- (ObjCImportClassRole)getImportClassRole:(NSString *)targetString
{
    NSString *selfClassRegExp =
        [NSString stringWithFormat:@"%@%@%@", @"#import \"", _originalClassName, @".h\""];
    if ([self isMatchPattern:selfClassRegExp targetString:targetString]) {
        return ObjCImportClassRoleSelf;
    }


    if ([self isMatchPattern:kFrameworkLibraryRegExp targetString:targetString]) {
        return ObjCImportClassRoleFramework;
    }

    return ObjCImportClassRoleOther;
}

/**
 * NOTE : please edit this method if you want customize role.
 */
- (NSString *)labelForClassRole:(ObjCImportClassRole)classRole
{
    switch (classRole) {
        case ObjCImportClassRoleSelf:
            return @"";
        case ObjCImportClassRoleFramework:
        case ObjCImportClassRoleOther:
            return @"\n";
    }
}

/**
 * NOTE : please edit this method if you want customize role.
 */
- (NSInteger)lastImportClassRoleIndex
{
    return ObjCImportClassRoleOther;
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
