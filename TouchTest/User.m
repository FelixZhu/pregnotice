//
//  User.m
//  SQL_Demo
//
//  Created by AmorYin on 11-2-9.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "User.h"


@implementation User
@synthesize name;
@synthesize age;
@synthesize sex;
@synthesize id;

- (id)copyWithZone:(NSZone *)zone
{
	User *copy = [[[self class] allocWithZone:zone] init];
	copy.id = [[self id] copy];
	copy.name = [[self name] copy];
	copy.age = [[self age] copy];
	copy.age = [[self sex] copy];
	return copy;
}
@end