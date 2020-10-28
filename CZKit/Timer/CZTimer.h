//
//  CZTimer.h
//  Random
//
//  Created by yu mingming on 2020/9/16.
//  Copyright © 2020 刘超正. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CZTimer : NSObject

+ (NSString *)execTask:(void(^)(void))task start:(NSTimeInterval)start interval:(NSTimeInterval)interval repeating:(BOOL)repeating async:(BOOL)async;

+ (void)cancelTask:(NSString *)task;

@end

NS_ASSUME_NONNULL_END
