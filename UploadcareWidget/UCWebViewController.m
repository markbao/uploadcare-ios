//
//  UCWebViewController.m
//  ExampleProject
//
//  Created by Yury Nechaev on 06.04.16.
//  Copyright © 2016 Uploadcare. All rights reserved.
//

#import "UCWebViewController.h"

@interface UCWebViewController () <UIWebViewDelegate>
@property (nonatomic, copy) void (^loadingBlock)(NSURL *url);
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) NSURL *url;
@end

@implementation UCWebViewController

- (id)initWithURL:(NSURL *)url loadingBlock:(void(^)(NSURL *url))loadingBlock {
    self = [super init];
    if (self) {
        _url = url;
        _loadingBlock = loadingBlock;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView = [[UIWebView alloc] init];
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
    
    NSDictionary *views = @{@"webView":self.webView};
    
    [self.webView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    NSArray *horizontal = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[webView]|" options:0 metrics:nil views:views];
    NSArray *vertical = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[webView]|" options:0 metrics:nil views:views];
    
    [self.view addConstraints:horizontal];
    [self.view addConstraints:vertical];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:self.url]];
}

#pragma mark - <UIWebViewDelegate>

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    if (self.loadingBlock) self.loadingBlock(webView.request.URL);
}

@end