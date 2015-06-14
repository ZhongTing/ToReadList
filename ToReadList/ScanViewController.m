//
//  SecondViewController.m
//  ToReadList
//
//  Created by ZhongTing on 2015/6/14.
//  Copyright (c) 2015年 ZhongTing. All rights reserved.
//

#import "ScanViewController.h"
#import <MTBBarcodeScanner.h>

@interface ScanViewController ()
@property (weak, nonatomic) IBOutlet UIImageView* imageView;
@property (weak, nonatomic) IBOutlet UITextView* textView;
@property (strong, nonatomic) MTBBarcodeScanner* scanner;
@end

@implementation ScanViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.scanner = [[MTBBarcodeScanner alloc] initWithPreviewView:self.imageView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)scan:(id)sender
{
    [MTBBarcodeScanner requestCameraPermissionWithSuccess:^(BOOL success) {
        if (success) {
            [self.scanner startScanningWithResultBlock:^(NSArray* codes) {
                AVMetadataMachineReadableCodeObject* code = [codes firstObject];
                self.textView.text = code.stringValue;
                [self.scanner stopScanning];
            }];
        }
        else {
            // The user denied access to the camera
        }
    }];
}
@end
