//
//  PingPongViewController.h
//  SBRF-UIKit
//
//  Created Artem Balashov on 29/03/2019.
//  Copyright © 2019 pockerhead. All rights reserved.
//
//  Template generated by Balashov Artem @pockerhead
//

#import <UIKit/UIKit.h>
#import "PingPongProtocols.h"

NS_ASSUME_NONNULL_BEGIN

@interface PingPongViewController : UIViewController<PingPongView>

@property (nonatomic, strong) NSObject<PingPongPresenterInterface>* presenter;

@end

NS_ASSUME_NONNULL_END