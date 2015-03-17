//
//  Preferences.m
//  ImportSorter
//
//  Created by jun.hashimoto on 2015/03/17.
//  Copyright (c) 2015年 Jun Hashimoto. All rights reserved.
//

#import "Preferences.h"

@interface Preferences ()
@property (nonatomic, copy) NSString *applicationID;
@end

@implementation Preferences

- (instancetype)initWithApplicationID:(NSString *)applicationID
{
    self = [super init];

    if (self) {
        _applicationID = applicationID;
    }

    return self;
}

- (id)objectForKey:(NSString *)key
{
    CFPropertyListRef value =
        CFPreferencesCopyValue((__bridge CFStringRef)key, (__bridge CFStringRef)self.applicationID,
                               kCFPreferencesCurrentUser, kCFPreferencesAnyHost);

    id object = nil;

    if (value != NULL) {
        object = (__bridge id)value;
        CFRelease(value);
    }

    return object;
}

- (void)setObject:(id)object forKey:(NSString *)key
{
    CFPreferencesSetValue((__bridge CFStringRef)key, (__bridge CFPropertyListRef)object,
                          (__bridge CFStringRef)self.applicationID, kCFPreferencesCurrentUser,
                          kCFPreferencesAnyHost);
}

- (BOOL)synchronize
{
    return CFPreferencesSynchronize((__bridge CFStringRef)self.applicationID,
                                    kCFPreferencesCurrentUser, kCFPreferencesAnyHost);
}

@end
