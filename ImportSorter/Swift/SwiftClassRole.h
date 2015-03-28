//
//  SwiftClassRole.h
//  ImportSorter
//
//  Created by jun.hashimoto on 2015/03/28.
//  Copyright (c) 2015年 Jun Hashimoto. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * NOTE : please edit this enum if you want customize role.
 */
typedef NS_ENUM(NSInteger, SwiftImportClassRole) { SwiftImportClassRoleOther = 0 };

@interface SwiftClassRole : NSObject
- (SwiftImportClassRole)getImportClassRole:(NSString *)importDeclaration;
- (NSString *)labelForClassRole:(SwiftImportClassRole)classRole;
- (NSInteger)lastImportClassRoleIndex;
@end
