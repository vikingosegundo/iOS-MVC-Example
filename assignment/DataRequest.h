//
//  dataRequest.h
//  assignment
//
//  Created by Mathijs on 2013-12-19.
//  Copyright (c) 2013 Mathijs Vreeman. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^DataResponseBlock)(id resposeObject);
typedef void(^FailurBlock)(NSError *error);

@interface DataRequest : NSObject
@property (nonatomic, strong) NSArray *operations;
@property (nonatomic, copy) FailurBlock failureBlock;
- (void)fetchFrom:(NSURL *)url;

@end
