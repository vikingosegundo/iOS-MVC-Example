//
//  DataSource.h
//  assignment
//
//  Created by Manuel Meyer on 10.01.14.
//  Copyright (c) 2014 MatVre. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewController.h"
@interface DataSource : NSObject<ViewControllerDataSourceProtocol>
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *name;

@end
