//
//  UIView+FGCloning.m
//  SunUp
//
//  Created by Finn Gaida on 13.11.13.
//  Copyright (c) 2013 Finn Gaida. All rights reserved.
//

@interface UIView (FGCloning)
-(id)clone;
@end

@implementation UIView (FGCloning)

- (id) clone {
    NSData *archivedViewData = [NSKeyedArchiver archivedDataWithRootObject: self];
    id clone = [NSKeyedUnarchiver unarchiveObjectWithData:archivedViewData];
    return clone;
}

@end