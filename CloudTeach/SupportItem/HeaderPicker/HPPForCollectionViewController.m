//
//  HPPForCollectionViewController.m
//  HNABim
//
//  Created by tiny on 17/3/6.
//  Copyright © 2017年 刘欢. All rights reserved.
//

#import "HPPForCollectionViewController.h"
#import "HPPPreViewController.h"
#import "VPImageCropperViewController.h"

#define MARGIN 10
#define COL 4

static NSString * const reuseIdentifier = @"Cell";

@interface HPPForCollectionViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,VPImageCropperDelegate>

@end

@implementation HPPForCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    // Do any additional setup after loading the view.
}

- (void)initUI {
    self.titleLabel.text = self.titleText;
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = MARGIN;
    flowLayout.minimumInteritemSpacing = MARGIN;
    CGFloat cellHeight = (SCREEN_WIDTH - (COL + 1) * MARGIN) / COL;
    flowLayout.itemSize = CGSizeMake(cellHeight, cellHeight);
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) collectionViewLayout:flowLayout];
    collectionView.backgroundColor = HEX_RGB(0xffffff);
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:collectionView];
    
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.assetResult.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    if (cell.backgroundView == nil) {//防止多次创建
        UIImageView *imageView = [[UIImageView alloc] init];
        cell.backgroundView = imageView;
    }
    
    PHAsset *asset = [self.assetResult objectAtIndex:indexPath.row];
    
    UIImageView *backView = (UIImageView *)cell.backgroundView;
    
    // Configure the cell
    CGFloat cellHeight = (SCREEN_WIDTH - (COL + 1) * MARGIN) / COL;
    [[PHCachingImageManager defaultManager] requestImageForAsset:asset
     
                                                      targetSize:CGSizeMake(cellHeight, cellHeight)
     
                                                     contentMode:PHImageContentModeAspectFill
     
                                                         options:nil
     
                                                   resultHandler:^(UIImage
                                                                   *result, NSDictionary *info) {
                                                       
                                                       if(result) {
                                                           backView.image = result;
                                                       }
                                                       
                                                       
                                                   }];
    
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    PHAsset *asset = [self.assetResult objectAtIndex:indexPath.row];
    
//    HPPPreViewController *pre = [HPPPreViewController new];
//    pre.asset = [asset copy];
//    [self.navigationController pushViewController:pre animated:YES];
    
    [[PHCachingImageManager defaultManager] requestImageDataForAsset:[asset copy] options:nil resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
        
        VPImageCropperViewController *imgCropperVC = [[VPImageCropperViewController alloc] initWithImage:[UIImage imageWithData:imageData] cropFrame:CGRectMake(0, 100.0f, self.view.frame.size.width, self.view.frame.size.width) limitScaleRatio:3.0];
        imgCropperVC.delegate = self;
        [self.navigationController pushViewController:imgCropperVC animated:YES];
        
    }];
    
}

#pragma mark VPImageCropperDelegate
- (void)imageCropper:(VPImageCropperViewController *)cropperViewController didFinished:(UIImage *)editedImage {
//    imgv.image = editedImage;
//    [cropperViewController dismissViewControllerAnimated:YES completion:^{
//        // TO DO
//    }];
}

- (void)imageCropperDidCancel:(VPImageCropperViewController *)cropperViewController {
//    [cropperViewController dismissViewControllerAnimated:YES completion:^{
//    }];
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
