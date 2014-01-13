//
//  ViewController.h
//  assignment
//
//  Created by Mathijs on 21-12-13.
//  Copyright (c) 2013 Mathijs Vreeman. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol ViewControllerDataSourceProtocol <NSObject>

-(NSArray *)operations;
-(NSURL *)url;
@end


@interface ViewController : UIViewController
{
    IBOutlet UITextView *textView1;
    IBOutlet UITextView *textView2;
    IBOutlet UITextView *textView3;
}
@property (nonatomic, strong) NSArray *blockIdentifier;
@property (nonatomic, strong) IBOutlet id<ViewControllerDataSourceProtocol> dataSource;
- (IBAction)runButton:(id)sender;


@end
