//
//  NSObject+atuoArchive.m
//  JRWX
//
//  Created by 张益豪 on 16/5/5.
//  Copyright © 2016年 Ktkt. All rights reserved.
//

#import "NSObject+atuoArchive.h"
#import <objc/runtime.h>

@implementation NSObject (atuoArchive)

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    Class currentClass = self.class;
    if (currentClass == NSObject.class) {
        return;
    }
    while (currentClass && currentClass != [NSObject class])
    {
        unsigned int count = 0;
        objc_property_t *pList = class_copyPropertyList(currentClass, &count);
        if (count>0) {
            for (int i=0;i<count;i++) {
                NSString *key = [NSString stringWithUTF8String:property_getName(pList[i])];
                [aCoder encodeObject: [self valueForKey:key] forKey:key];
            }
        }
        currentClass = class_getSuperclass(currentClass);
        free(pList);
    }
}

//#pragma message "Ignoring designated initializer warnings"
#pragma clang diagnostic ignored "-Wobjc-designated-initializers"

-(id)initWithCoder:(NSCoder *)aDecoder
{
    Class currentClass = self.class;
    if (currentClass == NSObject.class) {
        return nil;
    }
    while (currentClass && currentClass != [NSObject class])
    {
        unsigned int count = 0;
        objc_property_t *pList = class_copyPropertyList(currentClass, &count);
        if (count > 0) {
            for (int i = 0;i < count;i++) {
                NSString *key = [NSString stringWithUTF8String:property_getName(pList[i])];
                [self setValue:[aDecoder  decodeObjectForKey:key] forKey:key];
            }
        }
        currentClass = class_getSuperclass(currentClass);
        free(pList);
    }
    return  self;
}


@end
