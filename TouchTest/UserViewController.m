//
//  CareNotification.m
//  TouchTest
//
//  Created by Lion User on 03/06/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UserViewController.h"

#import "MainScrollView.h"
#import "User.h"

@implementation UserViewController


-(NSString*)databasePath
{
	NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *pathname = [path objectAtIndex:0];
	return [pathname stringByAppendingPathComponent:DataFile];
}

- (User*)getUser:(int)id
{
	if (sqlite3_open([[self databasePath] UTF8String],&database) != SQLITE_OK) {
		sqlite3_close(database);
		NSAssert(0,@"open database faild!");
		return nil;
	}
	User *user = [[User alloc] init];
	NSString *countSQL = [NSString stringWithFormat:@"SELECT ROW,NAME,AGE,SEX FROM UserTable WHERE ROW = %i",id];
	sqlite3_stmt *statement;
	if (sqlite3_prepare_v2(database, [countSQL UTF8String], -1, &statement, nil) == SQLITE_OK) {
        
		if (sqlite3_step(statement)==SQLITE_ROW) {
            
			user.id = [NSString stringWithFormat:@"%d",sqlite3_column_int(statement,0)];
            
			user.name = [NSString stringWithFormat:@"%s",sqlite3_column_text(statement,1)];
            
			user.age =[NSString stringWithFormat:@"%s",sqlite3_column_text(statement,2)];
            
			user.sex = [NSString stringWithFormat:@"%s",sqlite3_column_text(statement,3)];
		}
		sqlite3_finalize(statement);
		return user;
	}
	return nil;
}

- (NSInteger)getTotalCount
{
	if (sqlite3_open([[self databasePath] UTF8String],&database) != SQLITE_OK) {
		sqlite3_close(database);
		NSAssert(0,@"open database faild!");
		return 0;
	}
	NSString *countSQL = @"SELECT COUNT(*) FROM UserTable";
	sqlite3_stmt *statement;
	if (sqlite3_prepare_v2(database, [countSQL UTF8String], -1, &statement, nil) == SQLITE_OK) {
		while (sqlite3_step(statement)==SQLITE_ROW) {
			int i = sqlite3_column_int(statement,0);
			sqlite3_finalize(statement);
			return i;
		}
	}
	return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [self getTotalCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"CellIdentifier";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
	}
	
	User *user = [self getUser:[indexPath row]+1];
    //	NSLog(@"%@",user);
	cell.textLabel.text = [NSString stringWithFormat:@"%@ | %@  %@ %@",user.id,user.name,user.age,user.sex];
	return cell;
}

@end