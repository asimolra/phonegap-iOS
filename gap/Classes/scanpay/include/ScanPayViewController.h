//
//  ScanPayViewController.h
//  ScanPaySDK
//
//  Copyright (c) 2013 Scanpay. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SPCreditCard.h"
#import "ScanPayDelegate.h"

/*!
 @class SPPaymentViewController
 @discussion This class is used for make a payment, you simply have to present it from a UIViewController using presentModalViewController:animated:
 */
@interface ScanPayViewController : UINavigationController

/*!
 @property delegate Delegate used for retrieve the result of scan
 */
@property (nonatomic, assign) id<ScanPayDelegate> scanDelegate;

/*!
 @property appToken The token used for authentification
 */
@property (nonatomic, retain) NSString *appToken;

/*!
 @method initForScanWithDelegate:
 @discussion Method that initialize directy the scan with a delegate
 @param aDelegate The delegate class
 @param appToken The token we gave you for your app
 */
- (id)initWithDelegate:(id<ScanPayDelegate>)aDelegate appToken:(NSString *)yourAppToken;

@end
