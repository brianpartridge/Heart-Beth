//
//  ViewController.m
//  ♥ Beth
//
//  Created by Brian Partridge on 2/14/12.
//  Copyright (c) 2012 VMware, Inc. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController ()

@end

@implementation ViewController

@synthesize scrollview;
@synthesize page1, page2, page3, page4, page5;
@synthesize goofy, sleepy, explode, smile;
@synthesize webview;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
   
   NSString *path = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
   NSURL *fileURL = [[NSURL alloc] initFileURLWithPath:path];
   NSURLRequest *req = [NSURLRequest requestWithURL:fileURL];
   [self.webview setScalesPageToFit:YES];
   [self.webview loadRequest:req];
   
   NSArray *images = [NSArray arrayWithObjects:goofy, sleepy, explode, smile, nil];
   for (UIImageView *image in images) {
      image.layer.borderColor = self.view.backgroundColor.CGColor;
      image.layer.borderWidth = 4;
      image.layer.cornerRadius = 4;
      image.clipsToBounds = YES;   
   }
   
   NSArray *pages = [NSArray arrayWithObjects:page1, page2, page3, page4, page5, nil];
   [self.scrollview setContentSize:CGSizeMake(pages.count * self.view.frame.size.width, self.view.frame.size.height)];
   CGFloat x = 0;
   for (UIView *page in pages) {
      UIView *innerPage = [[page subviews] lastObject];
      innerPage.layer.cornerRadius = 4;
      innerPage.clipsToBounds = YES;  
      
      CGRect frame = page.frame;
      frame.origin.x = x;
      page.frame = frame;
      
      x += self.view.frame.size.width;
   }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)viewDidAppear:(BOOL)animated {
   [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionAutoreverse | UIViewAnimationOptionRepeat animations:^{
      [self.webview setTransform:CGAffineTransformMakeScale(0.9, 0.9)];
   } completion:^(BOOL finished) {
      NSLog(@"done");
   }];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
   return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
