//
//  MainScrollView.m
//  TouchTest
//
//  Created by Lion User on 02/06/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MainScrollView.h"
#import "InsertViewController.h"
#import "SettingViewController.h"
#import "DDProgressView.h"
#import "CareNotificationView.h"
#import "DetailTextView.h"

@implementation MainScrollView

@synthesize pageControl, mainScrollView, topScrollView, MenuScrollView1, MenuScrollView2;

#pragma mark - View lifecycle

- (void)addTopButton {
    
    UIImage *titleImage = [UIImage imageNamed:@"titleButton.png"];
    UIImageView *titleView = [[UIImageView alloc] initWithFrame:CGRectMake(127.5f, 12, titleImage.size.width, titleImage.size.height)];
    titleView.image = titleImage;
    titleView.center = CGPointMake(160, 22);
    titleView.backgroundColor = [UIColor clearColor];
    UIImage *navImage = [UIImage imageNamed:@"navBar.png"];
    UIImageView *navBarView = [[UIImageView alloc] initWithImage:navImage];
    [self.navigationController.navigationBar addSubview:navBarView];
    [self.navigationController.navigationBar addSubview:titleView];
    [self.navigationController.navigationBar setBackgroundColor:[UIColor clearColor]];
    
    UIImage *barButtonup = [UIImage imageNamed:@"setBarback-up.png"];
    UIImage *barButtondown = [UIImage imageNamed:@"setBarback-down.png"];
    UIImage *setBarbutton = [UIImage imageNamed:@"setBarbutton.png"];
    UIImage *profileBarbutton = [UIImage imageNamed:@"profileBarbutton.png"];
    
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, barButtonup.size.width, barButtonup.size.height)];
    [leftButton setImage:setBarbutton forState:UIControlStateNormal];
    [leftButton setBackgroundImage:barButtonup forState:UIControlStateNormal];
    [leftButton setBackgroundImage:barButtondown forState:UIControlStateHighlighted];
    [leftButton addTarget:self action:@selector(leftButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, barButtonup.size.width, barButtonup.size.height)];
    [rightButton setImage:profileBarbutton forState:UIControlStateNormal];
    [rightButton setBackgroundImage:barButtonup forState:UIControlStateNormal];
    [rightButton setBackgroundImage:barButtondown forState:UIControlStateHighlighted];
    [rightButton addTarget:self action:@selector(rightButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
}

- (void)addProcessBar {
    
    NSString *plistURL = [[NSBundle mainBundle] pathForResource:@"Setting-Info" ofType:@"plist"];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithContentsOfFile:plistURL];
    NSNumber *dateCount = [dict objectForKey:@"dayCount"];
    NSString *labelText;
    if([dateCount intValue] <= 0)
    {
        labelText = [[NSString alloc] initWithFormat:@"      恭喜您已经和宝宝见面了"];
    }
    else
    {
        labelText = [[NSString alloc] initWithFormat:@"您还有%@天就可以和宝宝见面了", dateCount];
    }
    DetailTextView *progressLabel = [[DetailTextView alloc] initWithFrame:CGRectMake(65, 214, 200, 20)];
    [progressLabel setText:labelText WithFont:[UIFont systemFontOfSize:13] AndColor:[UIColor blackColor]];
    [progressLabel setKeyWordTextArray:[NSArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",nil] WithFont:[UIFont systemFontOfSize:17] AndColor:[UIColor redColor]];
    progressLabel.backgroundColor = [UIColor whiteColor];
    
    UIImage *twoLabel = [UIImage imageNamed:@"twoLabel.png"];
    UIImageView *progressItem = [[UIImageView alloc] initWithImage:twoLabel];
    progressItem.frame = CGRectMake(10, 220, twoLabel.size.width, twoLabel.size.height);
    DDProgressView *progressView = [[DDProgressView alloc] initWithFrame: CGRectMake(38, 235, self.view.bounds.size.width-79, 0)] ;//45
    [progressView setOuterColor: [UIColor colorWithRed:138.0/255.0 green:214.0/255.0 blue:157.0/255.0 alpha:1]];
    [progressView setInnerColor: [UIColor colorWithRed:138.0/255.0 green:214.0/255.0 blue:157.0/255.0 alpha:1]];
    [progressView setEmptyColor: [UIColor whiteColor]] ;
    [progressView setProgress:1-[dateCount intValue]/280.0f];
    
    [mainScrollView addSubview:progressView];
    [mainScrollView addSubview:progressItem];
    [mainScrollView addSubview:progressLabel];
    
    NSNumber *weekCount = [NSNumber numberWithInt:(287 - [dateCount intValue])/7];
    NSString *weekString1 = [NSString stringWithFormat:@"宝宝"];
    NSString *weekString2;
    if([weekCount intValue] > 40)
    {
        weekString2 = [NSString stringWithFormat:@"出生啦"];
    }
    else
    {
        weekString2 = [NSString stringWithFormat:@"第%@周", weekCount];
    }
    UILabel *weekLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(23, 123, 200, 30)];
    UILabel *weekLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(73, 106, 200, 50)];
    weekLabel1.font = [UIFont systemFontOfSize:25];
    weekLabel2.font = [UIFont systemFontOfSize:40];
    weekLabel1.text = weekString1;
    weekLabel2.text = weekString2;
    weekLabel1.textColor = [UIColor whiteColor];
    weekLabel2.textColor = [UIColor whiteColor];
    weekLabel1.backgroundColor = [UIColor clearColor];
    weekLabel2.backgroundColor = [UIColor clearColor];
    weekLabel2.tag = 101;
    [topScrollView addSubview:weekLabel1];
    [topScrollView addSubview:weekLabel2];
    
//    DetailTextView *weekLabel = [[DetailTextView alloc] initWithFrame:CGRectMake(20, 105, 200, 50)];
//    weekLabel.backgroundColor = [UIColor clearColor];
//    [weekLabel setText:weekString WithFont:[UIFont systemFontOfSize:25] AndColor:[UIColor blackColor]];
//    [weekLabel setKeyWordTextArray:[NSArray arrayWithObjects:@"第",@"周",@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",nil] WithFont:[UIFont systemFontOfSize:40] AndColor:[UIColor blackColor]];
//    [topScrollView addSubview:weekLabel];
    
    cyclingLabel = [[BBCyclingLabel alloc] initWithFrame:CGRectMake(23, 153, 200, 30) andTransitionType:BBCyclingLabelTransitionEffectScrollUp];
    cyclingLabel.backgroundColor = [UIColor clearColor];
    cyclingLabel.textColor = [UIColor blackColor];
    cyclingLabel.font = [UIFont systemFontOfSize:15];
//    cyclingLabel.shadowColor = [UIColor whiteColor];
//    cyclingLabel.shadowOffset = CGSizeMake(0, 1);
    cyclingLabel.numberOfLines = 1;
    cyclingLabel.textAlignment = UITextAlignmentLeft;
    cyclingLabel.transitionDuration = 0.75;
    [cyclingLabel setText:@"爸爸该做些什么呢?"];
    [topScrollView addSubview:cyclingLabel];
    [cyclingLabel setTextColor:[UIColor blackColor]];
    [topScrollView addSubview:cyclingLabel];
}

- (void)addMainView {
    mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0, 0.0,self.view.frame.size.width, self.view.frame.size.height)];
    mainScrollView.directionalLockEnabled = YES;
    mainScrollView.pagingEnabled = NO;
    mainScrollView.backgroundColor = [UIColor whiteColor];
    mainScrollView.showsVerticalScrollIndicator = NO;
    mainScrollView.showsHorizontalScrollIndicator = YES;
    mainScrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height+1);
    [self.view addSubview:mainScrollView];
    
    UIImage *mainpic0 = [UIImage imageNamed:@"mainpic0.png"];
    topScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, 208)];
    topScrollView.directionalLockEnabled = YES;  
    topScrollView.pagingEnabled = YES;
    topScrollView.backgroundColor = [UIColor clearColor];
    topScrollView.showsVerticalScrollIndicator = NO;  
    topScrollView.showsHorizontalScrollIndicator = NO;  
    [topScrollView setContentSize:CGSizeMake(self.view.frame.size.width * 3, mainpic0.size.height)];
    [topScrollView setDelegate:self];

    [mainScrollView addSubview:topScrollView];
    
    //add three pictures to topscrollview
    UIButton *mainButton0 = [[UIButton alloc] 
                             initWithFrame:CGRectMake(0, 0, mainpic0.size.width, mainpic0.size.height)];
    [mainButton0 addTarget:self 
                    action:@selector(mainButton0Pressed)
          forControlEvents:UIControlEventTouchUpInside];
    [mainButton0 setBackgroundImage:mainpic0 forState:UIControlStateNormal];
    [mainButton0 setBackgroundImage:mainpic0 forState:UIControlStateHighlighted];
    UIImage *mainpic1 = [UIImage imageNamed:@"mainpic1.png"];
    UIButton *mainButton1 = [[UIButton alloc] initWithFrame:CGRectMake(mainpic0.size.width, 0, mainpic1.size.width, mainpic1.size.height)];
    [mainButton1 addTarget:self 
                    action:@selector(mainButton1Pressed)
          forControlEvents:UIControlEventTouchUpInside];
    [mainButton1 setBackgroundImage:mainpic1 forState:UIControlStateNormal];
    [mainButton1 setBackgroundImage:mainpic1 forState:UIControlStateHighlighted];
    UIImage *mainpic2 = [UIImage imageNamed:@"mainpic2.png"];
    UIButton *mainButton2 = [[UIButton alloc] initWithFrame:CGRectMake(mainpic0.size.width + mainpic1.size.width, 0, mainpic2.size.width, mainpic2.size.height)];
    [mainButton2 addTarget:self 
                    action:@selector(mainButton2Pressed)
          forControlEvents:UIControlEventTouchUpInside];
    [mainButton2 setBackgroundImage:mainpic2 forState:UIControlStateNormal];
    [mainButton2 setBackgroundImage:mainpic2 forState:UIControlStateHighlighted];
    [topScrollView addSubview:mainButton0];
    [topScrollView addSubview:mainButton1];
    [topScrollView addSubview:mainButton2];
        
    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(160.0, 200, 0, 0)];
    pageControl.numberOfPages = 3;
    pageControl.currentPage = 0;
    [mainScrollView addSubview:pageControl];  
    
    UIImage *notiRect = [UIImage imageNamed:@"notiRect.png"];
    UIImageView *notiRectView = [[UIImageView alloc] initWithImage:notiRect];
    notiRectView.frame = CGRectMake(0, 272, notiRect.size.width, notiRect.size.height);
    [mainScrollView addSubview:notiRectView];
    
    UIImage *notiuppic = [UIImage imageNamed:@"noti-up.png"];
    UIImage *notidownpic = [UIImage imageNamed:@"noti-down.png"];
    MenuScrollView1 = [[UIScrollView alloc] 
                       initWithFrame:CGRectMake(0, 285, self.view.frame.size.width, notiuppic.size.height)];
    MenuScrollView1.directionalLockEnabled = YES;  
    MenuScrollView1.pagingEnabled = NO;  
    MenuScrollView1.backgroundColor = [UIColor clearColor];  
    MenuScrollView1.showsVerticalScrollIndicator = NO;  
    MenuScrollView1.showsHorizontalScrollIndicator = NO;  
    [MenuScrollView1 setContentSize:CGSizeMake(self.view.frame.size.width + 1, notiuppic.size.height)];  
    [mainScrollView addSubview:MenuScrollView1];
    //40
    UIButton *notiButton = [[UIButton alloc] initWithFrame:CGRectMake(40, 0, notiuppic.size.width, notiuppic.size.height)];
    [notiButton setBackgroundImage:notiuppic forState:UIControlStateNormal];
    [notiButton setBackgroundImage:notidownpic forState:UIControlStateHighlighted];
    [notiButton addTarget:self action:@selector(careButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    notiButton.backgroundColor = [UIColor clearColor];
    [MenuScrollView1 addSubview:notiButton];
    
    UIButton *otherNotiButton = [[UIButton alloc] initWithFrame:CGRectMake(190, 0, notiuppic.size.width, notiuppic.size.height)];
    [otherNotiButton setBackgroundImage:[UIImage imageNamed:@"otherNoti-up.png"] forState:UIControlStateNormal];
    [otherNotiButton setBackgroundImage:[UIImage imageNamed:@"otherNoti-down.png"] forState:UIControlStateHighlighted];
    [otherNotiButton addTarget:self action:@selector(careButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    otherNotiButton.backgroundColor = [UIColor clearColor];
    [MenuScrollView1 addSubview:otherNotiButton];
    
    UIImage *notiLabel = [UIImage imageNamed:@"notiLabel.png"];
    UIImageView *notiLabelView = [[UIImageView alloc] initWithImage:notiLabel];
    notiLabelView.frame = CGRectMake(0, 265, notiLabel.size.width, notiLabel.size.height);
    [mainScrollView addSubview:notiLabelView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self addMainView];
    NSLog(@"main scroll view did load");
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:NO];
    
    [self addTopButton];
    [self addProcessBar];
    NSLog(@"main scroll view did appear");
}

- (void)viewDidDisappear:(BOOL)animated {
    UILabel *weekLabel = (UILabel *)[self.view viewWithTag:101];
    [weekLabel removeFromSuperview];
}

- (void)leftButtonPressed {
    NSLog(@"left Button pressed");
    
//    CATransition *animation = [CATransition animation];
//    [animation setDuration:0.5];
//    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
//    [animation setType:kCATransitionMoveIn];
//    [animation setSubtype:kCATransitionFromTop];
//    animation.delegate = self;
//    [self.navigationController.view.layer addAnimation:animation forKey:nil];
//    
//    InsertViewController *insertViewController = [[InsertViewController alloc] init];
//    [self.navigationController pushViewController:insertViewController animated:NO];
}

- (void)rightButtonPressed {
    NSLog(@"right Button pressed");
    
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.5];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    [animation setType:kCATransitionMoveIn];
    [animation setSubtype:kCATransitionFromRight];
    animation.delegate = self;
    [self.navigationController.view.layer addAnimation:animation forKey:nil];
    
    SettingViewController *settingViewController = [[SettingViewController alloc] init];
    [self.navigationController pushViewController:settingViewController animated:NO];
}

- (void)mainButton0Pressed {
    NSLog(@"button Pressed");
}

- (void)mainButton1Pressed {
    NSLog(@"button Pressed");
}

- (void)mainButton2Pressed {
    NSLog(@"button Pressed");
}

- (void)careButtonPressed {
    NSLog(@"care button pressed!!!");
    
    CareNotificationView *careNotificationView = [[CareNotificationView alloc] 
                                                  initWithStyle:UITableViewStylePlain];
    [self.navigationController pushViewController:careNotificationView animated:YES];
}

#pragma mark - 
#pragma scroll view delegate method

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{  
    int index = fabs(scrollView.contentOffset.x) / scrollView.frame.size.width;  
    [pageControl setCurrentPage:index];  
} 

@end
