#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "HTTPStubs.h"
#import "HTTPStubsResponse.h"
#import "Compatibility.h"
#import "HTTPStubsResponse+JSON.h"
#import "NSURLRequest+HTTPBodyTesting.h"
#import "HTTPStubsPathHelpers.h"
#import "Compatibility.h"

FOUNDATION_EXPORT double OHHTTPStubs_BushelVersionNumber;
FOUNDATION_EXPORT const unsigned char OHHTTPStubs_BushelVersionString[];

