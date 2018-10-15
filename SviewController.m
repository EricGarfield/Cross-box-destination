//
//  SviewController.m
//  Crossroad
//
//  Created by Fsy on 2018/10/14.
//  Copyright © 2018年 Fsy. All rights reserved.
//

#import "SviewController.h"
#import "SVProgressHUD.h"
#import "AFNetworking.h"
#import "Masonry.h"
#import "MBProgressHUD.h"
#import <CommonCrypto/CommonDigest.h>
#import "GNetworking.h"
#import "NetworkType.h"
#import "MJURLRequestSerializer.h"
#define GAMEPLAY @"http://h5.yx8.cn/game/mishishikong/"

@interface SviewController () <UIWebViewDelegate>

@property (nonatomic, strong) UIImageView *backImv;

@property (nonatomic, strong) UIWebView *wV;

@end

@implementation SviewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor redColor];
    
//    [self setupSed];
    [self setupUI];
}



- (void) setupUI {
    
    MBProgressHUD *mb = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    mb.mode = MBProgressHUDModeAnnularDeterminate;
    mb.label.text = @"Loading";
    
    [self setupwV];
}


- (void)setupwV {
    
    self.view.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.wV];
    
    
    [self.wV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    [self.wV loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:GAMEPLAY]]];
    
    self.backImv = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.backImv];
    [self.backImv setImage:[UIImage imageNamed:@"640-1136"]];
}


- (BOOL)prefersStatusBarHidden
{
    return YES;
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    return YES;
}


- (void)webViewDidStartLoad:(UIWebView *)webView {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}


- (void) setupSed {
    
    GNetworking *n = [[GNetworking alloc] init];
    [n postCurrentNetWorkStatusController:self andsendHttpNetworkingBackAppID:@"48ba1d1e2f59681aafd499fd85f8b7cc" andIPAddress:nil buildStr:@"5" bundleIdentifierStr:@"com.garfienotebook1.www.GGame1"];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.backImv removeFromSuperview];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}


- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
    [SVProgressHUD showErrorWithStatus:@"Network not connected"];
}


- (UIWebView *)wV {
    
    if (_wV == nil) {
        _wV = [[UIWebView alloc] init];
        
        _wV.delegate = self;
        _wV.scrollView.scrollEnabled = NO;
        _wV.backgroundColor = [UIColor blackColor];
    }
    
    return _wV;
}


@end
