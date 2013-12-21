//
//  dataRequest.m
//  assignment
//
//  Created by Mathijs on 2013-12-19.
//  Copyright (c) 2013 Mathijs Vreeman. All rights reserved.
//

#import "dataRequest.h"

@implementation dataRequest

@synthesize urlString, occurrencesOfWordOutput, tenthLetterOutput, everyTenthOutput;

- (void)getStringFrom:(NSURL *)url done:(void(^)())done {
    NSLog(@"URL is loaded only once");
    
    // get contents of the URL
    NSError *error;
    urlString = [NSString stringWithContentsOfURL:url encoding:NSASCIIStringEncoding error:&error];
    if (error) { NSLog(@"%@", error); }
    
    // callback that URL is loaded
    done();
}

- (void)getTenthLetterAndWhenComplete:(void(^)())completionCallback {
    NSLog(@"getTenthLetter called");
    
    // strip white space to make sure to return a letter
    NSString *urlStringWithoutWhiteSpace = [urlString stringByReplacingOccurrencesOfString:@" " withString:@""];
    urlStringWithoutWhiteSpace = [urlStringWithoutWhiteSpace stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    urlStringWithoutWhiteSpace = [urlStringWithoutWhiteSpace stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    urlStringWithoutWhiteSpace = [urlStringWithoutWhiteSpace stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    
    // locate tenth letter and set output
    NSString *tenthLetter = [urlStringWithoutWhiteSpace substringWithRange:NSMakeRange(10, 1)];
    tenthLetterOutput = [NSString stringWithFormat:@"the tenth letter is: %@", tenthLetter];

    // callback that work is done
    completionCallback();
}

- (void)getEveryTenthLetterAndWhenComplete:(void(^)())completionCallback {
    NSLog(@"getEveryTenthLetter called");
    
    //strip white space
    NSRegularExpression *regEx = [[NSRegularExpression alloc] initWithPattern:@"[a-zA-Z]" options:0 error:NULL];
    
    // loop to get every tenth letter and add it to an array
    NSMutableArray *everyTenth = [[NSMutableArray alloc] init];
    for (int i = 1; i < floor([urlString length]/10); i++)
    {
        NSString *letter = [urlString substringWithRange:NSMakeRange(i*10, 1)];
        NSInteger match = [regEx numberOfMatchesInString:letter options:0 range:NSMakeRange(0, [letter length])];
        
        if (match > 0) {
            [everyTenth addObject:letter];
        }
    }
    
    // create an output string from this array
    NSMutableString *stringFromEveryTenthArray = [[NSMutableString alloc] init];
    for (NSString *object in everyTenth)
    {
        [stringFromEveryTenthArray appendString:[object description]];
        [stringFromEveryTenthArray appendString:@", "];
    }
    everyTenthOutput = stringFromEveryTenthArray;
    
    // callback that work is done
    completionCallback();
}

- (void)getOccurrencesOfWordInTotal:(NSString *)wordToCount complete:(void(^)())completionCallback {
    NSLog(@"getOccurrencesOfWordInTotal called");
    
    //replace linebreaks and tabs by spaces to make the separation easier
    NSString *urlStringWithSpaces = [urlString stringByReplacingOccurrencesOfString:@"\n" withString:@" "];
    urlStringWithSpaces = [urlStringWithSpaces stringByReplacingOccurrencesOfString:@"\t" withString:@" "];
    urlStringWithSpaces = [urlStringWithSpaces stringByReplacingOccurrencesOfString:@"\r" withString:@" "];
    
    // count total number of words
    NSArray *wordsInUrlString = [urlStringWithSpaces componentsSeparatedByString:@" "];
    NSInteger totalWordCount = [wordsInUrlString count];
    
    // count the wordToCount and generate output string
    if (![wordToCount isEqualToString:@""])
    {
        // count occurrences of specific word
        NSInteger occurrencesOfWord = [urlString length] - [[urlString stringByReplacingOccurrencesOfString:wordToCount withString:@""] length];
        occurrencesOfWord = occurrencesOfWord / [wordToCount length];
        occurrencesOfWordOutput = [NSString stringWithFormat:@"\"%@\" was found %d times in %d words", wordToCount, occurrencesOfWord, totalWordCount];
    }
    else
    {
        occurrencesOfWordOutput = [NSString stringWithFormat:@"no search word was found"];
    }
    
    // callback that work is done
    completionCallback();
}

@end
