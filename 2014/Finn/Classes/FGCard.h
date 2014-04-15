//
//  FGCard.h
//  Finn Gaida
//
//  Created by Finn Gaida on 08.04.14.
//  Copyright (c) 2014 Finn Gaida. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>
#import <AVFoundation/AVFoundation.h>


@protocol FGCardDelegate

/**
 *  Calling back to the main view controller to send a notification to the remote screen
 *
 *  @param sender UIControl instance contanining the tag
 */
- (void)showRemoteView:(id)sender;

/**
 *  Called whenever a text view is called. The delegate then check whether it's a hotword or not.
 *
 *  @param tap UITapGestureRecognizer containing the tap's location
 */
- (void)handleTapGesture:(UITapGestureRecognizer *)tap;

@end


@interface FGCard : UIView <UIAlertViewDelegate>

@property (nonatomic) id <FGCardDelegate> delegate;

/**
 *  Used internally by the public method.
 *
 *  @param cardID 1 - 14 from about me to the secret card
 *
 *  @return the fully set up wanted card
 */
- (id)initWithCardID:(int)cardID;

/**
 *  The method used by the main VC to fetch the cards
 *
 *  @param cardID   1-14 from about me to the secret card
 *  @param delegate View controller to call back the handleTap and showRemoteView on
 *
 *  @return A fully set-up FGCard of the wanted id ready to use
 */
+ (FGCard *)card:(int)cardID delegate:(id <FGCardDelegate>)delegate;

@end
