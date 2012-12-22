//
//  SimpleRequest.m
//  DemoSummary
//
//  Created by Feather Chan on 12-12-19.
//  Copyright (c) 2012年 Feather Chan. All rights reserved.
//

#import "SimpleRequest.h"

@interface SimpleRequest()

@property (nonatomic,copy) RequestSucceed succeedHandler;
@property (nonatomic,copy) RequestFail failHandler;

@end

@implementation SimpleRequest

+ (void) requestWithURL:(NSURL *)url
                 scceed:(RequestSucceed) aSucceedHandler
                   fail:(RequestFail) aFailHandler
{
    SimpleRequest *request = [[[SimpleRequest alloc]initWithURL:url
                                                        succeed:aSucceedHandler
                                                           fail:aFailHandler]autorelease];
    [request start];
}

- (id)initWithURL:(NSURL *)url
           succeed:(RequestSucceed) aSucceedHandler
             fail:(RequestFail) aFailHandler
{
    self = [super init];
    if (self) {
        self.URL = url;
        self.succeedHandler = aSucceedHandler;
        self.failHandler = aFailHandler;
        self.hasCancel = NO;
    }
    return self;
}

- (void) start
{
    [self performSelectorInBackground:@selector(getResponse) withObject:nil];
}

-(void)cancel
{
    self.hasCancel = YES;
}

- (void) getResponse
{
    NSError *error = nil;
    NSData *data = [NSData dataWithContentsOfURL:self.URL options:NSDataReadingMappedIfSafe error:&error];
    NSString *text = [[[NSString alloc] initWithData:data
                                                encoding:NSUTF8StringEncoding] autorelease];
    
    if (self.hasCancel) return;
    
    if (error) {
        self.failHandler(error);
    }else{
        self.succeedHandler(data,text);
    }
}

- (void)dealloc
{
    self.succeedHandler = nil;
    self.failHandler = nil;
    self.URL = nil;
    [super dealloc];
}


@end
