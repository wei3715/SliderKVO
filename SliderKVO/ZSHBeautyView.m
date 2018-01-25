//
//  ZSHBeautyView.m
//  SliderKVO
//
//  Created by mac on 2018/1/24.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ZSHBeautyView.h"

@interface ZSHBeautyView()

@property (nonatomic, strong) UIView  *beautySettingView;
@property (nonatomic, strong) NSArray *sliderActionArr;
@property (nonatomic, strong) NSArray *beautyDefaultValueArr;
@property (nonatomic, strong) NSMutableArray *sliderArr;
@end

@implementation ZSHBeautyView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup{
    self.backgroundColor = [UIColor orangeColor];
    _sliderArr = [[NSMutableArray alloc]init];
    _beautySettingView = [[UIView alloc]initWithFrame:CGRectMake(0, 10, 375, 200)];
    
    [self addSubview:_beautySettingView];
    
    NSArray *titleArr = @[@[@"磨皮",@"美白"],
                          @[@"红润",@"腮红"],
                          @[@"瘦脸",@"大眼"],
                          @[@"收下巴"]];
    
    _sliderActionArr = @[@[@"buffingValueChange:",@"whiteValueChange:"],
                         @[@"ruddyValueChange:",@"cheekPinkValueChange:"],
                         @[@"thinfaceValueChange:",@"bigeyeValueChange:"],
                         @[@"shortenfaceValueChange:"]];
    
    _beautyDefaultValueArr = @[@[@(30),@(40)],
                               @[@(50),@(60)],
                               @[@(70),@(80)],
                               @[@(90)]
                               ];
    
    for (int i = 0; i<titleArr.count; i++) {
        for (int j = 0; j<[titleArr[i]count]; j++) {
            UILabel *beautyLB = [[UILabel alloc]initWithFrame:CGRectMake(15+(j%2)*180, 15+i*(30) ,60, 15)];
            beautyLB.text = titleArr[i][j];
            beautyLB.textColor = [UIColor redColor];
            [self.beautySettingView addSubview:beautyLB];
            
            CGFloat sliderX = CGRectGetMaxX(beautyLB.frame) + 5;
            
            
            UISlider *slider = [[UISlider alloc] init];
            slider.tag = i+j;
            slider.minimumTrackTintColor = [UIColor redColor];
            slider.maximumTrackTintColor = [UIColor greenColor];
            
            [slider setThumbImage:[UIImage imageNamed:@"age_icon"] forState:UIControlStateNormal];
            slider.frame = CGRectMake(sliderX, 15+i*(30),100,2);
            
            //利用kvo可以实现不仅在手动拖动slider时可以响应方法，在其他地方改变slider的值也可以响应方法
            [slider addObserver:self forKeyPath:@"value" options:(NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew) context:nil];
            slider.maximumValue = 100;
            slider.minimumValue = 0;
            slider.value = [_beautyDefaultValueArr[i][j] intValue];
            [self.beautySettingView addSubview:slider];
            [_sliderArr addObject:slider];
        }
    }
}


#pragma mark - Slider Actions
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    NSLog(@"keyPath=%@,object=%@,change=%@,context=%@",keyPath,object,change,context);
    
    //    UISlider *slider = object;
    //    SEL method = NSSelectorFromString(_sliderActionArr[slider.tag/2][slider.tag%2]);
    //会有warning： PerformSelector may cause a leak because its selector is unknown
    //   [self performSelector:method withObject:slider];
    
    //解决
    if (!object) { return;}
    UISlider *slider = object;
    SEL method = NSSelectorFromString(_sliderActionArr[slider.tag/2][slider.tag%2]);
    IMP imp = [self methodForSelector:method];
    //含有参数的方法分法
    void (*func)(id, SEL, id) = (void *)imp;
    func(self, method, object);
    
    //没有参数的方法分法
    //    void (*func)(id, SEL) = (void *)imp;
    //    func(self, method);
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    for (UISlider *slider in _sliderArr) {
        CGFloat defaultValue = [_beautyDefaultValueArr[slider.tag/2][slider.tag%2] intValue];
        slider.value = defaultValue + (slider.tag)*5;
    }
}

//其中一个磨皮方法
- (void)buffingValueChange:(UISlider *)slider {
    
    NSLog(@"执行磨皮");
}

- (void)whiteValueChange:(UISlider *)slider {
    
    NSLog(@"执行美白");
}

- (void)ruddyValueChange:(UISlider *)slider {
    
    NSLog(@"执行红润");
}

- (void)cheekPinkValueChange:(UISlider *)slider {
    
    NSLog(@"执行腮红");
}

- (void)thinfaceValueChange:(UISlider *)slider {
    
    NSLog(@"执行瘦脸");
}

- (void)bigeyeValueChange:(UISlider *)slider {
    
    NSLog(@"执行大眼");
}

- (void)shortenfaceValueChange:(UISlider *)slider {
    
    NSLog(@"执行收下巴");
}

@end
