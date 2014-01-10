//
//  ViewController.h
//  assignment
//
//  Created by Mathijs on 21-12-13.
//  Copyright (c) 2013 Mathijs Vreeman. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol DataSourceProtocol <NSObject>

-(NSArray *)operations;
-(NSURL *)url;
@end


@interface ViewController : UIViewController
{
    IBOutlet UITextView *textView1;
    IBOutlet UITextView *textView2;
    IBOutlet UITextView *textView3;
}
@property (nonatomic, weak) IBOutlet id<DataSourceProtocol> dataSource;
- (IBAction)runButton:(id)sender;


@end
