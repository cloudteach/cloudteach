//
//  MyViewController.m
//  CloudTeach
//
//  Created by tiny on 17/3/27.
//  Copyright © 2017年 tiny. All rights reserved.
//

#import "MyViewController.h"

#import "HPPForTableViewController.h"
#import "HPPForCollectionViewController.h"
#import "HPPNavigationController.h"
#import "QNTokenManager.h"

@interface MyViewController ()
@property (nonatomic,strong)UIImageView *imgvHead;
@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    [self getuserHead];
    
    [[NSNotificationCenter defaultCenter] removeObserver:@"didHeadChoosed"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didHeadChoosed:) name:@"didHeadChoosed" object:nil];
}

- (void)getuserHead {
    //查询ObjectId
    AVQuery *query = [AVQuery queryWithClassName:@"cloudteach_user"];
    [query whereKey:@"ct_username" equalTo:[EMClient sharedClient].currentUsername];
    [query getFirstObjectInBackgroundWithBlock:^(AVObject *object, NSError *error) {
        if(object) {
            NSString *url = object[@"ct_head"];
            [self.imgvHead sd_setImageWithURL:[NSURL URLWithString:url]];
        }
    }];
}

- (void)initUI {
    
    self.imgvHead.hidden = NO;
    
    UIButton *btnLogin = [UIButton buttonWithType:UIButtonTypeSystem];
    btnLogin.frame = CGRectMake(10, SCREEN_HEIGHT-64-60, SCREEN_WIDTH-20, 40);
    btnLogin.layer.cornerRadius = 5;
    btnLogin.layer.borderColor = HEX_RGB(0x000000).CGColor;
    btnLogin.layer.borderWidth = 1;
    [btnLogin setTitleColor:HEX_RGB(0x000000) forState:UIControlStateNormal];
    [btnLogin setTitle:@"退出登录" forState:UIControlStateNormal];
    [btnLogin addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnLogin];
}

- (UIImageView *)imgvHead {
    if(!_imgvHead) {
        _imgvHead = [UIImageView new];
        _imgvHead.frame = CGRectMake((SCREEN_WIDTH-60)/2, 74, 60, 60);
        _imgvHead.userInteractionEnabled = YES;
        _imgvHead.backgroundColor = [UIColor lightGrayColor];
        _imgvHead.layer.cornerRadius = _imgvHead.width/2;
        _imgvHead.layer.masksToBounds = YES;
        [self.view addSubview:_imgvHead];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(0, 0, _imgvHead.width, _imgvHead.height);
        [button addTarget:self action:@selector(changeHead) forControlEvents:UIControlEventTouchUpInside];
        [_imgvHead addSubview:button];
    }
    return _imgvHead;
}

- (void)changeHead {
    //set up fetch options, mediaType is image.
    
    NSMutableArray <PHAssetCollection *>*marrAllAlbums = [NSMutableArray array];
    
    PHFetchResult *smartAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    
    for(PHAssetCollection *assetCollection in smartAlbums) {
        [marrAllAlbums addObject:assetCollection];
    }
    
    PHFetchResult *otherAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    
    for(PHAssetCollection *assetCollection in otherAlbums) {
        [marrAllAlbums addObject:assetCollection];
    }
    
    //    PHFetchResult *momentAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeMoment subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    //
    //    for(PHAssetCollection *assetCollection in momentAlbums) {
    //        [marrAllAlbums addObject:assetCollection];
    //    }
    
    PHFetchResult *allAlbums = [(PHFetchResult *)marrAllAlbums copy];
    
    PHFetchOptions *options = [[PHFetchOptions alloc] init];
    options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
    options.predicate = [NSPredicate predicateWithFormat:@"mediaType = %d",PHAssetMediaTypeImage];
    
    NSMutableArray <PHAssetCollection *>*marrSmartAlbums = [NSMutableArray array];
    
    HPPForCollectionViewController *collection = [HPPForCollectionViewController new];
    
    NSMutableArray *marrCollection = [NSMutableArray array];
    NSMutableArray *marrResult = [NSMutableArray array];
    
    for(PHAssetCollection *assetCollection in allAlbums) {
        PHFetchResult *assetsFetchResult = [PHAsset fetchAssetsInAssetCollection:assetCollection options:options];
        
        if(assetsFetchResult.count) {
            
            if(marrCollection.count == 0 && marrResult.count == 0) {
                [marrCollection addObject:assetCollection];
                [marrResult addObject:assetsFetchResult];
            }else{
                
                if(assetsFetchResult.count > ((PHFetchResult *)marrResult.firstObject).count) {
                    [marrCollection insertObject:assetCollection atIndex:0];
                    [marrResult insertObject:assetsFetchResult atIndex:0];
                }else{
                    [marrCollection addObject:assetCollection];
                    [marrResult addObject:assetsFetchResult];
                }
            }
            
        }
    }
    
    for(PHAssetCollection *collection in marrCollection) {
        [marrSmartAlbums addObject:[collection copy]];
    }
    
    if(0 == marrSmartAlbums.count) {
        [self showTip:@"相册初始化中..."];
        return;
    }
    
    HPPForTableViewController *tableView = [HPPForTableViewController new];
    tableView.fetchResult = [marrSmartAlbums copy];
    
    HPPNavigationController *nav = [[HPPNavigationController alloc] initWithRootViewController:tableView];
    
    collection.assetResult = (PHFetchResult *)marrResult.firstObject;
    collection.titleText = ((PHAssetCollection *)[marrCollection.firstObject copy]).localizedTitle;
    
    NSMutableArray *marrRoot = [NSMutableArray arrayWithArray:nav.viewControllers];
    [marrRoot addObject:collection];
    nav.viewControllers = [NSArray arrayWithArray:marrRoot];
    
    [self presentViewController:nav animated:YES completion:^{
        
    }];
}

- (void)logout {
    [[EMClient sharedClient] logout:YES completion:^(EMError *aError) {
        if(aError) {
            [self showError:[NSString stringWithFormat:@"%@",aError]];
        }else{
            [self initRootViewController];
            [self showSuccess:@"退出登录成功"];
        }
    }];
}

- (void)didHeadChoosed:(NSNotification *)userInfo {
    NSDictionary *dicHead = userInfo.object;
    UIImage *image = dicHead[@"head"];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        self.imgvHead.image = image;
        [self uploadFile];
    });
}

- (void)uploadFile {
    NSString *token = [QNTokenManager token];
    NSData *data = UIImagePNGRepresentation(self.imgvHead.image);
    QNUploadManager *manager = [QNUploadManager new];
    [manager putData:data key:nil token:token complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
        NSString *url = [NSString stringWithFormat:@"%@/%@",QiNiu_URL,resp[@"key"]];
        NSLog(@"url----:%@",url);
        
        //查询ObjectId
        AVQuery *query = [AVQuery queryWithClassName:@"cloudteach_user"];
        [query whereKey:@"ct_username" equalTo:[EMClient sharedClient].currentUsername];
        [query getFirstObjectInBackgroundWithBlock:^(AVObject *object, NSError *error) {
            if(object) {
                NSString *objectId = object.objectId;
                
//                NSString *sql = @"update cloudteach_user set ct_head='http://onmv3v70a.bkt.clouddn.com/FtG-GvBc_rJnmVK6qfpNUlT871oz' where objectId='58eae48561ff4b006b568429'";
                
                NSString *sql = [NSString stringWithFormat:@"update cloudteach_user set ct_head='%@' where objectId='%@'",url,objectId];
                
                [AVQuery doCloudQueryInBackgroundWithCQL:sql callback:^(AVCloudQueryResult *result, NSError *error) {
                    NSLog(@"");
                }];
            }
        }];
        
    } option:nil];
}

- (void)initRootViewController {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"initRootViewController" object:nil];
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
