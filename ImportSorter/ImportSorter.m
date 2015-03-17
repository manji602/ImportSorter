//
//  ImportSorter.m
//  ImportSorter
//
//  Created by Jun Hashimoto on 2015/03/09.
//  Copyright (c) 2015年 Jun Hashimoto. All rights reserved.
//

#import "ImportSorter.h"
// :: Other ::
#import "ObjCImportSorterRunner.h"
#import "Preferences.h"
#import "XcodeHelper.h"

static ImportSorter *sharedPlugin;

@interface ImportSorter ()

@property (nonatomic, strong, readwrite) NSBundle *bundle;
@property (nonatomic) NSMenu *menu;
@property (nonatomic) Preferences *preferences;
@end

@implementation ImportSorter

static NSString *const IMPORT_SORT_SHORTCUT_KEY = @"s";

+ (void)pluginDidLoad:(NSBundle *)plugin
{
    static dispatch_once_t onceToken;
    NSString *currentApplicationName = [[NSBundle mainBundle] infoDictionary][@"CFBundleName"];
    if ([currentApplicationName isEqual:@"Xcode"]) {
        dispatch_once(&onceToken, ^{
            sharedPlugin = [[self alloc] initWithBundle:plugin];
        });
    }
}

+ (instancetype)sharedPlugin
{
    return sharedPlugin;
}

- (id)initWithBundle:(NSBundle *)plugin
{
    self = [super init];
    if (self) {
        // reference to plugin's bundle, for resource access
        _bundle = plugin;
        _preferences = [[Preferences alloc] initWithApplicationID:self.bundle.bundleIdentifier];

        [self addMenuItem];
    }
    return self;
}

- (void)addMenuItem
{
    NSMenuItem *menuItem = [[NSApp mainMenu] itemWithTitle:@"Edit"];
    if (!menuItem) {
        return;
    }

    [[menuItem submenu] addItem:[NSMenuItem separatorItem]];
    NSMenuItem *actionMenuItem =
        [[NSMenuItem alloc] initWithTitle:@"Import Sorter" action:NULL keyEquivalent:@""];
    [[menuItem submenu] addItem:actionMenuItem];

    _menu = [[NSMenu alloc] initWithTitle:@"Import Sorter"];
    [self configureSubMenuItems];
    [actionMenuItem setSubmenu:_menu];
}

#pragma mark - private methods
- (void)configureSubMenuItems
{
    [_menu removeAllItems];
    [self addSortOnClickMenuItem];
    [_menu addItem:[NSMenuItem separatorItem]];
    [self addSortOnSaveMenuItem];
}

- (void)addSortOnClickMenuItem
{
    NSMenuItem *sortOnClickItem = [[NSMenuItem alloc] initWithTitle:@"Sort Import On Current File"
                                                             action:@selector(sortImport)
                                                      keyEquivalent:IMPORT_SORT_SHORTCUT_KEY];

    [sortOnClickItem setTarget:self];
    [_menu addItem:sortOnClickItem];
}

- (void)addSortOnSaveMenuItem
{
    BOOL sortOnSave = [self sortOnSave];
    NSString *menuItemTitle = sortOnSave ? @"Enable Sort on Save" : @"Disable Sort on Save";

    NSMenuItem *sortOnSaveItem = [[NSMenuItem alloc] initWithTitle:menuItemTitle
                                                            action:@selector(toggleSortOnSave)
                                                     keyEquivalent:@""];

    [sortOnSaveItem setTarget:self];
    [_menu addItem:sortOnSaveItem];
}

- (void)sortImport
{
    [self sortObjCImport];
}

- (BOOL)isObjCFile
{
    IDESourceCodeDocument *document = [XcodeHelper currentDocument];
    NSString *pathExtension = [document.fileURL.absoluteString pathExtension];

    return [@[ @"m", @"h" ] containsObject:pathExtension];
}

- (void)sortObjCImport
{
    if (![self isObjCFile]) {
        return;
    }

    NSTextView *textView = [XcodeHelper currentSourceCodeView];
    IDESourceCodeDocument *document = [XcodeHelper currentDocument];

    ObjCImportSorterRunner *runner =
        [[ObjCImportSorterRunner alloc] initWithTextView:textView document:document];
    [runner run];
}

- (BOOL)sortOnSave
{
    return [[_preferences objectForKey:[self sortOnSavePreferenceKey]] boolValue];
}

- (void)toggleSortOnSave
{
    BOOL sortOnSave = ![self sortOnSave];

    [_preferences setObject:@(sortOnSave) forKey:[self sortOnSavePreferenceKey]];
    [_preferences synchronize];

    [self configureSubMenuItems];
}

- (NSString *)sortOnSavePreferenceKey
{
    return [self.bundle.bundleIdentifier stringByAppendingString:@".sortOnSave"];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
