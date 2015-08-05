//
//  FingeDemoViewController.m
//  BMWaveViewDemo
//
//  Created by DingXiao on 15/8/5.
//  Copyright (c) 2015年 Dennis. All rights reserved.
//

#import "FingeDemoViewController.h"
#import "BMWaveMaker.h"

@interface FingeDemoViewController ()
@property (nonatomic, strong) BMWaveMaker *maker;
@end

@implementation FingeDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.maker.isWaving) {
        [self.maker stopWave];
    }
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch  locationInView:self.view];
    self.maker.waveCenter = point;
    [self.maker spanWaveContinuallyWithTimeInterval:0.6f];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.maker stopWave];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.maker stopWave];
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
