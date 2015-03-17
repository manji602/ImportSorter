//
//  Preferences.h
//  ImportSorter
//
//  Created by jun.hashimoto on 2015/03/17.
//  Copyright (c) 2015年 Jun Hashimoto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Preferences : NSObject

- (instancetype)initWithApplicationID:(NSString *)applicationID;
- (id)objectForKey:(NSString *)key;
- (void)setObject:(id)object forKey:(NSString *)key;
- (BOOL)synchronize;

@end
