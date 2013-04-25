//
//  CDVScanpay.m
//
//  Created by Scanpay on 25/04/13.
//
//

#import "CDVScanpay.h"

@interface CDVScanpay()
@end

@implementation CDVScanpay

- (void)startScanpay:(CDVInvokedUrlCommand*)command
{
	if ([command.arguments count] == 0)
	{
		 [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"No Token specified. You must create an account on scanpay.it to use this feature"] callbackId:command.callbackId];
	}
	else if ([command.arguments count] == 2 && [[command.arguments objectAtIndex:1] boolValue])
	{
		_shouldShowConfirmationView = true;
	}
	
	_callBackId = [command.callbackId copy];

#if !(TARGET_IPHONE_SIMULATOR)
	ScanPayViewController *scan = [[ScanPayViewController alloc]initWithDelegate:self appToken:[command.arguments objectAtIndex:0]];
	[self.viewController presentViewController:scan animated:YES completion:nil];
	[scan release];
#else
		 [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Scan is not available on simulator"] callbackId:command.callbackId];
#endif
}

- (void)scanPayViewController:(ScanPayViewController *)scanPayViewController didScanCard:(SPCreditCard *)card
{
	NSArray *keys = [NSArray arrayWithObjects:@"cardNumber", @"cardMonth", @"cardYear", @"cardCVC", nil];
	NSArray *values = [NSArray arrayWithObjects:card.number, !card.month ? @"" : card.month, !card.year ? @"" : card.year, !card.cvc ? @"" : card.cvc, nil];
	NSDictionary *dict = [NSDictionary dictionaryWithObjects:values forKeys:keys];

	CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:dict];
	[self.commandDelegate sendPluginResult:result callbackId:[_callBackId autorelease]];
}

- (void)scanCancelledByUser:(ScanPayViewController *)scanPayViewController
{
	 [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"userDidCancel"] callbackId:[_callBackId autorelease]];
}

- (void)scanPayViewController:(ScanPayViewController *)scanPayViewController failedToScanWithError:(NSError *)error
{
	[self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:[NSString stringWithFormat:@"Error : %@", error.localizedDescription]] callbackId:[_callBackId autorelease]];
}

- (BOOL)scanPayViewControllerShouldShowConfirmationView:(ScanPayViewController *)scanPayViewController
{
	return _shouldShowConfirmationView;
}

@end
