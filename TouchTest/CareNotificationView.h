//
//  CareNotificationView.h
//  TouchTest
//
//  Created by Dell on 12-7-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "/usr/include/sqlite3.h"
#import <sqlite3.h>

#define tableHeight 40
#define dataBaseName @"careNoti.db"

@interface CareNotificationView : UITableViewController {
    sqlite3 *database;
    NSString *plistURL;
    NSMutableDictionary *dict;
}

@end

