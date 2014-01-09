//
//  ViewController.m
//  assignment
//
//  Created by Mathijs on 21-12-13.
//  Copyright (c) 2013 Mathijs Vreeman. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController


- (IBAction)runButton:(id)sender {
    NSURL *url = [NSURL URLWithString:@"https://www.google.com/"];
    NSString *wordToCount = @"google";
    
    DataRequest *request = [[DataRequest alloc] init];
    [request tenthLetterFromURL:url
                        onSuccess:^(NSString* letter) {
                            [textView1 setText:letter];
                        } onFailure:^(NSError* error) {
                                    [[[UIAlertView alloc] initWithTitle:@"error" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"dissmiss" otherButtonTitles: nil] show];
                        }];
    
    [request everyTenthLetterFromURL:url
                           onSuccess:^(NSArray * letters){
                               [textView2 setText: [letters componentsJoinedByString:@""]];
                           } onFailure:^(NSError * error) {
                               [[[UIAlertView alloc] initWithTitle:@"error" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"dissmiss" otherButtonTitles: nil] show];
                           }];
    
    
    [request  allWordsFromURL:url
                    onSuccess:^(NSArray *words) {
                        __block NSUInteger count =0;
                        
                        [words enumerateObjectsUsingBlock:^(NSString *word, NSUInteger idx, BOOL *stop) {
                            if ([word compare:wordToCount options:NSCaseInsensitiveSearch]) {
                                ++count;
                            }
                        }];
                        [textView3 setText:[NSString stringWithFormat:@"\"%@\" was found %d times in %d words", wordToCount, count, [words count]]];
                        
                    } onFailure:^(NSError *error) {
                        [[[UIAlertView alloc] initWithTitle:@"error" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"dissmiss" otherButtonTitles: nil] show];
                    }];
}

@end