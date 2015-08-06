//
//  BMWaveView.h
//  BMWaveViewDemo
//
//  Created by DingXiao on 15/8/3.
//  Copyright (c) 2015年 Dennis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BMWaveMaker : NSObject

/**
 *  the view which will add the animations;
 */
@property (nonatomic, weak) UIView *animationView;

/**
 *  the center of the wave, default is the View's center;
 */
@property (nonatomic, assign) CGPoint waveCenter;

/**
 *  wave's width, default is 2.0f;
 */
@property (nonatomic, assign) CGFloat wavePathWidth;

/**
 *  span animation duration, default is 1.0f;
 */
@property (nonatomic, assign) CGFloat animationDuration;

/**
 *  wave's color - Arc's color, default is [UIColor blueColor];
 */
@property (nonatomic, strong) UIColor *waveColor;

/**
 *  the origin wave layer's radius, not contains the board width;
 *  default value is 20.0f;
 */
@property (nonatomic, assign) CGFloat originRadius;

/**
 *  The following two property is used for calculating the final wave's size.
 *  The properties are alternative, if they are setted the value at the same time,
 *  the property spanSale is valid and the finalRadius property will be ignored.
 */

///Zoom in scale, the value should be greater than 1.0f;
@property (nonatomic, assign) CGFloat spanScale;
///Zoom in final radius, the value should be greater than originRadius, if not, the value will be originRadius * 2;
@property (nonatomic, assign) CGFloat finalRadius;

/**
 *  the color filled in the wave;
 */
@property (nonatomic, assign) UIColor *waveFillColor;

/**
 *  the stauts suggested that if the view has waves waving;
 */
@property (nonatomic, readonly) BOOL isWaving;

/**
 *  span a single wave
 */
- (void)spanWave;

/**
 *  span numerous waves
 *
 *  @param timeInteral waves cycle
 */
- (void)spanWaveContinuallyWithTimeInterval:(NSTimeInterval)timeInterval;

/**
 *  stop wave animation
 *
 *  @param immediately - if the value is YES, the waves will be removed immediately, otherwise, they'll be removed automatically
 */
- (void)stopWaveImmediately:(BOOL)immediately;

/**
 *  stop wave animation;  
 *  same as  [waveMaker stopWaveImmediately:NO];
 */
- (void)stopWave;

@end
