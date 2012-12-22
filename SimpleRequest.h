//
//  SimpleRequest.h
//  DemoSummary
//
//  Created by Feather Chan on 12-12-19.
//  Copyright (c) 2012年 Feather Chan. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^RequestSucceed)(NSData *responseData, NSString *responseUTF8Text);
typedef void (^RequestFail)(NSError *error);


@interface SimpleRequest : NSObject

@property (nonatomic,retain) NSURL *URL;
@property (nonatomic) BOOL hasCancel;

+ (void)requestWithURL:(NSURL *)url scceed:(RequestSucceed) succeedHandler fail:(RequestFail) failHandler;

- (id)initWithURL:(NSURL *)url succeed:(RequestSucceed) aSucceedHandler fail:(RequestFail) aFailHandler;
- (void)start;
- (void)cancel;

@end
