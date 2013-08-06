//
//  IndexButton.h
//  TouchTest
//
//  Created by Dell on 12-8-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface IndexButton : UIButton
@property (nonatomic, retain) NSIndexPath *indexPath;
@end

@implementation IndexButton
@synthesize indexPath;
@end
