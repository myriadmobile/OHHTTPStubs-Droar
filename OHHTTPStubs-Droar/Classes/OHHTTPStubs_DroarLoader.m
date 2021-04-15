//
//  OHHTTPStubs_DroarLoader.m
//  OHHTTPStubs-Droar
//
//  Created by Jangle's MacBook Pro on 4/8/21.
//

#import "ohhttpstubs_DroarLoader.h"
#import <Droar/Droar-Swift.h>
#import <OHHTTPStubs_Droar/OHHTTPStubs_Droar-Swift.h>

@implementation OHHTTPStubs_DroarLoader

+ (void)load {
    SEL selector = NSSelectorFromString(@"sharedInstance");
    if ([OHHTTPStubs_Droar respondsToSelector:selector])
    {
        [Droar register:[OHHTTPStubs_Droar performSelector:selector]];
    }
}

@end

