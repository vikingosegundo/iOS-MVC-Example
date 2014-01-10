//
//  dataRequest.h
//  assignment
//
//  Created by Mathijs on 2013-12-19.
//  Copyright (c) 2013 Mathijs Vreeman. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DataRequestDelegate <NSObject>

-(void)result:(id)result forBlockWithIdenfier:(NSString *)identifier;

@end


typedef id(^DataResponseBlock)(id resposeObject, NSString **blockIdentifier);
typedef void(^FailurBlock)(NSError *error);

@interface DataRequest : NSObject
@property (nonatomic, strong) NSArray *operations;
@property (nonatomic, copy) FailurBlock failureBlock;
@property (nonatomic, weak) id<DataRequestDelegate> delegate;
- (void)fetchFrom:(NSURL *)url;

@end
