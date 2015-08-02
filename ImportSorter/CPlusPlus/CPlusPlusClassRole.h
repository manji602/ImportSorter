//
//  CPlusPlusClassRole.h
//  ImportSorter
//
//  Created by jun.hashimoto on 2015/08/02.
//  Copyright (c) 2015年 Jun Hashimoto. All rights reserved.
//

// :: Framework ::
#import <Foundation/Foundation.h>

/**
 * NOTE : please edit this enum if you want customize role.
 */
typedef NS_ENUM(NSInteger, CPlusPlusImportClassRole) {
    CPlusPlusImportClassRoleSelf = 0,
    CPlusPlusImportClassRoleFramework,
    CPlusPlusImportClassRoleOther
};

@interface CPlusPlusClassRole : NSObject
- (instancetype)initWithOriginalClassName:(NSString *)originalClassName;
- (CPlusPlusImportClassRole)getImportClassRole:(NSString *)importDeclaration;
- (NSString *)labelForClassRole:(CPlusPlusImportClassRole)classRole;
- (NSInteger)lastImportClassRoleIndex;
@end
