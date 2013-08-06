//
//  User.h
//  SQL_Demo
//
//  Created by AmorYin on 11-2-9.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface User : NSObject<NSCopying> {

	NSString *id;
	NSString *name;
	NSString *age;
	NSString *sex;
}
@property (nonatomic,retain)NSString *id;
@property (nonatomic,retain)NSString *name;
@property (nonatomic,retain)NSString *age;
@property (nonatomic,retain)NSString *sex;
@end
