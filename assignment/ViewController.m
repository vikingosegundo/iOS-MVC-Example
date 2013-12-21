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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)runButton:(id)sender {
    // hardcode some settings
    NSURL *url = [NSURL URLWithString:@"https://www.google.com/"];
    NSString *wordToCount = @"google";
    
    // alloc data request object and perform all 3 data processing calls async on getStringFromUrl-completion callback
    dataRequest *request = [[dataRequest alloc] init];
    [request getStringFrom:url done:^{
        
        // 1) 10thLetterRequest > get output from data request object async and put it in textView (UI update on main thread)
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            [request getTenthLetterAndWhenComplete:^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    [textView1 setText:request.tenthLetterOutput];
                });
            }];
        });
        
        // 2) Every10thLetterRequest > get output from data request object async and put it in textView (UI update on main thread)
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            [request getEveryTenthLetterAndWhenComplete:^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    [textView2 setText:request.everyTenthOutput];
                });
            }];
        });
        
        // 3) WordCounterRequest > get output from data request object async and put it in textView (UI update on main thread)
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            [request getOccurrencesOfWordInTotal:wordToCount complete:^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    [textView3 setText:request.occurrencesOfWordOutput];
                });
            }];
        });
    }];
    
    // if you want to see the urlString
    //NSLog(@"%@", request.urlString);
}

@end