//
//  ALStickerViewController.m
//  alphasticker
//
//  Created by beyond on 2020/4/20.
//  Copyright © 2020 cn18x. All rights reserved.
//

#import "ALStickerViewController.h"
#import "ALCollectionViewCell.h"

#define k_al_Color(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define k_al_ScreenBounds [UIScreen mainScreen].bounds
#define k_al_ScreenWidth k_al_ScreenBounds.size.width
#define k_al_ScreenHeight k_al_ScreenBounds.size.height

@interface ALStickerViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>
{
    UICollectionView *_al_collectionView;
}

@end

@implementation ALStickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addALHeaderView];
    [self addALcollectionView];
}
- (void)addALHeaderView
{
    UIView *al_headerView = [[UIView alloc]init];
    al_headerView.backgroundColor = [UIColor clearColor];
    
    UIView *al_bgView =  [[UIView alloc]init];
    al_bgView.backgroundColor = k_al_Color(18, 139, 191);
    al_bgView.frame = CGRectMake(0, 0, k_al_ScreenWidth, 65);
    
    [al_headerView addSubview:al_bgView];
    al_headerView.frame = CGRectMake(0, 0, k_al_ScreenWidth, 65);
    [self.view addSubview:al_headerView];

    UILabel *al_titleLable = [[UILabel alloc]init];
    al_titleLable.text = @"alpha sticker";
    al_titleLable.font = [UIFont boldSystemFontOfSize:24.0];
    al_titleLable.textAlignment = NSTextAlignmentCenter;
    al_titleLable.textColor = k_al_Color(255, 255, 255);
    al_titleLable.backgroundColor = [UIColor clearColor];
    al_titleLable.frame = CGRectMake(40, 20, k_al_ScreenWidth - 80, 45);
    [al_headerView addSubview:al_titleLable];
}
- (void)addALcollectionView
{
    UICollectionViewFlowLayout *al_layout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat itemWidth = (k_al_ScreenWidth - 4*10) / 3;
    al_layout.itemSize = CGSizeMake(itemWidth, itemWidth);
    al_layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    
    UICollectionView *al_collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 65, k_al_ScreenWidth, k_al_ScreenHeight - 65) collectionViewLayout:al_layout];
    [al_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([ALCollectionViewCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"ALCollectionViewCell"];
    al_collectionView.dataSource = self;
    al_collectionView.delegate = self;
    al_collectionView.backgroundColor = [UIColor whiteColor];
    _al_collectionView = al_collectionView;
    
    [self.view addSubview:_al_collectionView];
}
#pragma mark 代理方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 37;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ALCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ALCollectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    NSString *imgName = [NSString stringWithFormat:@"alpha%ld.png",indexPath.row+1];
    cell.xib_al_imgView.image = [UIImage imageNamed:imgName];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIImage *imageToShare = [UIImage imageNamed:[NSString stringWithFormat:@"alpha%ld.png",indexPath.row+1]];
    NSArray *activityItems = [NSArray arrayWithObjects:imageToShare, nil];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:activityItems applicationActivities:nil];
    [self presentViewController:activityVC animated:YES completion:nil];
}
@end
