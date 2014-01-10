//
//  ViewController.m
//  assignment
//
//  Created by Mathijs on 21-12-13.
//  Copyright (c) 2013 Mathijs Vreeman. All rights reserved.
//

#import "ViewController.h"
#import "DataRequest.h"

@interface ViewController ()

@end

@implementation ViewController


- (IBAction)runButton:(id)sender {
    NSURL *url = [NSURL URLWithString:@"https://www.google.com/"];
    NSString *wordToCount = @"google";
    
    DataRequest *request = [[DataRequest alloc] init];
    
    NSMutableArray *operations = [NSMutableArray array];
    
    __block typeof(self) blockSelf = self;
    
    
    DataResponseBlock everyTenthLetter = ^(id response){
        if ([response isKindOfClass:[NSString class]]) {
            NSString *responseString = (NSString *)response;
            responseString = [blockSelf _flattendedString:responseString keepWords:NO];
            NSMutableArray *letterArray = [@[] mutableCopy];
            
            [responseString enumerateSubstringsInRange:NSMakeRange(0, [responseString length])
                                               options:(NSStringEnumerationByComposedCharacterSequences)
                                            usingBlock:^(NSString *substring,
                                                         NSRange substringRange,
                                                         NSRange enclosingRange,
                                                         BOOL *stop) {
                                                if (substringRange.location % 10 == 9) {
                                                    [letterArray addObject:substring];
                                                }
                                            }];
            dispatch_async(dispatch_get_main_queue(), ^{
                [textView2 setText:[letterArray componentsJoinedByString:@""]];
            });
        }
    };
    
    
    DataResponseBlock tenthLetter = ^(id response){
        NSString *responseString = (NSString *)response;
        responseString = [blockSelf _flattendedString:responseString keepWords:NO];
        if ([responseString length] > 10) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [textView1 setText:[responseString substringWithRange:NSMakeRange(9, 1)]];
            });
        }
    };
    
    DataResponseBlock occurance = ^(id response){
        NSString *responseString = (NSString *)response;
        NSArray *words = [blockSelf _wordsFromString:responseString];
        __block NSUInteger count =0;
        
        [words enumerateObjectsUsingBlock:^(NSString *word, NSUInteger idx, BOOL *stop) {
            if ([word compare:wordToCount options:NSCaseInsensitiveSearch]) {
                ++count;
            }
        }];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [textView3 setText:[NSString stringWithFormat:@"\"%@\" was found %d times in %d words", wordToCount, count, [words count]]];
        });
        
        
        
    };
    
    FailurBlock failure = ^(NSError *error){
        [[[UIAlertView alloc] initWithTitle:@"error" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"dissmiss" otherButtonTitles: nil] show];

    };
    
    [operations addObject:[everyTenthLetter copy]];
    [operations addObject:[tenthLetter copy]];
    [operations addObject:[occurance copy]];
    
    
    request.operations = operations;
    request.failureBlock = failure;
    [request fetchFrom:url];
    
}


-(NSString *) _flattendedString:(NSString *)string keepWords:(BOOL)keepWords
{
    return (keepWords) ? [[self _wordsFromString:string] componentsJoinedByString:@" "]
    : [[self _wordsFromString:string] componentsJoinedByString:@""] ;
}


-(NSArray *)_wordsFromString:(NSString *)string
{
    NSRegularExpression *regEx = [[NSRegularExpression alloc] initWithPattern:@"[a-zA-Z]+" options:0 error:NULL];
    
    NSArray *matches = [regEx matchesInString:string
                                      options:0
                                        range:NSMakeRange(0, [string length]-1)];
    NSMutableArray *wordArray = [@[] mutableCopy];
    
    [matches enumerateObjectsUsingBlock:^(NSTextCheckingResult *match, NSUInteger idx, BOOL *stop) {
        [wordArray addObject:[string substringWithRange:[match range]]];
    }];
    return wordArray;
    
}
@end