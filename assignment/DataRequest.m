//
//  dataRequest.m
//  assignment
//
//  Created by Mathijs on 2013-12-19.
//  Copyright (c) 2013 Mathijs Vreeman. All rights reserved.
//

#import "DataRequest.h"

@implementation DataRequest


- (void)fetchFromURL:(NSURL *)url
{
    __block NSError *err;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *responseString = [NSString stringWithContentsOfURL:url
                                                            encoding:NSASCIIStringEncoding
                                                               error:&err];
        
        if (err) {
            if (self.failureBlock) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    self.failureBlock(err);
                });
            }
        } else {
            for (DataResponseBlock obj in _operations) {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSString *iden;
                    id result = obj(responseString, &iden);
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.delegate result:result forBlockWithIdenfier:iden];
                    });
                });
            }
        }
        
    });
    
}


@end
