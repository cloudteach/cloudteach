//
//  HPPPreViewController.m
//  HeadPhotoPicker
//
//  Created by tiny on 17/3/3.
//  Copyright © 2017年 tiny. All rights reserved.
//

#import "HPPPreViewController.h"

@interface HPPPreViewController ()
{
    CGRect rectBorder;
    UIImageView *imgvBorder;
    UIView *holderView;
    UIImageView *showImgView;
}
@property (nonatomic,strong) UIButton *btnOK;
@end

@implementation HPPPreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (void)initUI {
    self.titleLabel.text = @"编辑图片";
    
    [self.rightButton addTarget:self action:@selector(okClick) forControlEvents:UIControlEventTouchUpInside];
    
    //绘制边框
    imgvBorder = [UIImageView new];
    imgvBorder.frame = CGRectMake(60, 60 + 64, SCREEN_WIDTH-120, SCREEN_WIDTH-120);
    imgvBorder.backgroundColor = [UIColor clearColor];
    imgvBorder.layer.borderWidth = 2;
    imgvBorder.layer.borderColor = [UIColor blackColor].CGColor;
    //    imgvBorder.image = [self toDrawRect:imgvBorder.frame];
    [self.view insertSubview:imgvBorder belowSubview:self.viewTitle];
    
    rectBorder = imgvBorder.frame;
    
    float width = SCREEN_WIDTH-40;
    
    holderView = [[UIView alloc]initWithFrame:CGRectMake(18,64 + 10,width, width)];
    [self addGestureRecognizerToView:holderView];
    
    showImgView = [[UIImageView alloc]initWithFrame:CGRectMake(2,2,width-4, width-4)];
    showImgView.image = [self assetImage];
    showImgView.contentMode = UIViewContentModeScaleAspectFit;
    [holderView addSubview:showImgView];
    
    [self.view insertSubview:holderView belowSubview:imgvBorder];
}

- (void)backClick {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)okClick {

    UIImage *image = [self makeImage:imgvBorder];
    
    NSDictionary *dicHead = @{@"head":image};
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"didHeadChoosed" object:dicHead];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

// 添加所有的手势
- (void) addGestureRecognizerToView:(UIView *)view
{
    // 旋转手势
    UIRotationGestureRecognizer *rotationGestureRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotateView:)];
    [view addGestureRecognizer:rotationGestureRecognizer];
    
    // 缩放手势
    UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchView:)];
    [view addGestureRecognizer:pinchGestureRecognizer];
    
    // 移动手势
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panView:)];
    [view addGestureRecognizer:panGestureRecognizer];
}

// 处理旋转手势
- (void) rotateView:(UIRotationGestureRecognizer *)rotationGestureRecognizer
{
    UIView *view = rotationGestureRecognizer.view;
    if (rotationGestureRecognizer.state == UIGestureRecognizerStateBegan || rotationGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        view.transform = CGAffineTransformRotate(view.transform, rotationGestureRecognizer.rotation);
        [rotationGestureRecognizer setRotation:0];
    }
}

// 处理缩放手势
- (void) pinchView:(UIPinchGestureRecognizer *)pinchGestureRecognizer
{
    UIView *view = pinchGestureRecognizer.view;
    if (pinchGestureRecognizer.state == UIGestureRecognizerStateBegan || pinchGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        view.transform = CGAffineTransformScale(view.transform, pinchGestureRecognizer.scale, pinchGestureRecognizer.scale);
        pinchGestureRecognizer.scale = 1;
    }
}

// 处理拖拉手势
- (void) panView:(UIPanGestureRecognizer *)panGestureRecognizer
{
    UIView *view = panGestureRecognizer.view;
    if (panGestureRecognizer.state == UIGestureRecognizerStateBegan || panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [panGestureRecognizer translationInView:view.superview];
        [view setCenter:(CGPoint){view.center.x + translation.x, view.center.y + translation.y}];
        [panGestureRecognizer setTranslation:CGPointZero inView:view.superview];
    }
}

- (void)initImageView {
    UIImageView *imageView = [UIImageView new];
    imageView.frame = CGRectMake(10, 64+20, SCREEN_WIDTH-20, SCREEN_WIDTH-20);
    imageView.image = [self assetImage];
    [self.view addSubview:imageView];
}

- (UIImage *)assetImage {
    __block UIImage *image = nil;
    
    [[PHCachingImageManager defaultManager] requestImageDataForAsset:self.asset options:nil resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
        image = [[UIImage imageWithData:imageData] copy];
        showImgView.image = image;
    }];
    
    return image;
}

//截图
- (UIImage *) captureScreen {
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    CGRect rect = rectBorder;
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [keyWindow.layer renderInContext:context];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

- (UIImage *)snapshot:(UIView *)view {
    
    UIGraphicsBeginImageContextWithOptions(view.bounds.size,YES,0);
    [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:YES];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    imgvBorder.image = image;
    return image;
    
}

- (UIImage *)makeImage:(UIView *)view {
    UIWindow *screenWindow = [[UIApplication sharedApplication] keyWindow];
    
    UIGraphicsBeginImageContext(screenWindow.frame.size);//全屏截图，包括window
    
    [screenWindow.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *viewImage =UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    CGRect aFrame = view.frame;
    aFrame.origin.x += 2;
    aFrame.size.width -= 4;
    aFrame.origin.y += 2;
    aFrame.size.height -= 4;
    
    UIImage *image = [UIImage imageWithCGImage:CGImageCreateWithImageInRect(viewImage.CGImage, aFrame)];
    
    return image;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
