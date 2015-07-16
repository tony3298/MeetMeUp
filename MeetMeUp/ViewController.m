//
//  ViewController.m
//  MeetMeUp
//
//  Created by Tony Dakhoul on 5/26/15.
//  Copyright (c) 2015 Tony Dakhoul. All rights reserved.
//

#import "ViewController.h"
#import "MeetupDetailViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

//@property NSArray *meetUps;

@property NSArray *meetUps;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSURL *url = [NSURL URLWithString:@"https://api.meetup.com/2/open_events.json?zip=60604&text=mobile&time=,1w&key=2e57177964277206a2c283c3d1a107f"];

    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {

        NSDictionary *requestedData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&connectionError];

        self.meetUps = [requestedData objectForKey:@"results"];

        [self.tableView reloadData];
    }];



}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.meetUps.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];

    NSDictionary *meetup = [self.meetUps objectAtIndex:indexPath.row];
    NSDictionary *venue = [meetup objectForKey:@"venue"];

    cell.textLabel.text = [meetup objectForKey:@"name"];
    cell.detailTextLabel.text = [venue objectForKey:@"address_1"];

    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    MeetupDetailViewController *meetupDetailVC = segue.destinationViewController;

    UITableViewCell *cell = sender;

    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];

    NSDictionary *meetup = [self.meetUps objectAtIndex:indexPath.row];


    meetupDetailVC.meetup = meetup;
}

@end
