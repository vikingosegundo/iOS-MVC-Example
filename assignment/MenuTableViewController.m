//
//  MenuTableViewController.m
//  assignment
//
//  Created by Manuel Meyer on 10.01.14.
//  Copyright (c) 2014 MatVre. All rights reserved.
//

#import "MenuTableViewController.h"
#import "DataSource.h"

@interface MenuTableViewController ()
@property (nonatomic, strong) NSArray *destinations;
@end

@implementation MenuTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.destinations = @[
                          @{@"address":@"http://google.com" , @"name":@"google"},
                          @{@"address":@"http://tagesschau.de", @"name":@"tagesschau"},
                          @{@"address":@"http://taz.de", @"name":@"taz"}
                        ];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return [self.destinations count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = self.destinations[indexPath.row][@"name"];
    
    return cell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue
                 sender:(id)sender
{
    [segue.destinationViewController setValue:(
                                               {
                                                   DataSource *dataSource = [DataSource new];
                                                   NSInteger idx = [[self.tableView indexPathForSelectedRow] row];
                                                   dataSource.address = self.destinations[idx][@"address"];
                                                   dataSource.name    = self.destinations[idx][@"name"];
                                                   dataSource;
                                               })
                                       forKey:@"dataSource"];
    
    [segue.destinationViewController setValue:@[ @"tenthLetter", @"everyTenthLetter", @"occurrence"]
                                       forKey:@"blockIdentifier"];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"websiteStatsSegue" sender:nil];
}

@end
