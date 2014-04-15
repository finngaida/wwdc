//
//  FGSideViewController.m
//  iAm Finn
//
//  Created by Finn Gaida on 01.05.13.
//  Copyright (c) 2013 Finn Gaida. All rights reserved.
//

#import "FGSideViewController.h"

@implementation FGSideViewController
@synthesize tableView, navBar;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    
    indicator = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 3, 44)];
    indicator.backgroundColor = [UIColor colorWithRed:(10.0/255.0) green:(154.0/255.0) blue:(191.0/255.0) alpha:1.0];
    [self.tableView addSubview:indicator];
    
    self.view.backgroundColor = [UIColor blackColor];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {return 3;}
    else if (section == 1) {return 1;}
    else {return 3;}
}

- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tv dequeueReusableCellWithIdentifier:@"Cell"];
    
    
    if (indexPath.row == currentPage) {
        cell.contentView.backgroundColor = [UIColor colorWithRed:(25.0/255.0) green:(26.0/255.0) blue:(28.0/255.0) alpha:1.0];
    } else {
        cell.contentView.backgroundColor = [UIColor colorWithRed:(43.0/255.0) green:(47.0/255.0) blue:(48.0/255.0) alpha:1.0];
    }
    
    // setup...
    UILabel *text = [[UILabel alloc] initWithFrame:CGRectMake(52, 10, 200, 18)];
    text.backgroundColor = [UIColor clearColor];
    text.textColor = [UIColor whiteColor];
    text.font = [UIFont fontWithName:@"Open Sans" size:16];
    text.layer.shadowColor = [UIColor blackColor].CGColor;
    text.layer.shadowOpacity = 1;
    text.layer.shadowOffset = CGSizeMake(0, 1);
    text.layer.shadowRadius = 1;
    
    if (indexPath.row == 0) {text.text = @"About";}
    if (indexPath.row == 1) {text.text = @"Projects";}
    if (indexPath.row == 2) {text.text = @"Contact";}
    
    [cell.contentView addSubview:text];
    
    UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(12, 10, 20, 20)];
    
    if (indexPath.row == 0) {icon.image = [UIImage imageNamed:@"user-white"];}
    if (indexPath.row == 1) {icon.image = [UIImage imageNamed:@"floppy"];}
    if (indexPath.row == 2) {icon.image = [UIImage imageNamed:@"letter"];}
    
    [cell.contentView addSubview:icon];
    
    UIButton *action = [[UIButton alloc] initWithFrame:cell.contentView.frame];
    action.tag = indexPath.row;
    [action addTarget:self action:@selector(setPage:) forControlEvents:UIControlEventTouchUpInside];
    [cell.contentView addSubview:action];
    
    UIView *seperator = [[UIView alloc] initWithFrame:CGRectMake(0, cell.frame.size.height-2, 260, 2)];
    seperator.backgroundColor = [UIColor blackColor];
    [cell.contentView addSubview:seperator];
    
    return cell;
}

- (IBAction)setPage:(id)sender {
    UIButton *b = (UIButton *)sender;
    currentPage = b.tag;
    [self.tableView reloadData];
    
    [UIView animateWithDuration:.5 animations:^{
        indicator.center = CGPointMake(indicator.center.x, 44*(b.tag+1)-22);
    } completion:^(BOOL finished) {
        switch (b.tag) {
            case 0: {
                [self performSegueWithIdentifier:@"showPersonal" sender:self];
            } break;
            case 1: {
                [self performSegueWithIdentifier:@"showProjects" sender:self];
            } break;
            case 2: {
                [self performSegueWithIdentifier:@"showContact" sender:self];
            } break;
                
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
