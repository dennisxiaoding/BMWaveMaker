//
//  AutoSpanViewController.m
//  BMWaveViewDemo
//
//  Created by DingXiao on 15/8/5.
//  Copyright (c) 2015年 Dennis. All rights reserved.
//

#import "AutoSpanViewController.h"
#import "BMWaveMaker.h"

@interface AutoSpanViewController ()

@property (weak, nonatomic) IBOutlet UISwitch *stopImmediatelySwitch;
@property (nonatomic, strong) BMWaveMaker *maker;
@property (nonatomic, assign) BOOL isWaving;

@end

@implementation AutoSpanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)swtichAction:(UISwitch *)sender {
    
}

- (IBAction)stopButtonAction:(UIButton *)sender {
    if (self.isWaving) {
        if (self.stopImmediatelySwitch.on) {
            [self.maker stopWaveImmediately:YES];
        } else {
            [self.maker stopWave];
        }
    }
    self.isWaving = NO;
}

- (IBAction)spanButtonAction:(UIButton *)sender {
    if (!self.isWaving) {
        [self.maker spanWaveContinuallyWithTimeInterval:0.7f];
        self.isWaving = YES;
    }
}


#pragma mark - getter

- (BMWaveMaker *)maker {
    if (!_maker) {
        _maker = [[BMWaveMaker alloc] init];
        _maker.animationView = self.view;
        _maker.spanScale = 10.0f;
        _maker.waveColor = [UIColor darkGrayColor];
        _maker.animationDuration = 2.0f;
    }
    return _maker;
}

@end
