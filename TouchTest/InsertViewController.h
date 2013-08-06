//
//  SQL_DemoViewController.h
//  SQL_Demo
//
//  Created by AmorYin on 11-2-9.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "/usr/include/sqlite3.h"
#import <sqlite3.h>
#define DataFile @"data.sqlite3"
#define TableName  @"UserTable"

@interface InsertViewController : UIViewController {
	UITextField *txt1;
	UITextField *txt2;
	UITextField *txt3;
	sqlite3 *database;
}
@property (nonatomic,retain)UITextField *txt1;
@property (nonatomic,retain)UITextField *txt2;
@property (nonatomic,retain)UITextField *txt3;
-(NSString*)databasePath;
@end

