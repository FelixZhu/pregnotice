//
//  motherSettingController.m
//  TouchTest
//
//  Created by Dell on 12-7-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "motherSettingController.h"

@implementation motherSettingController

@synthesize datepicker, textField, dict, segmentedControl, plistURL, dateLabel;

#pragma mark - View lifecycle

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)refreshLabel {
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"YYYY-MM-dd"];
    NSString *string = [format stringFromDate:self.datepicker.date];
    dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, self.view.frame.size.height-50, 240, 30)];
    dateLabel.textAlignment = UITextAlignmentCenter;
//    dateLabel.center = CGPointMake(120, 300);
    dateLabel.text = string;
    dateLabel.font = [UIFont systemFontOfSize:15];
    dateLabel.backgroundColor = [UIColor whiteColor];
    dateLabel.textColor = [UIColor redColor];
    [self.view addSubview:dateLabel];
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *selectDate = datepicker.date;
    NSDate *nowDate = [NSDate date];
    if(segmentedControl.selectedSegmentIndex == 0)
    {
        NSDateComponents *comps = [gregorian components:NSDayCalendarUnit fromDate:nowDate toDate:selectDate options:0];
        int day = [comps day];
        dayCount = [NSNumber numberWithInt:day];
        NSLog(@"the number is %i", day);
    }
    else if(segmentedControl.selectedSegmentIndex == 1)
    {
        NSDate *calcDate = [NSDate dateWithTimeInterval:280*3600*24 sinceDate:selectDate];
        NSDateComponents *comps = [gregorian components:NSDayCalendarUnit fromDate:nowDate toDate:calcDate options:0];
        int day = [comps day];
        dayCount = [NSNumber numberWithInt:day];
        NSLog(@"the number is %i", day);
    }
    
    NSLog(@"the string is:%@",dayCount);
}

- (void)pop
{
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
    self.navigationItem.hidesBackButton = YES;
    
    UIImage *backButtonImage = [UIImage imageNamed:@"backButton.png"];
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, backButtonImage.size.width, backButtonImage.size.height)];
    [backButton addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    backButton.center = CGPointMake(30, 22);
    backButton.backgroundColor = [UIColor clearColor];
    [backButton setImage:backButtonImage forState:UIControlStateNormal];
    [self.navigationController.navigationBar addSubview:backButton];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = YES;
    
    plistURL = [[NSBundle mainBundle] pathForResource:@"Setting-Info" ofType:@"plist"];
    
    datepicker = [[UIDatePicker alloc] init];
    datepicker.datePickerMode = UIDatePickerModeDate;
    [datepicker setFrame:CGRectMake(0, 120, 0, 0)];
    datepicker.minimumDate = [NSDate dateWithTimeIntervalSince1970:3600*24*365*41];
    datepicker.maximumDate = [NSDate dateWithTimeIntervalSinceNow:3600*24*365*2];
    [datepicker addTarget:self action:@selector(refreshLabel) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:datepicker];
    
    UIImageView *backgroudView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"backgroudView.png"]];
    self.tableView.backgroundView = backgroudView;
}

- (void)viewDidAppear:(BOOL)animated {
    
    dict = [[NSMutableDictionary alloc] initWithContentsOfFile:plistURL];
    
    NSNumber *dateType = [dict objectForKey:@"DateType"];
    segmentedControl.selectedSegmentIndex = [dateType intValue];
    
    textField.text = [dict objectForKey:@"MotherName"];
    datepicker.date = [dict objectForKey:@"MotherDate"];
    
    [self refreshLabel];
    [self addTopButton];
}

- (void)viewDidDisappear:(BOOL)animated {
    //save mother's name
    [dict setObject:textField.text forKey:@"MotherName"];
    
    //save the dateType
    NSNumber *dateType;
    dateType = [NSNumber numberWithInt:segmentedControl.selectedSegmentIndex];
    
    [dict setObject:dayCount forKey:@"dayCount"];
    [dict setObject:dateType forKey:@"DateType"];
    [dict setObject:datepicker.date forKey:@"MotherDate"];
    [dict writeToFile:plistURL atomically:YES];
}

#pragma mark -
#pragma mark Table view datesource method
- (void)inputFinished {
    [textField resignFirstResponder];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	static NSString *CellIdentifier = @"CellIdentifier";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
	}
	
	if (0 == indexPath.row)
    {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 30)];
        label.text = @"妈妈姓名:";
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont fontWithName:@"Helvetica" size:15];
        textField = [[UITextField alloc] initWithFrame:CGRectMake(80, 17, 200, 30)];
        textField.placeholder = @"输入姓名";
        textField.backgroundColor = [UIColor clearColor];
        textField.text = [dict objectForKey:@"MotherName"];
        textField.textAlignment =UITextAlignmentLeft;
        textField.font = [UIFont fontWithName:@"Helvetica" size:15];
        textField.keyboardType = UIKeyboardTypeDefault;
        textField.returnKeyType = UIReturnKeyDone;
        [textField addTarget:self action:@selector(inputFinished) 
            forControlEvents:UIControlEventEditingDidEndOnExit];
        
        [cell.contentView addSubview:label];
        [cell.contentView addSubview:textField];
    }
    else
    {
        NSArray *buttonNames = [NSArray arrayWithObjects:@"预产期", @"最后月经", nil];
        segmentedControl = [[UISegmentedControl alloc] initWithItems:buttonNames];
        segmentedControl.frame = CGRectMake(50, 10, 200, 30);
        segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
//        [segmentedControl addTarget:self action:@selector(valueChanged) 
//                           forControlEvents:UIControlEventValueChanged];
//        cell.textLabel.text = [dict objectForKey:@"MotherName"];
//        
        [cell.contentView addSubview:segmentedControl];
//        cell.textLabel.text = [dict objectForKey:@"DateType"];
    }
	
	return cell;
}
    
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self inputFinished];
}

@end
