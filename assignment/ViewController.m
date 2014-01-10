//
//  ViewController.m
//  assignment
//
//  Created by Mathijs on 21-12-13.
//  Copyright (c) 2013 Mathijs Vreeman. All rights reserved.
//

#import "ViewController.h"
#import "DataRequest.h"

@interface ViewController ()<DataRequestDelegate>

@end

@implementation ViewController



- (IBAction)runButton:(id)sender {
    
    DataRequest *request = [[DataRequest alloc] init];
    request.delegate = self;

    request.operations = [self.dataSource operations];
    FailurBlock failure = ^(NSError *error){
        [[[UIAlertView alloc] initWithTitle:@"error" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"dissmiss" otherButtonTitles: nil] show];
        
    };
    
    request.failureBlock = failure;
    [request fetchFrom:[self.dataSource url]];
    
}

-(void)result:(id)result forBlockWithIdenfier:(NSString *)identifier
{
    if ([identifier isEqualToString:@"everyTenthLetter"]) {
        [textView2 setText:[result componentsJoinedByString:@""]];
    } else if ([identifier isEqualToString:@"tenthLetter"]) {
        [textView1 setText:result];
    } else if ([identifier isEqualToString:@"occurrence"]) {
        [textView3 setText:result];
    }

}


@end