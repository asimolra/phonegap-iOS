//
//  CDVScanpay.h
//
//  Created by Scanpay on 25/04/13.
//
//

#import <Foundation/Foundation.h>
#import <Cordova/CDV.h>
#import "ScanPayDelegate.h"
#import "ScanPayViewController.h"

@interface CDVScanpay : CDVPlugin <ScanPayDelegate>
{
	BOOL _shouldShowConfirmationView;
	NSString * _callBackId;
}
- (void)startScanpay:(CDVInvokedUrlCommand*)command;
@end
