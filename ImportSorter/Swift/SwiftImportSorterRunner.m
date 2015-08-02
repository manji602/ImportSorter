//
//  SwiftImportSorterRunner.m
//  ImportSorter
//
//  Created by jun.hashimoto on 2015/03/28.
//  Copyright (c) 2015年 Jun Hashimoto. All rights reserved.
//

#import "SwiftImportSorterRunner.h"
// :: Other ::
#import "SwiftClassRole.h"

@interface SwiftImportSorterRunner ()
@property (nonatomic) SwiftClassRole *classRole;
@end

@implementation SwiftImportSorterRunner

#pragma mark - public methods

static NSString *const kImportDeclarationPrefix = @"import ";
static NSString *const kClassRoleLabelPrefix = @"// :: ";

- (instancetype)initWithTextView:(NSTextView *)textView document:(IDESourceCodeDocument *)document
{
    self = [super init];

    if (self) {
        self.sourceCodeView = textView;
        self.sourceCodeDocument = document;
        self.importDeclarationPrefix = kImportDeclarationPrefix;
        self.classRoleLabelPrefix = kClassRoleLabelPrefix;
        _classRole = [[SwiftClassRole alloc] init];
    }
    return self;
}

- (void)run
{
    NSArray *importDeclarations = [self exportImportDeclarations];
    NSArray *sortedImportDeclarations = [self sortImportDeclarations:importDeclarations];

    NSMutableString *replacementString = [NSMutableString string];

    for (NSString *importDeclaration in sortedImportDeclarations) {
        [replacementString appendString:importDeclaration];
    }

    [self insertSortedImportDeclaration:replacementString];
}

#pragma mark - private methods
- (NSArray *)sortImportDeclarations:(NSArray *)originalImportDeclarations
{
    NSMutableArray *sortedImportDeclarations = [NSMutableArray array];

    // 各ClassRoleの#import宣言を格納するためのNSArrayを生成する
    // 各要素には、該当する#import宣言を格納するNSArrayを代入する
    NSMutableArray *importDeclarationsArray = [NSMutableArray array];
    for (int i = 0; i <= [_classRole lastImportClassRoleIndex]; i++) {
        NSMutableArray *arrayByImportRole = [NSMutableArray array];
        importDeclarationsArray[i] = arrayByImportRole;
    }

    // #import宣言をしている行毎にClassRoleを割り振り、上述のNSArrayに代入する
    for (NSString *importDeclaration in originalImportDeclarations) {
        SwiftImportClassRole importClassRole = [_classRole getImportClassRole:importDeclaration];
        NSMutableArray *arrayByImportRole = importDeclarationsArray[importClassRole];
        [arrayByImportRole addObject:importDeclaration];

        importDeclarationsArray[importClassRole] = arrayByImportRole;
    }

    // ClassRole毎のNSArrayをSortし、順番に格納する
    for (int i = 0; i <= [_classRole lastImportClassRoleIndex]; i++) {
        NSArray *importDeclarationsByImportClassRole =
            [importDeclarationsArray[i] sortedArrayUsingSelector:@selector(compare:)];

        // 該当するClassRoleに割り当てられた行が1行でもある場合は、Class Roleのラベルを付与する
        if ([importDeclarationsByImportClassRole count] != 0) {
            [sortedImportDeclarations addObject:[_classRole labelForClassRole:i]];
        }

        for (NSString *importDeclaration in importDeclarationsByImportClassRole) {
            [sortedImportDeclarations addObject:importDeclaration];
        }
    }

    return [sortedImportDeclarations copy];
}

@end
