//
//  ObjCClassRole.h
//  ImportSorter
//
//  Created by Jun Hashimoto on 2015/03/10.
//  Copyright (c) 2015年 Jun Hashimoto. All rights reserved.
//

// :: Framework ::
#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ObjCImportClassRole) {
    ObjCImportClassRoleSelf = 0,
    ObjCImportClassRoleFramework,
    ObjCImportClassRoleOther
};

@interface ObjCClassRole : NSObject
- (instancetype)initWithOriginalClassName:(NSString *)originalClassName;
- (ObjCImportClassRole)getImportClassRole:(NSString *)importDeclaration;
- (NSString *)labelForClassRole:(ObjCImportClassRole)classRole;
- (NSInteger)lastImportClassRoleIndex;
@end
