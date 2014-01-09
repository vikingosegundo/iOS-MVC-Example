//
//  dataRequest.m
//  assignment
//
//  Created by Mathijs on 2013-12-19.
//  Copyright (c) 2013 Mathijs Vreeman. All rights reserved.
//

#import "DataRequest.h"

@implementation DataRequest


- (void)fetchFrom:(NSURL *)url
        onSuccess:(void(^)(id response))successBlock
        onFailure:(void (^)(NSError *))failureBlock
{

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSError *error;
        NSString *urlString = [NSString stringWithContentsOfURL:url encoding:NSASCIIStringEncoding error:&error];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error) {
                failureBlock(error);
            } else {
                successBlock(urlString);
            }
        });
    });
   
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


-(NSString *) _flattendedString:(NSString *)string keepWords:(BOOL)keepWords
{
    return (keepWords) ? [[self _wordsFromString:string] componentsJoinedByString:@" "]
                       : [[self _wordsFromString:string] componentsJoinedByString:@""] ;
}


-(void)everyTenthLetterFromURL:(NSURL *)url
                     onSuccess:(void (^)(NSArray *))success
                     onFailure:(void (^)(NSError *))failureBlock
{
    [self fetchFrom:url
          onSuccess:^(id response) {
        if ([response isKindOfClass:[NSString class]]) {
            NSString *responseString = (NSString *)response;
            responseString = [self _flattendedString:responseString keepWords:NO];
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
            success(letterArray);
        }
    } onFailure:^(NSError *error) {
        failureBlock(error);
    }] ;

}

-(void)tenthLetterFromURL:(NSURL *)url
                onSuccess:(void (^)(NSString * letter))success
                onFailure:(void (^)(NSError *))failureBlock
{
    [self fetchFrom:url
          onSuccess:^(id response) {
              if ([response isKindOfClass:[NSString class]]) {
                  NSString *responseString = (NSString *)response;
                  
                  responseString = [self _flattendedString:responseString keepWords:NO];
                  if ([responseString length] > 10) {
                      success([responseString substringWithRange:NSMakeRange(9, 1)]);
                  }
              }
          } onFailure:^(NSError *error) {
              failureBlock(error);
          }] ;
}

-(void) allWordsFromURL:(NSURL *)url
              onSuccess:(void (^)(NSArray *words))success
              onFailure:(void (^)(NSError *))failureBlock
{
    [self fetchFrom:url
          onSuccess:^(id response) {
              if ([response isKindOfClass:[NSString class]]) {
                  NSString *responseString = (NSString *)response;
                  
                  success([self _wordsFromString:responseString]);
              }
          } onFailure:^(NSError *error) {
              failureBlock(error);
          }] ;
}
@end
