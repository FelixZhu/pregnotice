//
//  motherSettingController.h
//  TouchTest
//
//  Created by Dell on 12-7-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface motherSettingController : UITableViewController 
<UIPickerViewDelegate, UIPickerViewDataSource> {
    NSNumber *dayCount;
    UIDatePicker *datepicker;
    UITextField *textField;
    UISegmentedControl *segmentedControl;
    NSString *plistURL;
    UILabel *dateLabel;
}


@property (nonatomic, retain) UIDatePicker *datepicker;
@property (nonatomic, retain) UITextField *textField;
@property (nonatomic, retain) NSMutableDictionary *dict;
@property (nonatomic, retain) UISegmentedControl *segmentedControl;
@property (nonatomic, retain) NSString *plistURL;
@property (nonatomic, retain) UILabel *dateLabel;

@end
