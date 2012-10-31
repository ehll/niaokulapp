//
//  Core.h
//  niaokula
//
//  Created by he on 12-10-31.
//  Copyright (c) 2012年 he. All rights reserved.
//

#ifndef niaokula_Core_h
#define niaokula_Core_h


#undef	AS_SINGLETION
#define AS_SINGLETION( __class ) \
+ (__class *)sharedInstance;

#undef	DEF_SINGLETION
#define DEF_SINGLETION( __class ) \
+ (__class *)sharedInstance \
{ \
static dispatch_once_t once; \
static __class * __singleton__; \
dispatch_once( &once, ^{ __singleton__ = [[__class alloc] init]; } ); \
return __singleton__; \
}

#undef	DEF_SINGLETION_THEN
#define DEF_SINGLETION_THEN( __class, __then ) \
+ (__class *)sharedInstance \
{ \
static dispatch_once_t once; \
static __class * __singleton__; \
dispatch_once( &once, ^{ __singleton__ = [[__class alloc] init]; [__singleton__ __then]; } ); \
return __singleton__; \
} \

#define IOS5_OR_LATER \
( [[[UIDevice currentDevice] systemVersion] compare:@"5.0"] != NSOrderedAscending )

#define IOS4_OR_LATER \
( [[[UIDevice currentDevice] systemVersion] compare:@"4.0"] != NSOrderedAscending )

#define IOS3_OR_LATER \
( [[[UIDevice currentDevice] systemVersion] compare:@"3.0"] != NSOrderedAscending )

#endif
