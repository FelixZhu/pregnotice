//
//  CareDetailView.m
//  TouchTest
//
//  Created by Dell on 12-7-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CareDetailView.h"

@implementation CareDetailView

@synthesize indexPath;

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
    
    UIImage *titleImage = [UIImage imageNamed:@"detailTitle.png"];
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
    UIImageView *backButtonView = [[UIImageView alloc] initWithImage:backButtonImage];
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, backButtonImage.size.width, backButtonImage.size.height)];
    [backButton addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    backButton.center = CGPointMake(30, 22);
    backButton.backgroundColor = [UIColor clearColor];
    [backButton setImage:backButtonImage forState:UIControlStateNormal];
    [self.navigationController.navigationBar addSubview:backButton];
}

- (NSString *)getDetail {
    
	if (sqlite3_open([[self databasePath] UTF8String],&database) != SQLITE_OK) {
		sqlite3_close(database);
        NSLog(@"open databse error");
	}
	NSString *getDetailSQL = [NSString stringWithFormat:@"SELECT item%i_content FROM care_reminder_content WHERE _id = %i", [indexPath row]+1, [indexPath section]+1];
    NSString *title;
	sqlite3_stmt *statement;
	if (sqlite3_prepare_v2(database, [getDetailSQL UTF8String], -1, &statement, nil) == SQLITE_OK) {
		if (sqlite3_step(statement)==SQLITE_ROW) {
            title = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement,0)];
		}
		sqlite3_finalize(statement);
		return title;
	}
	return nil;
}

#pragma mark - View lifecycle

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    textView.text = [self getDetail];
    textView.textColor = [UIColor blackColor];
    textView.font = [UIFont systemFontOfSize:18];
    textView.editable = NO;
    textView.scrollEnabled = YES;
    textView.backgroundColor = [UIColor colorWithRed:219.0f/255.0f green:247.0f/255.0f blue:225.0f/255.0f alpha:1.0f];
    
    [self.view addSubview:textView];
    
    NSLog(@"here is care detail view");
}

- (void)viewWillAppear:(BOOL)animated {
    
    [self addTopButton];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    sqlite3_close(database);
}

@end
