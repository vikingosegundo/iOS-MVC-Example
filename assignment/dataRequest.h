//
//  dataRequest.h
//  assignment
//
//  Created by Mathijs on 2013-12-19.
//  Copyright (c) 2013 Mathijs Vreeman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface dataRequest : NSObject

@property (strong, nonatomic) NSString *urlString;

@property (strong, nonatomic) NSString *tenthLetterOutput;
@property (strong, nonatomic) NSString *everyTenthOutput;
@property (strong, nonatomic) NSString *occurrencesOfWordOutput;

- (void)getStringFrom:(NSURL *)url done:(void(^)())done;
- (void)getTenthLetterAndWhenComplete:(void(^)())completionCallback;
- (void)getEveryTenthLetterAndWhenComplete:(void(^)())completionCallback;
- (void)getOccurrencesOfWordInTotal:(NSString *)wordToCount complete:(void(^)())completionCallback;

@end
