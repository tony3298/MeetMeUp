//
//  MeetupDetailViewController.m
//  MeetMeUp
//
//  Created by Tony Dakhoul on 5/26/15.
//  Copyright (c) 2015 Tony Dakhoul. All rights reserved.
//

#import "MeetupDetailViewController.h"
#import "WebViewController.h"

@interface MeetupDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *goingTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *maybeTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *groupTextLabel;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIWebView *descriptionWebView;
@property (weak, nonatomic) IBOutlet UILabel *linkTextLabel;

@end

@implementation MeetupDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSDictionary *group = [self.meetup objectForKey:@"group"];

    self.titleLabel.text = [self.meetup objectForKey:@"name"];

    NSLog(@"%@", [self.meetup objectForKey:@"yes_rsvp_count"]);

    self.groupTextLabel.text = [group objectForKey:@"name"];

    self.goingTextLabel.text = [NSString stringWithFormat:@"%@", [self.meetup objectForKey:@"yes_rsvp_count"]];

    self.maybeTextLabel.text = [NSString stringWithFormat:@"%@", [self.meetup objectForKey:@"maybe_rsvp_count"]];

    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onLinkTextLabelTapped)];

    [self.linkTextLabel addGestureRecognizer:gestureRecognizer];
    self.linkTextLabel.userInteractionEnabled = YES;

//    self.descriptionWebView

    [self createWebViewWithHTML];

//    self.goingTextLabel.text = [self.goingTextLabel.text stringByAppendingString:(NSString *)[self.meetup objectForKey:@"yes_rsvp_count"]];
//
//    self.maybeTextLabel.text = [self.maybeTextLabel.text stringByAppendingString:[self.meetup objectForKey:@"maybe_rsvp_count"]];
}

- (void) createWebViewWithHTML{
    //create the string
    NSMutableString *html = [NSMutableString stringWithString: @"<html><head><title></title></head><body style=\"background:transparent;\">"];

    //continue building the string
    [html appendString:[self.meetup objectForKey:@"description"]];
    [html appendString:@"</body></html>"];

    //instantiate the web view
//    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.frame];

    //make the background transparent
    [self.descriptionWebView setBackgroundColor:[UIColor clearColor]];

    //pass the string to the webview
    [self.descriptionWebView loadHTMLString:[html description] baseURL:nil];

    //add it to the subview
//    [self.view addSubview:webView];

}

-(void)onLinkTextLabelTapped {

    [self performSegueWithIdentifier:@"EventWebPage" sender:self];

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    WebViewController *webVC = segue.destinationViewController;

    webVC.urlString = [self.meetup objectForKey:@"event_url"];
}

@end
