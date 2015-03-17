//
//  XcodeComponents.h
//  ImportSorter
//
//  Created by Jun Hashimoto on 2015/03/10.
//  Copyright (c) 2015年 Jun Hashimoto. All rights reserved.
//

#ifndef ImportSorter_XcodeComponents_h
#define ImportSorter_XcodeComponents_h

// :: Framework ::
#import <Cocoa/Cocoa.h>

@interface DVTTextStorage : NSTextStorage
- (void)replaceCharactersInRange:(NSRange)range withString:(NSString *)string withUndoManager:(id)undoManager;
- (NSRange)lineRangeForCharacterRange:(NSRange)range;
- (NSRange)characterRangeForLineRange:(NSRange)range;
- (void)indentCharacterRange:(NSRange)range undoManager:(id)undoManager;
@end


@interface IDESourceCodeDocument : NSDocument

@property(readonly) DVTTextStorage *textStorage;

@end

@interface IDEEditor : NSObject

@property(readonly) IDESourceCodeDocument *sourceCodeDocument;

@end

@class IDESourceCodeEditor;

@interface IDESourceCodeEditor : IDEEditor
@property (retain) NSTextView *textView;
- (IDESourceCodeDocument *)sourceCodeDocument;
@end


@interface IDEEditorContext : NSObject
@property(retain, nonatomic) IDEEditor *editor;
@end

@interface IDEEditorArea : NSObject

@property(retain, nonatomic) IDEEditorContext *lastActiveEditorContext;

@end


@interface IDEWorkspaceWindowController : NSObject

@property(readonly) IDEEditorArea *editorArea;

@end

#endif
