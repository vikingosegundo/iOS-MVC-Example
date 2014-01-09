//
//  dataRequest.h
//  assignment
//
//  Created by Mathijs on 2013-12-19.
//  Copyright (c) 2013 Mathijs Vreeman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataRequest : NSObject

- (void)fetchFrom:(NSURL *)url
        onSuccess:(void(^)(id response))successBlock
        onFailure:(void(^)(NSError * error)) failureBlock;

- (void)everyTenthLetterFromURL:(NSURL *) url
                      onSuccess:(void(^)(NSArray *letters))success
                      onFailure:(void (^)(NSError *error))failureBlock;

- (void)tenthLetterFromURL:(NSURL *) url
                 onSuccess:(void(^)(NSString *letter))success
                 onFailure:(void (^)(NSError *error))failureBlock;

-(void) allWordsFromURL:(NSURL *)url
              onSuccess:(void (^)(NSArray *words))success
              onFailure:(void (^)(NSError *error))failureBlock;
@end
