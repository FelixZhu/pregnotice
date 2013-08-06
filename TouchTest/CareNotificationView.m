//
//  CareNotificationView.m
//  TouchTest
//
//  Created by Dell on 12-7-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CareNotificationView.h"
#import "CareDetailView.h"
#import "IndexButton.h"

@implementation CareNotificationView

-(NSString*)databasePath
{
	NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *pathname = [path objectAtIndex:0];
	return [pathname stringByAppendingPathComponent:dataBaseName];
}

- (void)pop {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addTopButton {
    
    UIImage *titleImage = [UIImage imageNamed:@"carenotiTitle.png"];
    UIImageView *titleView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, titleImage.size.width, titleImage.size.height)];
    titleView.center = CGPointMake(160, 22);
    titleView.image = titleImage;
    UIImage *navImage = [UIImage imageNamed:@"navBar.png"];
    UIImageView *navBarView = [[UIImageView alloc] initWithImage:navImage];
    [self.navigationController.navigationBar addSubview:navBarView];
    [self.navigationController.navigationBar addSubview:titleView];
//    self.navigationController.navigationBar.hidden = YES;
    self.navigationItem.hidesBackButton = YES;
    
    UIImage *backButtonImage = [UIImage imageNamed:@"backButton.png"];
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, backButtonImage.size.width, backButtonImage.size.height)];
    [backButton addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    backButton.center = CGPointMake(30, 22);
    backButton.backgroundColor = [UIColor clearColor];
    [backButton setImage:backButtonImage forState:UIControlStateNormal];
    [self.navigationController.navigationBar addSubview:backButton];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
	if (sqlite3_open([[self databasePath] UTF8String],&database) != SQLITE_OK) {
		sqlite3_close(database);
        NSLog(@"open databse error");
	}
    plistURL = [[NSBundle mainBundle] pathForResource:@"checkList" ofType:@"plist"];
    dict = [[NSMutableDictionary alloc] initWithContentsOfFile:plistURL];
    
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    UIImageView *backgroudView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"backgroudView.png"]];
//    self.tableView.backgroundView = backgroudView;
}

- (void)viewDidUnload {
    [super viewDidUnload];
    
    sqlite3_close(database);
}

- (void)viewWillAppear:(BOOL)animated {
    
    [self addTopButton];
}

- (NSInteger)getCount:(NSInteger)section
{
    NSString *getCountSQL = [NSString stringWithFormat:@"select count from care_reminder_title where _id=%i",  section+1];
    NSInteger count;
    sqlite3_stmt *statement;
    if(sqlite3_prepare_v2(database, [getCountSQL UTF8String], -1, &statement, nil) == SQLITE_OK) {
        if(sqlite3_step(statement) == SQLITE_ROW) {
            count = sqlite3_column_int(statement, 0);
        }
        sqlite3_finalize(statement);
        return count;
    }
    return 0;
}

- (NSString *)getTitle:(NSIndexPath *)indexPath
{
	NSString *getTitleSQL = [NSString stringWithFormat:@"SELECT item%i_title FROM care_reminder_title WHERE _id = %i", [indexPath row]+1, [indexPath section]+1];
    NSString *title;
	sqlite3_stmt *statement;
	if (sqlite3_prepare_v2(database, [getTitleSQL UTF8String], -1, &statement, nil) == SQLITE_OK) {
		if (sqlite3_step(statement) == SQLITE_ROW) {
            title = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement,0)];
		}
		sqlite3_finalize(statement);
		return title;
	}
	return nil;
}

- (BOOL)ifChecked:(NSIndexPath *)indexPath {
    NSString *weekKey = [NSString stringWithFormat:@"week%i", [indexPath section]];
    NSNumber *weekNum = [dict objectForKey:weekKey];
    NSInteger cmpNum = 1 << [indexPath row];
    if([weekNum integerValue] & cmpNum)
    {
        return YES;
    }
    return NO;
}

//- (void)testFunc:(UIButton *)sender {
//    [self performSelector:@selector(clickItem:atIndex:) withObject:sender withObject:indexPath];
//}

- (void)clickItem:(IndexButton *)sender {
    
    NSLog(@"%@", sender.indexPath);

    UIImage *checkImage;
    if([self ifChecked:sender.indexPath] == TRUE)
    {
        checkImage = [UIImage imageNamed:@"checkoffBox.png"];
    }
    else
    {
        checkImage = [UIImage imageNamed:@"checkonBox.png"]; 
    }
    [sender setImage:checkImage forState:UIControlStateNormal];
    
    NSString *weekKey = [NSString stringWithFormat:@"week%i", [sender.indexPath section]];
    NSNumber *weekNum = [dict objectForKey:weekKey];
    int cmpNum = 1 << [sender.indexPath row];
    printf("the cmpNum is %i\n", cmpNum);
    int alterWeekInt = [weekNum intValue] | cmpNum;
    printf("the alterWeekInt is %i\n", alterWeekInt);
    
    NSNumber *alterWeekNum = [[NSNumber alloc] initWithInt:alterWeekInt];
    
    NSLog(@"the alter week number is %@", alterWeekNum);
    [dict setValue:alterWeekNum forKey:weekKey];
    [dict writeToFile:plistURL atomically:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self getCount:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
	static NSString *CellIdentifier = @"CellIdentifier";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.editingAccessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}
    
    UIImageView *backgroudView = [[UIImageView alloc] initWithFrame:CGRectMake(8, 0, self.view.frame.size.width-16, tableHeight)];
    if ([indexPath row] % 2) {
        backgroudView.backgroundColor = [UIColor whiteColor];
    }
    else{     
        backgroudView.backgroundColor = [UIColor colorWithRed:219.0f/255.0f green:247.0f/255.0f blue:225.0f/255.0f alpha:1.0f];
    }
    [cell.contentView addSubview:backgroudView];
    
    UIImage *unchecked = [UIImage imageNamed:@"checkoffBox.png"];
    UIImage *checked = [UIImage imageNamed:@"checkonBox.png"];
	IndexButton *checkBox = [[IndexButton alloc] initWithFrame:CGRectMake(12, 11, unchecked.size.width, unchecked.size.height)];
    if([self ifChecked:indexPath] == TRUE)
    {
        [checkBox setImage:checked forState:UIControlStateNormal];
    }
    else
    {
        [checkBox setImage:unchecked forState:UIControlStateNormal];        
    }
    checkBox.backgroundColor = [UIColor clearColor];
    checkBox.indexPath = indexPath;
    [checkBox addTarget:self action:@selector(clickItem:) forControlEvents:UIControlEventTouchUpInside];
    [cell addSubview:checkBox];
    
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 5, 200, 30)];
	textLabel.text = [NSString stringWithFormat:@"%@",[self getTitle:indexPath]];
    textLabel.font = [UIFont systemFontOfSize:15];
    textLabel.numberOfLines = 0;
    if ([indexPath row] % 2) {
        textLabel.backgroundColor = [UIColor whiteColor];   
    }
    else{     
        textLabel.backgroundColor = [UIColor colorWithRed:219.0f/255.0f green:247.0f/255.0f blue:225.0f/255.0f alpha:1.0f];
    }
    [cell.contentView addSubview:textLabel];
    
	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 27;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, self.view.frame.size.width, 20)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = [NSString stringWithFormat:@"怀孕第%i周", section+1];
    titleLabel.font = [UIFont systemFontOfSize:15];
    
    UIImage *cellTitleImage = [UIImage imageNamed:@"cellTitleView.png"];
    UIImageView *headerView = [[UIImageView alloc] initWithImage:cellTitleImage];
    headerView.frame = CGRectMake(0, 0, cellTitleImage.size.width, cellTitleImage.size.height);
    headerView.backgroundColor = [UIColor clearColor];
    
    UIView *clearView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0)];
    clearView.backgroundColor = [UIColor clearColor];
    
    UIImageView *whiteView = [[UIImageView alloc] initWithFrame:CGRectMake(8, 0, self.view.frame.size.width-16, 27)];
    whiteView.backgroundColor = [UIColor whiteColor];
    
    [clearView addSubview:whiteView];
    [clearView addSubview:headerView];
    [clearView addSubview:titleLabel];
    
    return clearView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
    
    CareDetailView *careDetailView = [[CareDetailView alloc] init];
    careDetailView.indexPath = indexPath;
    [self.navigationController pushViewController:careDetailView animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return tableHeight;
}

@end