//
//  DataSource.m
//  assignment
//
//  Created by Manuel Meyer on 10.01.14.
//  Copyright (c) 2014 MatVre. All rights reserved.
//

#import "DataSource.h"
#import "DataRequest.h"

@implementation DataSource

-(NSURL *)url
{
    return [NSURL URLWithString:self.address];
}

-(NSArray *)operations
{
    NSMutableArray *operations = [NSMutableArray array];
    
    __block typeof(self) blockSelf = self;
    
    
    DataResponseBlock everyTenthLetter = ^id(id response, NSString **blockIdentifier){
        *blockIdentifier = @"everyTenthLetter";

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
            return letterArray;
        }
        return nil;
    };
    
    
    DataResponseBlock tenthLetter = ^id(id response, NSString **blockIdentifier){
        *blockIdentifier = @"tenthLetter";

        NSString *responseString = (NSString *)response;
        responseString = [blockSelf _flattendedString:responseString keepWords:NO];
        if ([responseString length] > 10) {
                return [responseString substringWithRange:NSMakeRange(9, 1)];
        
        }
        return nil;
    };
    
    
    DataResponseBlock occurance = ^id (id response, NSString **blockIdentifier){
        *blockIdentifier = @"occurrence";

        NSString *responseString = (NSString *)response;
        NSArray *words = [blockSelf _wordsFromString:responseString];
        __block NSUInteger count =0;
        NSString *wordToCount = [blockSelf name];

        [words enumerateObjectsUsingBlock:^(NSString *word, NSUInteger idx, BOOL *stop) {
            if ([word compare:wordToCount options:NSCaseInsensitiveSearch] == NSOrderedSame) {
                ++count;
            }
        }];
        return [NSString stringWithFormat:@"\"%@\" was found %d times in %d words", wordToCount, count, [words count]];
    };
    
    [operations addObject:[everyTenthLetter copy]];
    [operations addObject:[tenthLetter copy]];
    [operations addObject:[occurance copy]];
    
    return operations;
}



-(NSString *) _flattendedString:(NSString *)string keepWords:(BOOL)keepWords
{
    return [[self _wordsFromString:string] componentsJoinedByString:(keepWords) ? @" ": @""] ;
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
