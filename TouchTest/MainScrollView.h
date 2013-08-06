//
//  MainScrollView.h
//  TouchTest
//
//  Created by Lion User on 02/06/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserViewController.h"
#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "BBCyclingLabel.h"

@interface MainScrollView : UIViewController <UIScrollViewDelegate>{    
    UIScrollView *mainScrollView;
    UIScrollView *topScrollView;
    UIScrollView *MenuScrollView1;
    UIScrollView *MenuScrollView2;
    UIPageControl *pageControl;
    BBCyclingLabel *cyclingLabel;
}

@property (nonatomic, retain) UIScrollView *mainScrollView;
@property (nonatomic, retain) UIScrollView *topScrollView;
@property (nonatomic, retain) UIScrollView *MenuScrollView1;
@property (nonatomic, retain) UIScrollView *MenuScrollView2;
@property (nonatomic, retain) UIPageControl *pageControl;

@end
