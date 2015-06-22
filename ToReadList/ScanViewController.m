//
//  SecondViewController.m
//  ToReadList
//
//  Created by ZhongTing on 2015/6/14.
//  Copyright (c) 2015年 ZhongTing. All rights reserved.
//

#import "ScanViewController.h"
#import <MagicalRecord/MagicalRecord.h>
#import <MTBBarcodeScanner.h>
#import "BookParser.h"
#import "BookViewController.h"
#import <MRProgress.h>

@interface ScanViewController ()
@property (weak, nonatomic) IBOutlet UIImageView* imageView;
@property (strong, nonatomic) MTBBarcodeScanner* scanner;
@end

@implementation ScanViewController {
    BookParser* parser;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.scanner = [[MTBBarcodeScanner alloc] initWithPreviewView:self.imageView];
    parser = [[BookParser alloc] init];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self startScan];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [self.scanner stopScanning];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - scan
- (void)startScan
{
    [MTBBarcodeScanner requestCameraPermissionWithSuccess:^(BOOL success) {
        if (success) {
            [self.scanner startScanningWithResultBlock:^(NSArray* codes) {
                AVMetadataMachineReadableCodeObject* code = [codes firstObject];
                [self.scanner stopScanning];
                if (![parser validateISBN:code.stringValue]) {
                    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Hint" message:@"條碼不是ISBN格式" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alert show];
                }
                else {
                    [MRProgressOverlayView showOverlayAddedTo:self.navigationController.view animated:YES];
                    [parser requestBookInfoWithISBN:code.stringValue
                                            success:^(Book* book) {
                                                [self onRequestBookSucess:book];
                                                [MRProgressOverlayView dismissOverlayForView:self.navigationController.view animated:YES];
                                            }];
                }
            }];
        }
        else {
            // The user denied access to the camera
        }
    }];
}

- (void)onRequestBookSucess:(Book*)book
{
    NSLog(@"request book success");
    if (book == nil) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"資料讀取有誤" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else {
        BookViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"BookViewController"];
        [vc setBook:book];
        [self.navigationController pushViewController:vc animated:true];
    }
}

#pragma mark - alertview delegate
- (void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self startScan];
}

@end
