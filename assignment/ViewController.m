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
@property (strong, nonatomic) IBOutlet DataRequest *dataRequest;

@end

@implementation ViewController



- (IBAction)runButton:(id)sender
{
    self.dataRequest.operations = [self.dataSource operations];
    FailurBlock failure = ^(NSError *error){
        [[[UIAlertView alloc] initWithTitle:@"error"
                                    message:[error localizedDescription]
                                   delegate:nil
                          cancelButtonTitle:@"dissmiss"
                          otherButtonTitles: nil] show];
    };
    
    self.dataRequest.failureBlock = failure;
    [self.dataRequest fetchFromURL:[self.dataSource url]];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self runButton:nil];
}

-(void)result:(id)result forBlockWithIdenfier:(NSString *)identifier
{
    
    NSArray *views = @[textView1, textView2, textView3];
    NSInteger idx = [_blockIdentifier indexOfObject:identifier];
    if (idx!= NSNotFound) {
        [views[idx] setValue: ([result isKindOfClass:[NSArray class]])?[result componentsJoinedByString:@""] : result
                      forKey:@"text"];
    }
}


@end