//
//  PingPongPresenter.h
//  SBRF-UIKit
//
//  Created Artem Balashov on 29/03/2019.
//  Copyright © 2019 pockerhead. All rights reserved.
//
//  Template generated by Balashov Artem @pockerhead
//

#import "PingPongProtocols.h"

@interface PingPongPresenter: NSObject<PingPongPresenterInterface>
@property (nonatomic, weak) NSObject<PingPongView> *view;
- (instancetype)initWithView:(NSObject<PingPongView>*)view
                      router:(NSObject<PingPongWireframeInterface>*)router;
@end


