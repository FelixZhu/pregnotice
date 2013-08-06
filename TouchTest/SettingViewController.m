//
//  SettingViewController.m
//  TouchTest
//
//  Created by Dell on 12-7-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SettingViewController.h"
#import "motherSettingController.h"

@implementation SettingViewController

@synthesize settingList, settingSection;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - View lifecycle

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

    //Menu
    NSArray *keys = [NSArray arrayWithObjects:@"妈妈档案", @"宝宝档案", @"每周提醒", @"关于我们", nil];
    
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    NSArray *menuArray1 = [[NSArray alloc] initWithObjects:@"姓名与预产期",@"妈妈头像设置",@"怀孕初始设置",nil];
    NSArray *menuArray2 = [[NSArray alloc] initWithObjects:@"姓名与性别",nil];
    NSArray *menuArray3 = [[NSArray alloc] initWithObjects:@"通知", @"设置时间", nil];
    NSArray *menuArray4 = [[NSArray alloc] initWithObjects:@"关于本软件", nil];
    [dictionary setObject:menuArray1 forKey:@"妈妈档案"];
    [dictionary setObject:menuArray2 forKey:@"宝宝档案"];
    [dictionary setObject:menuArray3 forKey:@"每周提醒"];
    [dictionary setObject:menuArray4 forKey:@"关于我们"];
    self.settingList = dictionary;
    self.settingSection = keys;
    
    UIImageView *backgroudView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"backgroudView.png"]];
    self.tableView.backgroundView = backgroudView;
}

- (void)viewWillAppear:(BOOL)animated {
    [self addTopButton];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [settingSection count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *key = [settingSection objectAtIndex:section];
    NSArray *list = [settingList objectForKey:key];
    return [list count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger section = [indexPath section];
    NSUInteger row = [indexPath row];
    NSString *key = [settingSection objectAtIndex:section];
    NSArray *list = [settingList objectForKey:key];
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSString *listObj = [list objectAtIndex:row];
    if (key == @"妈妈档案" || key == @"宝宝档案" || listObj == @"设置时间")
    {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.editingAccessoryType = UITableViewCellAccessoryNone;
    }
    if (listObj == @"通知")
    {
        UISwitch *switchView = [[UISwitch alloc] initWithFrame:CGRectZero];
        switchView.backgroundColor = [UIColor clearColor];
        cell.accessoryView = switchView;
    }
    
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:15];
    cell.textLabel.text = [list objectAtIndex:row];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *key = [settingSection objectAtIndex:section];
    return key;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *key = [settingSection objectAtIndex:[indexPath section]];
    NSArray *list = [settingList objectForKey:key];
    NSString *listObj = [list objectAtIndex:[indexPath row]];
    
    if (listObj == @"姓名与预产期")
    {
        motherSettingController *motherSetting = [[motherSettingController alloc] init];
        [self.navigationController pushViewController:motherSetting animated:YES];
    }
    else if (listObj == @"姓名与性别")
    {
//        BabySettingController *babySetting = [[BabySettingController alloc] init];
//        [self.navigationController pushViewController:babySetting animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 30;
}

@end
