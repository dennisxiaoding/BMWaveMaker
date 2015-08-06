//
//  BMWaveView.m
//  BMWaveViewDemo
//
//  Created by DingXiao on 15/8/3.
//  Copyright (c) 2015年 Dennis. All rights reserved.
//

#import "BMWaveMaker.h"
#import "BMWaveLayer.h"

#ifdef DEBUG
    #define BMWarningLog(format, ...)  NSLog(@"[BMWaveWarning]: " format, ##__VA_ARGS__);
    #define BMLog(format, ...)  NSLog(@"[BMWaveLog]: " format, ##__VA_ARGS__);
#else
    #define BMWarningLog(format, ...)
    #define BMLog(format, ...) 
#endif

#define chargeViewIsValid if (!self.animationView) {\
                                BMWarningLog(@"%@",kBMViewError);\
                                return;\
                            }


static NSString *const kBMViewError = @"the animationView is nil";

@interface BMWaveMaker () <BMWaveLayerDelegate>
{
    NSInteger _waveProduct;
    NSInteger _waveDone;
    BOOL _needsAutoSpan;
}

@property (nonatomic, assign) NSTimeInterval spanTimeInterval;

@end


@implementation BMWaveMaker

#pragma mark - life cycel

- (void)dealloc
{
    
    [self.animationView.layer.sublayers makeObjectsPerformSelector:@selector(setDelegate:) withObject:nil];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(span) object:nil];
}

#pragma mark - public methods

- (void)spanWave {
    chargeViewIsValid;
    _needsAutoSpan = NO;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self span];
    });
}

- (void)spanWaveContinuallyWithTimeInterval:(NSTimeInterval)timeInteral {
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(span) object:nil];
    _needsAutoSpan = YES;
    self.spanTimeInterval = timeInteral;
    [self span];
}

- (void)stopWaveImmediately:(BOOL)immediately {
    _needsAutoSpan = NO;
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(span) object:nil];
    if (immediately) {
        chargeViewIsValid;
        for (CALayer *layer in self.animationView.layer.sublayers) {
            if ([layer isKindOfClass:[CAShapeLayer class]]) {
                [layer removeAllAnimations];
            }
        }
    }
}

- (void)stopWave {
    [self stopWaveImmediately: NO];
}

#pragma mark - convenience

- (void)span {
    chargeViewIsValid;
    _waveProduct ++;
    CGFloat radius = self.originRadius;
    UIBezierPath* smoothedPath = [UIBezierPath bezierPathWithArcCenter:self.waveCenter
                                                                radius:radius
                                                            startAngle:0
                                                              endAngle:M_PI*2
                                                             clockwise:YES];
    UIBezierPath* toSmoothedPath = [UIBezierPath bezierPathWithArcCenter:self.waveCenter
                                                                  radius:[self finalWaveRadius]
                                                              startAngle:0
                                                                endAngle:M_PI*2
                                                               clockwise:YES];
    CGRect rect = CGRectMake(0.0f, 0.0f, radius*2, radius*2);
    BMWaveLayer *waveLayer = [BMWaveLayer layer];
    waveLayer.contentsScale = [[UIScreen mainScreen] scale];
    waveLayer.fillColor = self.waveFillColor.CGColor;
    waveLayer.strokeColor = self.waveColor.CGColor;
    waveLayer.lineWidth = self.wavePathWidth;
    waveLayer.lineCap = kCALineCapRound;
    waveLayer.path = smoothedPath.CGPath;
    waveLayer.frame = rect;
    waveLayer.lineJoin = kCALineJoinBevel;
    waveLayer.animationDuration = self.animationDuration;
    
    waveLayer.fromPath = smoothedPath;
    waveLayer.toPath = toSmoothedPath;
    waveLayer.waveDelegate = self;
    [self.animationView.layer addSublayer:waveLayer];
    [waveLayer startAnimation];
    if (_needsAutoSpan) {
        [self performSelector:@selector(span) withObject:nil afterDelay:self.spanTimeInterval];
    }
}


#pragma mark - waveDeleagete

- (void)waveLayerDidFinishAnimation {
    chargeViewIsValid;
    BMLog(@"%@",NSStringFromSelector(_cmd));
    _waveDone ++;
    if (_waveDone == _waveProduct) {
        _waveDone = 0;
        _waveProduct = 0;
    }
}

#pragma mark - getter
- (CGFloat)finalWaveRadius {
    CGFloat finalRadius = 0.0f;
    if (_spanScale <= 0.0f && self.finalRadius > 0 && self.finalRadius < self.originRadius) {
        return self.finalRadius;
    }
    finalRadius = self.originRadius * self.spanScale;
    return finalRadius;
}

- (CGPoint)waveCenter {
    
    if (!self.animationView) {
        return CGPointZero;
    }
    
    if (CGPointEqualToPoint(CGPointZero, _waveCenter)) {
        _waveCenter = CGPointMake(CGRectGetWidth(self.animationView.bounds)/2,CGRectGetHeight(self.animationView.bounds)/2);
    }
    return _waveCenter;
}

- (UIColor *)waveColor {
    if (!_waveColor) {
        _waveColor = [UIColor blueColor];
    }
    return _waveColor;
}

- (CGFloat)wavePathWidth {
    if (_wavePathWidth <= 0.0f) {
        _wavePathWidth = 2.0f;
    }
    return _wavePathWidth;
}

- (CGFloat)animationDuration {
    if (_animationDuration <= 0.0f) {
        _animationDuration = 1.0f;
    }
    return _animationDuration;
}

- (CGFloat)spanScale {
    if (_spanScale <= 1.0f) {
        _spanScale = 2.0f;
    }
    return _spanScale;
}

- (CGFloat)originRadius {
    if (_originRadius <= 0.0f) {
        _originRadius = 20.0f;
    }
    return _originRadius;
}

- (UIColor *)waveFillColor {
    if (!_waveFillColor || !self.animationView) {
        _waveFillColor = [UIColor clearColor];
    }
    return _waveFillColor;
}

- (BOOL)isWaving {
    if (_waveDone < _waveProduct) {
        return YES;
    } else {
        return NO;
    }
}
@end
