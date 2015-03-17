//
//  XcodeHelper.m
//  ImportSorter
//
//  Created by Jun Hashimoto on 2015/03/10.
//  Copyright (c) 2015年 Jun Hashimoto. All rights reserved.
//

#import "XcodeHelper.h"

@implementation XcodeHelper

// 現在のソースコードエディターを返す
+ (IDESourceCodeEditor *)currentEditor
{
    NSWindowController *currentWindowController = [[NSApp keyWindow] windowController];
    if ([currentWindowController
            isKindOfClass:NSClassFromString(@"IDEWorkspaceWindowController")]) {
        IDEWorkspaceWindowController *workspaceController =
            (IDEWorkspaceWindowController *)currentWindowController;
        IDEEditorArea *editorArea = [workspaceController editorArea];
        IDEEditorContext *editorContext = [editorArea lastActiveEditorContext];
        IDEEditor *editor = (IDEEditor *)[editorContext editor];

        if ([editor isKindOfClass:NSClassFromString(@"IDESourceCodeEditor")]) {
            return (IDESourceCodeEditor *)editor;
        }
    }
    return nil;
}

+ (IDESourceCodeDocument *)currentDocument
{
    IDESourceCodeEditor *editor = [self currentEditor];
    if (editor) {
        return editor.sourceCodeDocument;
    }
    return nil;
}

+ (NSTextView *)currentSourceCodeView
{
    IDESourceCodeEditor *editor = [self currentEditor];
    if (editor) {
        return editor.textView;
    }
    return nil;
}

@end
