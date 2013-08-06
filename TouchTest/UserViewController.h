//
//  CareNotification.h
//  TouchTest
//
//  Created by Lion User on 03/06/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "/usr/include/sqlite3.h"
#import <sqlite3.h>

#define DataFile @"data.sqlite3"

@interface UserViewController : UITableViewController {
    sqlite3 *database;
}

@end
