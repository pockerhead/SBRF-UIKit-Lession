//
//  PingPongViewController.m
//  SBRF-UIKit
//
//  Created Artem Balashov on 29/03/2019.
//  Copyright © 2019 pockerhead. All rights reserved.
//
//  Template generated by Balashov Artem @pockerhead
//

#import "PingPongViewController.h"
#import <UIKit/UIKit.h>
#import "CollisionDetectorService.h"
#import "TimerFabric.h"

@interface PingPongViewController () <PingPongView>

@property (strong, nonatomic) UIView *ball;
@property (strong, nonatomic) UIView *topRocket;
@property (strong, nonatomic) UIView *bottomRocket;
@property (strong, nonatomic) UIView *gameMenuView;
@property (strong, nonatomic) UIView *countDownTimerView;
@property (strong, nonatomic) UILabel *countDownTimerLabel;
@property (strong, nonatomic) UIView *menuOverlay;
@property (strong, nonatomic) UIView *settingsOverlay;
@property (assign, nonatomic) CGFloat ballDx;
@property (assign, nonatomic) CGFloat ballDy;
@property (assign, nonatomic) NSTimer *gameTimer;
@property (assign, nonatomic) NSTimer *countDownTimer;
@property (assign, nonatomic) NSTimeInterval timerInterval;
@property (strong, nonatomic) TimerFabric *timerFabric;


@end


@implementation PingPongViewController

static CGFloat const rocketsHeight = 30;
static CGFloat const buttonsHeight = 30;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.timerFabric = [TimerFabric new];
    [self configureUI];
    [self setInitialState];
    [self.presenter viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.presenter viewWillAppear];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self pauseGame];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.presenter viewDidAppear];
}

// MARK: - Actions

- (void)didSelectStartGameButton
{
    [self.presenter didSelectStartGame];
    [self startGame];
}

- (void)didSelectSettingsButton
{
    [self.presenter didSelectSettings];
}

- (void)didSelectMenuButton
{
    [self hideCountDownView];
    [self.presenter didSelectMenuButton];
}

- (void)speedSliderValueChanged: (UISlider *)sender
{
    [AppSettings setSpeedSliderValue:sender.value];
    self.ballDx = sender.value * 2.5;
    self.ballDy = sender.value * 3.7;
}

- (void)topSwitchValueChanged:(UISwitch *)sender
{
    [AppSettings setIsTopComputer:sender.isOn];
}

- (void)bottomSwitchValueChanged:(UISwitch *)sender
{
    [AppSettings setIsBottomComputer:sender.isOn];
}

- (void)didSelectClearWinsButton
{
    [self.presenter didSelectClearWinsButton];
}
// MARK: - PingPongView

- (void)startGame
{
    self.navigationItem.title = [NSString stringWithFormat:@"%ld : %ld", (long)[AppSettings topWins], (long)[AppSettings bottomWins]];
    [self placeViewsAtGameStart];
    self.countDownTimerView.alpha = 0;
    [self showCountDownViewWithText:@"3"];
    [UIView animateWithDuration:0.2 animations:^{
        self.countDownTimerView.alpha = 1;
    } completion:^(BOOL finished) {
        [self startCountDownWithCountdown:2 completion:^{
            [self hideCountDownView];
            [self continueGame];
        }];
    }];
    
}

- (void)startCountDownWithCountdown:(NSInteger)countdown completion:(void(^)(void))completion
{
    self.countDownTimer = [self.timerFabric getTimerWithInterval:1 countDown:countdown intervalBlock:^(NSTimer * _Nonnull timer, NSInteger countDown) {
        [UIView transitionWithView:self.countDownTimerLabel duration:0.2 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            self.countDownTimerLabel.text = [NSString stringWithFormat:@"%@", @(countDown)];
        } completion:nil];
    } completionBlock:^{
        completion();
    }];
}

- (void)hideCountDownView
{
    [self.countDownTimerView setHidden:YES];
    [self.countDownTimer invalidate];
    self.countDownTimer = nil;
}

- (void)showCountDownViewWithText:(NSString *)text
{
    [self.countDownTimerView setHidden:NO];
    self.countDownTimerLabel.text = text;
}

- (void)continueGame
{
    self.gameTimer = [self.timerFabric getTimerWithInterval:self.timerInterval intervalBlock:^(NSTimer * _Nonnull timer) {
        [self runLoop];
    }];
}

- (void)pauseGame
{
    [self.gameTimer invalidate];
    self.gameTimer = nil;
}

- (void)displayMenu
{
    [self hideSettingsButton];
    [self.gameMenuView setHidden:NO];
    [UIView animateWithDuration:0.4 animations:^{
        self.gameMenuView.alpha = 1;
    }];
}

- (void)hideMenu
{
    [self displaySettingsButton];
    [UIView animateWithDuration:0.2 animations:^{
        self.gameMenuView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.gameMenuView setHidden:YES];
    }];
}

- (void)displayGameOverlay
{
    [self.menuOverlay setHidden:NO];
    [UIView animateWithDuration:0.4 animations:^{
        self.menuOverlay.alpha = 1;
    }];
}

- (void)hideGameOverlay
{
    [UIView animateWithDuration:0.2 animations:^{
        self.menuOverlay.alpha = 0;
    } completion:^(BOOL finished) {
        [self.menuOverlay setHidden:YES];
    }];
}

- (void)displaySettings
{
    [self.settingsOverlay setHidden:NO];
    [UIView animateWithDuration:0.4 animations:^{
        self.settingsOverlay.alpha = 1;
    }];
}

- (void)hideSettings
{
    [UIView animateWithDuration:0.2 animations:^{
        self.settingsOverlay.alpha = 0;
    } completion:^(BOOL finished) {
        [self.settingsOverlay setHidden:YES];
    }];
}

- (void)prepareGameStart {
    
}

#pragma mark - Score

- (void)playerWin:(BOOL)isTop
{
    if (isTop)
    {
        [AppSettings setTopWins:[AppSettings topWins] + 1];
    }
    else
    {
        [AppSettings setBottomWins:[AppSettings bottomWins] + 1];
    }
    [self pauseGame];
    [self startGame];
}

// MARK: - Touches Handle

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self choosePlayerFrom:touches];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self choosePlayerFrom:touches];
}

#pragma mark - Choose player from screen half


- (void)choosePlayerFrom: (NSSet <UITouch *>*)touches
{
    UITouch *touch1;
    UITouch *touch2;
    
    CGFloat centerYOfField = CGRectGetHeight(self.view.frame) / 2 - self.view.safeAreaInsets.bottom + self.view.safeAreaInsets.top;
    
    for (UITouch *touch in [touches allObjects])
    {
        if ([touch locationInView:self.view].y < centerYOfField)
        {
            touch2 = touch;
        }
        else
        {
            touch1 = touch;
        }
    }
    
    if (touch1 && [AppSettings isBottomComputer] == false)
    {
        self.bottomRocket.center = CGPointMake([touch1 locationInView:self.view].x, self.bottomRocket.center.y);
    }
    if (touch2 && [AppSettings isTopComputer] == false)
    {
        self.topRocket.center = CGPointMake([touch2 locationInView:self.view].x, self.topRocket.center.y);
    }
}

// MARK: - RunLoop

- (void)runLoop
{
    [self detectBallAndViewBoundsCollision];
    [self detectBallAndRocketsCollision];
    self.ball.center = CGPointMake(self.ball.center.x + self.ballDx, self.ball.center.y + self.ballDy);
    
    // MARK: - AI =)
    if ([AppSettings isTopComputer])
    {
        self.topRocket.center = CGPointMake(self.ball.center.x, self.topRocket.center.y);
    }
    
    if ([AppSettings isBottomComputer])
    {
        self.bottomRocket.center = CGPointMake(self.ball.center.x, self.bottomRocket.center.y);
    }
    
}

// MARK: - Collision detector

- (void)detectBallAndViewBoundsCollision
{
    if ([CollisionDetectorService isRectCollide:self.ball.frame withSideBounds:self.view.bounds])
    {
        self.ballDx *= -1;
    }
    
    if ([CollisionDetectorService isRectCollide:self.ball.frame withTopBottomBounds:self.view])
    {
        BOOL isTop = (self.ballDy > 0);
        [self playerWin: isTop];
    }
}

- (void)detectBallAndRocketsCollision
{
    if ([CollisionDetectorService isRectCollide:self.ball.frame withRect:self.topRocket.frame])
    {
        self.ballDy = fabs(self.ballDy);
    }
    
    if ([CollisionDetectorService isRectCollide:self.ball.frame withRect:self.bottomRocket.frame])
    {
        self.ballDy = -fabs(self.ballDy);
    }
}

// MARK: - UI Configuration

- (void)placeViewsAtGameStart
{
    self.topRocket.frame = CGRectMake(0, self.view.safeAreaInsets.top, CGRectGetWidth(self.view.frame) / 3, rocketsHeight);
    self.bottomRocket.frame = CGRectMake(0, CGRectGetHeight(self.view.frame) - self.view.safeAreaInsets.bottom - rocketsHeight, CGRectGetWidth(self.view.frame) / 3, rocketsHeight);
    self.ball.center = self.view.center;
    self.topRocket.center = CGPointMake(self.view.center.x, self.topRocket.center.y);
    self.bottomRocket.center = CGPointMake(self.view.center.x, self.bottomRocket.center.y);
}

- (void)displaySettingsButton
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Меню" style:UIBarButtonItemStylePlain target:self action:@selector(didSelectMenuButton)];
}

- (void)hideSettingsButton
{
    self.navigationItem.rightBarButtonItem = nil;
    
}

- (void)configureUI
{
    //configure UI
    self.navigationItem.title = @"Ping Pong Game";
    self.view.backgroundColor = [UIColor whiteColor];
    [self configureGameField];
    [self configureGameMenu];
    [self configureMenuOverlay];
    [self configureSettingsOverlay];
    [self configureCountdownView];
}

- (void)configureGameField
{
    // MARK: - Ball configure
    self.ball = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    self.ball.backgroundColor = [UIColor blackColor];
    self.ball.layer.cornerRadius = CGRectGetHeight(self.ball.frame) / 2;
    [self.view addSubview:self.ball];
    
    // MARK: - TopRocket configure
    self.topRocket = [[UIView alloc] initWithFrame: CGRectZero];
    self.topRocket.backgroundColor = [UIColor blackColor];
    self.topRocket.layer.cornerRadius = CGRectGetHeight(self.topRocket.frame) / 2;
    [self.view addSubview:self.topRocket];
    
    // MARK: - BottomRocket configure
    self.bottomRocket = [[UIView alloc] initWithFrame:CGRectZero];
    self.bottomRocket.backgroundColor = [UIColor blackColor];
    self.bottomRocket.layer.cornerRadius = CGRectGetHeight(self.bottomRocket.frame) / 2;
    [self.view addSubview:self.bottomRocket];
}

// MARK: - ConfigureGameMenu

- (void)configureGameMenu
{
    self.gameMenuView = [[UIView alloc] initWithFrame:self.view.frame];
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleProminent];
    UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:blur];
    blurView.frame = self.gameMenuView.bounds;
    [self.gameMenuView addSubview:blurView];
    [self.view addSubview:self.gameMenuView];
    self.gameMenuView.alpha = 0;
    [self.gameMenuView setHidden:YES];
}

// MARK: - configure menuOverlay

- (void)configureMenuOverlay
{
    
    self.menuOverlay = [[UIView alloc] initWithFrame:self.gameMenuView.bounds];
    [self.gameMenuView addSubview: self.menuOverlay];
    
    UIButton *startGameButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), buttonsHeight)];
    [startGameButton setTitle:[@"начать игру" uppercaseString] forState:UIControlStateNormal];
    startGameButton.titleLabel.font = [UIFont systemFontOfSize:20 weight:UIFontWeightBold];
    [startGameButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [startGameButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    
    startGameButton.center = CGPointMake(self.menuOverlay.center.x, self.menuOverlay.center.y - 30);
    [startGameButton addTarget:self action:@selector(didSelectStartGameButton) forControlEvents:UIControlEventTouchUpInside];
    [self.menuOverlay addSubview:startGameButton];
    
    UIButton *settingsButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), buttonsHeight)];
    [settingsButton setTitle:[@"Настройки" uppercaseString] forState:UIControlStateNormal];
    settingsButton.titleLabel.font = [UIFont systemFontOfSize:20 weight:UIFontWeightBold];
    [settingsButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [settingsButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    
    settingsButton.center = CGPointMake(self.menuOverlay.center.x, self.menuOverlay.center.y + 30);
    [settingsButton addTarget:self action:@selector(didSelectSettingsButton) forControlEvents:UIControlEventTouchUpInside];
    [self.menuOverlay addSubview:settingsButton];
    self.menuOverlay.alpha = 0;
    [self.menuOverlay setHidden:YES];
}

// MARK: - configure settingsOverlay

- (void)configureSettingsOverlay
{
    
    self.settingsOverlay = [[UIView alloc] initWithFrame:self.gameMenuView.bounds];
    [self.gameMenuView addSubview: self.settingsOverlay];
    
    UILabel *speedLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width / 2, 30)];
    speedLabel.text = @"Скорость игры";
    speedLabel.textAlignment = NSTextAlignmentCenter;
    speedLabel.center = CGPointMake(self.settingsOverlay.center.x, self.settingsOverlay.center.y - 80);
    [self.settingsOverlay addSubview:speedLabel];
    
    UISlider *speedSlider = [[UISlider alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width / 2, 30)];
    speedSlider.value = [AppSettings speedSliderValue];
    speedSlider.center = CGPointMake(self.settingsOverlay.center.x, self.settingsOverlay.center.y - 50);
    [speedSlider addTarget:self action:@selector(speedSliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.settingsOverlay addSubview:speedSlider];
    
    UIStackView *stackView1 = [[UIStackView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width / 1.3, 30)];
    stackView1.axis = UILayoutConstraintAxisHorizontal;
    stackView1.distribution = UIStackViewDistributionFillProportionally;
    UILabel *topPlayerCompLabel = [UILabel new];
    topPlayerCompLabel.text = @"Верхний игрок - комп";
    [stackView1 addArrangedSubview:topPlayerCompLabel];
    UISwitch *topPlayerCompSwitch = [UISwitch new];
    [topPlayerCompSwitch setOn:[AppSettings isTopComputer]];
    [topPlayerCompSwitch addTarget:self action:@selector(topSwitchValueChanged:) forControlEvents:UIControlEventValueChanged];
    [stackView1 addArrangedSubview:topPlayerCompSwitch];
    stackView1.center = CGPointMake(self.settingsOverlay.center.x, self.settingsOverlay.center.y);
    [self.settingsOverlay addSubview:stackView1];
    
    UIStackView *stackView2 = [[UIStackView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width / 1.3, 30)];
    stackView2.axis = UILayoutConstraintAxisHorizontal;
    stackView2.distribution = UIStackViewDistributionFillProportionally;
    UILabel *bottomPlayerCompLabel = [UILabel new];
    bottomPlayerCompLabel.text = @"Нижний игрок - комп";
    [stackView2 addArrangedSubview:bottomPlayerCompLabel];
    UISwitch *bottomPlayerCompSwitch = [UISwitch new];
    [bottomPlayerCompSwitch setOn:[AppSettings isBottomComputer]];
    [bottomPlayerCompSwitch addTarget:self action:@selector(bottomSwitchValueChanged:) forControlEvents:UIControlEventValueChanged];
    [stackView2 addArrangedSubview:bottomPlayerCompSwitch];
    stackView2.center = CGPointMake(self.settingsOverlay.center.x, self.settingsOverlay.center.y + 40);
    [self.settingsOverlay addSubview:stackView2];
    
    UIButton *settingsDoneButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), buttonsHeight)];
    [settingsDoneButton setTitle:[@"Готово" uppercaseString] forState:UIControlStateNormal];
    settingsDoneButton.titleLabel.font = [UIFont systemFontOfSize:20 weight:UIFontWeightBold];
    [settingsDoneButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [settingsDoneButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    settingsDoneButton.center = CGPointMake(self.settingsOverlay.center.x, self.settingsOverlay.center.y + 100);
    [settingsDoneButton addTarget:self action:@selector(didSelectMenuButton) forControlEvents:UIControlEventTouchUpInside];
    [self.settingsOverlay addSubview:settingsDoneButton];
    
    
    UIButton *clearWinsButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), buttonsHeight)];
    [clearWinsButton setTitle:[@"Сбросить счет" uppercaseString] forState:UIControlStateNormal];
    clearWinsButton.titleLabel.font = [UIFont systemFontOfSize:17 weight:UIFontWeightBold];
    [clearWinsButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [clearWinsButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    clearWinsButton.center = CGPointMake(self.settingsOverlay.center.x, self.settingsOverlay.center.y + 150);
    [clearWinsButton addTarget:self action:@selector(didSelectClearWinsButton) forControlEvents:UIControlEventTouchUpInside];
    [self.settingsOverlay addSubview:clearWinsButton];
    
    self.settingsOverlay.alpha = 0;
    [self.settingsOverlay setHidden:YES];
}

// MARK: - Countdown View

- (void)configureCountdownView
{
    
    self.countDownTimerView = [UIView new];
    self.countDownTimerView.frame = CGRectMake(0, 0, 150, 150);
    self.countDownTimerView.layer.cornerRadius = 15;
    self.countDownTimerView.layer.masksToBounds = YES;
    self.countDownTimerLabel.clipsToBounds = YES;
    UIBlurEffect *cdblur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *cdblurView = [[UIVisualEffectView alloc] initWithEffect:cdblur];
    cdblurView.frame = self.countDownTimerView.bounds;
    [self.countDownTimerView addSubview:cdblurView];
    self.countDownTimerLabel = [UILabel new];
    self.countDownTimerLabel.font = [UIFont systemFontOfSize:99 weight:UIFontWeightBold];
    self.countDownTimerLabel.minimumScaleFactor = 0.001;
    self.countDownTimerLabel.textColor = UIColor.whiteColor;
    self.countDownTimerLabel.frame = self.countDownTimerView.bounds;
    self.countDownTimerLabel.textAlignment = NSTextAlignmentCenter;
    [self.countDownTimerView addSubview:self.countDownTimerLabel];
    [self.view addSubview:self.countDownTimerView];
    self.countDownTimerView.center = self.view.center;
    [self.countDownTimerView setHidden:YES];
    
}

// MARK: - InitialState

- (void)setInitialState
{
    self.ballDx = [AppSettings speedSliderValue] * 2.5;
    self.ballDy = [AppSettings speedSliderValue] * 3.7;
    self.timerInterval = 0.005;
}

@end