//
//  ManualSpanViewController.m
//  BMWaveViewDemo
//
//  Created by DingXiao on 15/8/4.
//  Copyright (c) 2015年 Dennis. All rights reserved.
//

#import "ManualSpanViewController.h"
#import "BMWaveMaker.h"

@interface ManualSpanViewController ()
@property (nonatomic, strong) BMWaveMaker *maker;
@end

@implementation ManualSpanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)spanWave:(UIButton *)sender {
    self.maker.waveCenter = sender.center;
    [self.maker spanWave];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - getter

- (BMWaveMaker *)maker {
    if (!_maker) {
        _maker = [[BMWaveMaker alloc] init];
        _maker.animationView = self.view;
        _maker.spanScale = 10.0f;
        _maker.waveColor = [UIColor orangeColor];
        _maker.animationDuration = 2.0f;
    }
    return _maker;
}

@end
