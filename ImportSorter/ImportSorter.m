//
//  ImportSorter.m
//  ImportSorter
//
//  Created by Jun Hashimoto on 2015/03/09.
//  Copyright (c) 2015年 Jun Hashimoto. All rights reserved.
//

#import "ImportSorter.h"
// :: Other ::
#import "CPlusPlusImportSorterRunner.h"
#import "ObjCImportSorterRunner.h"
#import "Preferences.h"
#import "SwiftImportSorterRunner.h"
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
		
		[[NSOperationQueue mainQueue] addOperationWithBlock:^{
			[self addMenuItem];
		}];
		
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
}

- (void)addSortOnClickMenuItem
{
    NSMenuItem *sortOnClickItem = [[NSMenuItem alloc] initWithTitle:@"Sort Import On Current File"
                                                             action:@selector(sortImport)
                                                      keyEquivalent:IMPORT_SORT_SHORTCUT_KEY];

    [sortOnClickItem setKeyEquivalentModifierMask:NSControlKeyMask];
    [sortOnClickItem setTarget:self];
    [_menu addItem:sortOnClickItem];
}

- (void)sortImport
{
    [self sortObjCImport];
    [self sortCPlusPlusImport];
    [self sortSwiftImport];
}

- (BOOL)isCPlusPlusFile
{
    IDESourceCodeDocument *document = [XcodeHelper currentDocument];
    NSString *pathExtension = [document.fileURL.absoluteString pathExtension];
    
    return [@[ @"cpp", @"hpp", @"h" ] containsObject:pathExtension];
}

- (BOOL)isObjCFile
{
    IDESourceCodeDocument *document = [XcodeHelper currentDocument];
    NSString *pathExtension = [document.fileURL.absoluteString pathExtension];

    return [@[ @"m", @"h" ] containsObject:pathExtension];
}

- (BOOL)isSwiftFile
{
    IDESourceCodeDocument *document = [XcodeHelper currentDocument];
    NSString *pathExtension = [document.fileURL.absoluteString pathExtension];

    return [@[ @"swift" ] containsObject:pathExtension];
}

- (void)sortCPlusPlusImport
{
    if (![self isCPlusPlusFile]) {
        return;
    }
    
    NSTextView *textView = [XcodeHelper currentSourceCodeView];
    IDESourceCodeDocument *document = [XcodeHelper currentDocument];
    
    CPlusPlusImportSorterRunner *runner =
        [[CPlusPlusImportSorterRunner alloc] initWithTextView:textView document:document];
    [runner run];
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

- (void)sortSwiftImport
{
    if (![self isSwiftFile]) {
        return;
    }

    NSTextView *textView = [XcodeHelper currentSourceCodeView];
    IDESourceCodeDocument *document = [XcodeHelper currentDocument];

    SwiftImportSorterRunner *runner =
        [[SwiftImportSorterRunner alloc] initWithTextView:textView document:document];
    [runner run];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
