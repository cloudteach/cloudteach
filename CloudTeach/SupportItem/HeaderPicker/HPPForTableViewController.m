//
//  HPPForTableViewController.m
//  HNABim
//
//  Created by tiny on 17/3/6.
//  Copyright © 2017年 刘欢. All rights reserved.
//

#import "HPPForTableViewController.h"
#import "HPPForCollectionViewController.h"

@interface HPPForTableViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    
}
@end

@implementation HPPForTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    // Do any additional setup after loading the view.
}

- (void)initUI {
    self.titleLabel.text = @"相册";
    
    UITableView *tableView = [[UITableView alloc] init];
    tableView.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64);
    tableView.backgroundColor = HEX_RGB(0xffffff);
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.showsHorizontalScrollIndicator = NO;
    
    [self.view addSubview:tableView];
    
    //分割线左起
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 58;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _fetchResult.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    [cell.contentView removeAllSubviews];
    
    UIImageView *imgvIcon = [UIImageView new];
    imgvIcon.frame = CGRectMake(8, 8, 42, 42);
    imgvIcon.backgroundColor = HEX_RGB(0x333333);
    [cell.contentView addSubview:imgvIcon];
    
    UILabel *labelName = [UILabel new];
    labelName.frame = CGRectMake(55, 8, SCREEN_WIDTH-55, 42);
    [cell.contentView addSubview:labelName];
    
    PHFetchOptions *options = [[PHFetchOptions alloc] init];
    options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
    options.predicate = [NSPredicate predicateWithFormat:@"mediaType = %d",PHAssetMediaTypeImage];
    
    PHAssetCollection *assetCollection = _fetchResult[indexPath.row];
    
    PHFetchResult *assetsFetchResult = [PHAsset fetchAssetsInAssetCollection:assetCollection options:options];
    
    PHAsset *asset = assetsFetchResult.firstObject;
    [[PHCachingImageManager defaultManager] requestImageForAsset:asset targetSize:CGSizeMake(42, 42) contentMode:PHImageContentModeAspectFit options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        imgvIcon.image = [result copy];
    }];
    
    labelName.text = [NSString stringWithFormat:@"%@(%li)",assetCollection.localizedTitle,assetsFetchResult.count];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PHFetchOptions *options = [[PHFetchOptions alloc] init];
    options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
    options.predicate = [NSPredicate predicateWithFormat:@"mediaType = %d",PHAssetMediaTypeImage];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    PHAssetCollection *assetCollection = _fetchResult[indexPath.row];
    
    PHFetchResult *assetsFetchResult = [PHAsset fetchAssetsInAssetCollection:assetCollection options:options];
    
    HPPForCollectionViewController *hpp = [HPPForCollectionViewController new];
    hpp.assetResult = [assetsFetchResult copy];
    hpp.titleText = assetCollection.localizedTitle;
    [self.navigationController pushViewController:hpp animated:YES];
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
