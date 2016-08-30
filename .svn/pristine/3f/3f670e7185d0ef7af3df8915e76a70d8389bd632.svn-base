//
//  DBSphereView.m
//  sphereTagCloud
//
//  Created by Xinbao Dong on 14/8/31.
//  Copyright (c) 2014年 Xinbao Dong. All rights reserved.
//

#import "DBSphereView.h"
#import "DBMatrix.h"

@interface DBSphereView() <UIGestureRecognizerDelegate>

@end

@implementation DBSphereView
{
    NSMutableArray *tags;
    NSMutableArray *coordinate;
    DBPoint normalDirection;
    CGPoint last;
    
    CGFloat velocity;
    
    CADisplayLink *timer;
    CADisplayLink *inertia;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIPanGestureRecognizer *gesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
        [self addGestureRecognizer:gesture];
    }
    return self;
}

#pragma mark - initial set

- (void)setCloudTags:(NSArray *)array
{
    tags = [[NSMutableArray arrayWithArray:array] retain];
    coordinate = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (NSInteger i = 0; i < tags.count; i ++) {
        UIView *view = [tags objectAtIndex:i];
        view.center = CGPointMake(self.frame.size.width / 2., self.frame.size.height / 2.);
    }
    
    CGFloat p1 = M_PI * (3 - sqrt(5));
    CGFloat p2 = 2. / tags.count;
    
    for (NSInteger i = 0; i < tags.count; i ++) {
        
        CGFloat y = i * p2 - 1 + (p2 / 2);
        CGFloat r = sqrt(1 - y * y);
        CGFloat p3 = i * p1;
        CGFloat x = cos(p3) * r;
        CGFloat z = sin(p3) * r;
        
        
        DBPoint point = DBPointMake(x, y, z);
        NSValue *value = [NSValue value:&point withObjCType:@encode(DBPoint)];
        [coordinate addObject:value];
        
        CGFloat time = (arc4random() % 10 + 10.) / 20.;
        [UIView animateWithDuration:time delay:0. options:UIViewAnimationOptionCurveEaseOut animations:^{
            [self setTagOfPoint:point andIndex:i];
        } completion:^(BOOL finished) {
            
        }];
        
    }
 
    NSInteger a =  arc4random() % 10 - 5;
    NSInteger b =  arc4random() % 10 - 5;
    normalDirection = DBPointMake(a, b, 0);
    [self timerStart];
}

#pragma mark tags回归零位
- (void)goBackToZeroAnimateCompletion:(void (^)())completion
{
    // 否则移动中切换回出现问题
    [self timerStop];
    [self inertiaStop];
    [self timerStop];
    
    // 遍历数组
    CGFloat duration = .5;
    
    for (NSInteger i = 0; i < tags.count; i ++) {
        [UIView animateWithDuration:duration delay:0. options:UIViewAnimationOptionCurveEaseOut animations:^{
            
            // 回归零位
//            UIView *view = tags[i];
//            view.center = CGPointMake(self.bounds.size.width / 2., self.bounds.size.height / 2.);
//            
//            CGFloat transform = .8;
//            view.transform = CGAffineTransformScale(CGAffineTransformIdentity, transform, transform);
//            view.layer.zPosition = transform;
//            view.alpha = transform;
            DBPoint point = DBPointMake(0, 0, 0);
            [self setTagOfPoint:point andIndex:i];
            
        } completion:^(BOOL finished) {
            
        }];
    }
    
    // 动画结束执行competion Block
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), completion);
    // 配合上面动画延迟执行的动画
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIView *view = [tags lastObject];
        [UIView animateWithDuration:.2 animations:^{
            view.transform = CGAffineTransformMakeScale(2, 2);
            self.alpha = 0;
        }];
    });
}

#pragma mark - set frame of point

- (void)updateFrameOfPoint:(NSInteger)index direction:(DBPoint)direction andAngle:(CGFloat)angle
{

    NSValue *value = [coordinate objectAtIndex:index];
    DBPoint point;
    [value getValue:&point];
    
    DBPoint rPoint = DBPointMakeRotation(point, direction, angle);
    value = [NSValue value:&rPoint withObjCType:@encode(DBPoint)];
    coordinate[index] = value;
    
    [self setTagOfPoint:rPoint andIndex:index];

}

- (void)setTagOfPoint: (DBPoint)point andIndex:(NSInteger)index
{
    UIView *view = [tags objectAtIndex:index];
    view.center = CGPointMake((point.x + 1) * (self.frame.size.width / 2.), (point.y + 1) * self.frame.size.width / 2.);
    
    CGFloat transform = (point.z + 2) / 3;
    view.transform = CGAffineTransformScale(CGAffineTransformIdentity, transform, transform);
    view.layer.zPosition = transform;
    view.alpha = transform;
    if (point.z < 0) {
        view.userInteractionEnabled = NO;
    }else {
        if (velocity == 0) {
            view.userInteractionEnabled = YES;
        }
    }
}

#pragma mark - autoTurnRotation

- (void)timerStart
{
    timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(autoTurnRotation)];
    [timer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void)timerStop
{
    [timer invalidate];
    timer = nil;
}

- (void)autoTurnRotation
{
    for (NSInteger i = 0; i < tags.count; i ++) {
        [self updateFrameOfPoint:i direction:normalDirection andAngle:0.002];
    }
    
}

#pragma mark - inertia

- (void)inertiaStart
{
    [self timerStop];
    for (UIView *view in tags) {
        view.userInteractionEnabled = NO;
    }
    inertia = [CADisplayLink displayLinkWithTarget:self selector:@selector(inertiaStep)];
    [inertia addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void)inertiaStop
{
    [inertia invalidate];
    inertia = nil;
    [self timerStart];
    for (UIView *view in tags) {
        view.userInteractionEnabled = YES;
    }
}

- (void)inertiaStep
{
    if (velocity <= 0) {
        [self inertiaStop];
    }else {
        velocity -= 70.;
        CGFloat angle = velocity / self.frame.size.width * 2. * inertia.duration;
        for (NSInteger i = 0; i < tags.count; i ++) {
            [self updateFrameOfPoint:i direction:normalDirection andAngle:angle];
        }
    }
    
}

#pragma mark - gesture selector

- (void)handlePanGesture:(UIPanGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateBegan) {
        last = [gesture locationInView:self];
        [self timerStop];
        [self inertiaStop];
        
    }else if (gesture.state == UIGestureRecognizerStateChanged) {
        CGPoint current = [gesture locationInView:self];
        DBPoint direction = DBPointMake(last.y - current.y, current.x - last.x, 0);
        
        CGFloat distance = sqrt(direction.x * direction.x + direction.y * direction.y);
        
        CGFloat angle = distance / (self.frame.size.width / 2.);
        
        for (NSInteger i = 0; i < tags.count; i ++) {
            [self updateFrameOfPoint:i direction:direction andAngle:angle];
        }
        normalDirection = direction;
        last = current;
    }else if (gesture.state == UIGestureRecognizerStateEnded) {
        CGPoint velocityP = [gesture velocityInView:self];
        velocity = sqrt(velocityP.x * velocityP.x + velocityP.y * velocityP.y);
        [self inertiaStart];

    }
    
    
}

@end


