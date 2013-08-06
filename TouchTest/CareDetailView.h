//
//  CareDetailView.h
//  TouchTest
//
//  Created by Dell on 12-7-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "/usr/include/sqlite3.h"
#import <sqlite3.h>

#define dataBaseName @"careNoti.db"

@interface CareDetailView : UIViewController {
    sqlite3 *database;
}

@property (nonatomic, retain) NSIndexPath *indexPath;

@end
