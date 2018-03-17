//
//  ChannelViewController.m
//  网易新闻客户端实践
//
//  Created by 杨金发 on 2017/2/20.
//  Copyright © 2017年 杨金发. All rights reserved.
//

#import "ChannelViewController.h"
#import "ChannelCollectionViewCell.h"
#import "ChannelCollectionReusableView.h"

#import "Pch.pch"

#define itemSize_Height 30

#define itemSize_Width 60

#define Angle2Radian(angle) ((angle) / 180.0 * M_PI)

static NSString*channelID=@"ChannelCollectionViewCell";
static NSString*reusableViewID=@"ChannelCollectionReusableView";
//定义 cell是否是编辑状态的枚举
typedef NS_ENUM(NSInteger,cellStatus)//(枚举类型，枚举名称)
{
    cellStatuEdite=0,//编辑状态
    cellStatuFinish  //完成状态
    
};

@interface ChannelViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>


{
    UICollectionView*_collection;
    UICollectionViewFlowLayout*_layout;
    
    NSMutableArray*_channelArray;//装载我的频道的数据
    NSMutableArray *_tuijianArray;//装载推荐频道的数据

    cellStatus cellEditeStatu;//记录编辑状态
    
    
    
}
//

@end

@implementation ChannelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置背景色
    self.view.backgroundColor=[UIColor colorWithRed:249/255.f green:249/255.f blue:249/255.f alpha:1.0];
   //设置返回按钮
    [self setCancelBtn];
    //加载数据
    [self loadData];
    
    //默认设置初始cell的编辑状态为 未编辑即完成状态
    cellEditeStatu=cellStatuFinish;
    
    //创建集合视图
    [self creatCollection];
    
    
    // Do any additional setup after loading the view.
}
#pragma mark+++设置返回取消按钮+++++
-(void)setCancelBtn
{
    UIButton*cancelBtn=[[UIButton alloc]initWithFrame:CGRectMake(ks_width-60, 20, 60, 30)];
    [cancelBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelBtn];

}
#pragma mark+++设置返回取消按钮的点击方法+++
-(void)cancelBtnAction:(UIButton*)sender
{
    [_bacreFreshDelegate backToRefresh];

    [self dismissViewControllerAnimated:YES completion:nil];
    
}
#pragma mark+++加载数据+++++
-(void)loadData
{
    NSArray*array=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString*path=[array[0] stringByAppendingPathComponent:@"channel.plist"];
    _channelArray=[NSMutableArray arrayWithContentsOfFile:path];
    
    NSString*tuijianPath=[array[0] stringByAppendingPathComponent:@"tuijian.plist"];
    _tuijianArray=[NSMutableArray arrayWithContentsOfFile:tuijianPath];
    if (_tuijianArray.count==0||_tuijianArray==nil)
    {
        
        _tuijianArray=[NSMutableArray arrayWithArray:@[@"娱乐",@"健康",@"旅游",@"历史",@"时尚",@"闺房",@"游戏",@"互联网",@"干货",@"教育",@"育儿",@"奇闻",@"美食",@"文玩",@"星座",@"动漫",@"股票",@"NBA",@"家居",@"留学",@"美容",@"数码"]];
        [_tuijianArray writeToFile:tuijianPath atomically:YES];
        
   }
    
    
}
#pragma mark+++ 创建并初始化collectionView +++++
-(void)creatCollection
{
    _layout=[[UICollectionViewFlowLayout alloc]init];
    _layout.itemSize=CGSizeMake(itemSize_Width, itemSize_Height);
    _layout.minimumLineSpacing=10;
    _layout.minimumInteritemSpacing=10;
    _layout.sectionInset=UIEdgeInsetsMake(10, 10, 10, 10);
    _collection=[[UICollectionView alloc]initWithFrame:CGRectMake(0, navigation_height+statuBar_height, ks_width, ks_height-navigation_height-statuBar_height) collectionViewLayout:_layout];
    _collection.delegate=self;
    _collection.dataSource=self;
    _collection.backgroundColor=[UIColor grayColor];
    
    [_collection registerNib:[UINib nibWithNibName:@"ChannelCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:channelID];
    
    [_collection registerNib:[UINib nibWithNibName:@"ChannelCollectionReusableView" bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reusableViewID];
    
    [_layout setHeaderReferenceSize:CGSizeMake(ks_width, 50)];
    
    
    [self.view addSubview:_collection];

}
#pragma mark+++设置collectionView 的区块数++++++
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}
#pragma mark++++  设置每个区块的单元格的个数 ++++++++
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{

    if (section==0)
    {
        return _channelArray.count;
        
    }
    else
    {
        return _tuijianArray.count;
    }

}
#pragma mark++ 设置单元格 +++
-( __kindof UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    ChannelCollectionViewCell*channelCell=[collectionView dequeueReusableCellWithReuseIdentifier:channelID forIndexPath:indexPath];
    
    if (cellEditeStatu==cellStatuFinish)//未编辑状态
    {
        channelCell.cannelImage.hidden=YES;// 隐藏编辑符号
        
        if (indexPath.section==0)//第一个区块
        {
            channelCell.textLb.text=_channelArray[indexPath.item];
        }
        else//第二个区块
        {
            channelCell.textLb.text=_tuijianArray[indexPath.item];
        }

    }
    else  if (cellEditeStatu==cellStatuEdite)//编辑状态
    {
        if (indexPath.section==0)//第一个区块
        {
            channelCell.textLb.text=_channelArray[indexPath.item];
            channelCell.cannelImage.hidden=NO;//不隐藏编辑符号
        }
        else  //第二个区块
        {
            channelCell.textLb.text=_tuijianArray[indexPath.item];
            channelCell.cannelImage.hidden=YES;
            
        }
        
    }
    return channelCell;
    
}
#pragma mark++  设置单元格的点击事件 +++
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    ChannelCollectionViewCell*channelCell=(ChannelCollectionViewCell*)[_collection cellForItemAtIndexPath:indexPath];
    
    
    
    if (cellEditeStatu==cellStatuEdite)//编辑状态
    {
        if (indexPath.section==0)//第一个区块
        {

            //获取当前选择的单元格的内容
            NSString*cellText=channelCell.textLb.text;
            //在第一个区块删除当前所选择的单元格
            [_channelArray removeObject:cellText];
            //在第二个区块插入当前所删除的单元格
            [_tuijianArray insertObject:cellText atIndex:0];
            //将更改的数据保存到沙河中
            [self saveDataForEdited];
            //刷新数据
            [_collection reloadData];
        
        }
        else //第二个区块
        {
            NSString*cellText=channelCell.textLb.text;
            [_tuijianArray removeObject:cellText];
            [_channelArray addObject:cellText];
            [self saveDataForEdited];
            [_collection reloadData];
            
        }
    }
    else //非编辑状态
    {
        if (indexPath.section==0)//第一个区块
        {
            [_bacreFreshDelegate setChannelText:channelCell.textLb.text andIndex:indexPath.item];

            [self dismissViewControllerAnimated:YES completion:nil];
            
            
        }
        else //第二个区块
        {
            NSString*cellText=channelCell.textLb.text;
            [_tuijianArray removeObject:cellText];
            [_channelArray addObject:cellText];
            [self saveDataForEdited];
            [_collection reloadData];
        }
    }
    

}
#pragma mark++保存更改的数据到沙河+++
-(void)saveDataForEdited
{
    NSArray*array =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString*channelPlistPath=[array[0] stringByAppendingPathComponent:@"channel.plist"];
    NSString*tuijianPlistPath=[array[0] stringByAppendingPathComponent:@"tuijian.plist"];
    
    [_tuijianArray writeToFile:tuijianPlistPath atomically:YES];
    [_channelArray writeToFile:channelPlistPath atomically:YES];
    
}
#pragma mark +++ 设置collectionView的表头 +++++
-(UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
   //判断是表头还是表尾
    if ([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        ChannelCollectionReusableView*headerView=[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reusableViewID forIndexPath:indexPath];
        
        
        //分区
        if (indexPath.section==0)
        {
            headerView.editeBtn.hidden=NO;
            [headerView.editeBtn addTarget:self action:@selector(editeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            headerView.textLb.text=@"我的频道";
            
        }
        else
        {
            headerView.textLb.text=@"推荐频道";

            headerView.editeBtn.hidden=YES;
           
        }
        
        return headerView;
    }
    return nil;
}
#pragma mark+++ 设置编辑按钮的点击事件 +++
-(void)editeBtnAction:(UIButton *)sender
{
    
    
    //根据枚举值 做相应的更改
    if (cellEditeStatu==cellStatuFinish)//未编辑状态
    {
        cellEditeStatu= cellStatuEdite;//更改当前编辑状态
        
        [sender setTitle:@"编辑" forState:UIControlStateNormal];//更改编辑按钮显示的标题

        [_collection reloadSections:[NSIndexSet indexSetWithIndex:0]];//刷新数据
        
        //获取当前处于编辑状态的单元格
        
        
        NSInteger i=0;
        
        for (NSString*str in _channelArray)
        {
            
            ChannelCollectionViewCell*cell=(ChannelCollectionViewCell*)[_collection cellForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
            if ([str isEqualToString:cell.textLb.text])
            {
                CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
                anim.keyPath = @"transform.rotation";
                
                anim.values = @[@(Angle2Radian(-5)), @(Angle2Radian(5)), @(Angle2Radian(-5))];
                anim.duration = 0.25;
                
                // 动画次数设置为最大
                anim.repeatCount = MAXFLOAT;
                // 保持动画执行完毕后的状态
                anim.removedOnCompletion = YES;
                anim.fillMode = kCAFillModeForwards;
                
                [cell.layer addAnimation:anim forKey:@"shake"];
            }
            

            i++;
        }
        
        
    }
    else if(cellEditeStatu==cellStatuEdite)
    {
        cellEditeStatu=cellStatuFinish;

        
        [sender setTitle:@"完成" forState:UIControlStateNormal];
        
        [_collection reloadSections:[NSIndexSet indexSetWithIndex:0]];

    }
    
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
