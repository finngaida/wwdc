//
//  FGSideViewController.h
//  iAm Finn
//
//  Created by Finn Gaida on 01.05.13.
//  Copyright (c) 2013 Finn Gaida. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "UIImageView+LBBlurredImage.h"

@interface FGSideViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    UIImageView *bg;
    UIView *indicator;
    int currentPage;
}

@property (weak, nonatomic) IBOutlet UINavigationBar *navBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)setPage:(id)sender;

@end
