//
//  JustUseNewSpec.m
//  Copyright (c) 2013 modocache
//


#import <Kiwi/Kiwi.h>


SPEC_BEGIN(JustUseNewSpec)

describe(@"+new", ^{
    it(@"just calls +alloc, then -init", ^{
        KWMock *mock = [KWMock mock];

        [[NSObject should] receive:@selector(alloc) andReturn:mock];
        [[mock should] receive:@selector(init)];
        
        [NSObject new];
    });
    
    it(@"isn't autoreleased or anything (not that it matters when using ARC, anyway), "
       @"contrary to what some might have you believe", ^{
        KWMock *mock = [KWMock mock];
        
        [NSObject stub:@selector(alloc) andReturn:mock];
        [mock stub:@selector(init)];
        [[mock shouldNot] receive:@selector(autorelease)];
        
        [NSObject new];
    });
    
    context(@"when considering whether to use +alloc/-init or +new", ^{
        it(@"is faster to type +new", ^{
            NSUInteger allocInitLength = [@"[[NSObject alloc] init];" length];
            NSUInteger newLength = [@"[NSObject new];" length];
            
            [[theValue(newLength) should] beLessThan:theValue(allocInitLength)];
        });
        
        xit(@"is clear that you should just use +new", ^{});
    });
});

SPEC_END


