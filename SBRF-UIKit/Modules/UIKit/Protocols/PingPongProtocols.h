//
//  PingPongProtocols.h
//  SBRF-UIKit
//
//  Created Artem Balashov on 29/03/2019.
//  Copyright © 2019 pockerhead. All rights reserved.
//
//  Template generated by Balashov Artem @pockerhead
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//Router implement navigateTo func
@protocol PingPongWireframeInterface <NSObject>
//example
- (void)navigateToDismiss;

@end


@protocol PingPongView <NSObject>

- (void)placeViewsAtGameStart;
- (void)displayMenu;
- (void)hideMenu;

- (void)displayGameOverlay;
- (void)hideGameOverlay;
- (void)startGame;
- (void)pauseGame;
- (void)continueGame;
- (void)displaySettings;
- (void)hideSettings;
- (void)prepareGameStart;

@end


@protocol PingPongPresenterInterface <NSObject>

- (void)didSelectSettings;
- (void)didSelectStartGame;
- (void)didSelectMenuButton;

- (void)viewDidLoad;
- (void)viewWillAppear;
- (void)viewDidAppear;
- (void)viewWillDissappear;
- (void)viewDidDissappear;

@end


NS_ASSUME_NONNULL_END
