//
//  NewsViewController.m
//  网易新闻客户端实践
//
//  Created by 杨金发 on 2017/2/16.
//  Copyright © 2017年 杨金发. All rights reserved.
//

#import "NewsViewController.h"

#import "ChannelViewController.h"


#import "Pch.pch"

#define channelBtn_Height 30
#define channelBtn_Width   60

@interface NewsViewController ()<BackRefreshDelegate>

{
    //装载plist数据
    NSDictionary*_rootdict;
    //分类数组
    NSMutableArray*_dataArray;
    //记录当前按钮
    UIButton*_currentBtn;
    
    UILabel*_line;
}
@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //加载plist数据
    [self loadPlistData];
    
    //初始化滚动视图
    [self loadScrollView];
    
    _line=[[UILabel alloc]initWithFrame:CGRectMake(0, channelBtn_Height-2, channelBtn_Width, 2)];
    _line.backgroundColor=[UIColor whiteColor];
    [_scrollView addSubview:_line];

    
    //根据分类数组  创建导航栏上的分类按钮
    [self creatChannelButton];
    
    //默认设置第一个按钮为 选中状态
    [self setSelectedAtIndex:0];
    
    
    // Do any additional setup after loading the view from its nib.
}
#pragma mark+++默认设置选中第N个按钮的方法+++
-(void)setSelectedAtIndex:(NSInteger)index
{
    NSInteger i=0;
    
    for (UIView*view in _scrollView.subviews)
    {
        if ([view isKindOfClass:[UIButton class]])
        {
            if (i==index)
            {
                UIButton*btn=(UIButton *)view;
                [self channelBtn_Action:btn];
                
                
            }
            else
            {
                
            }
            
            i++;
        }
        
        
    }
}
#pragma mark++实现代理方法+++
-(void)backToRefresh
{
    [self loadPlistData];

    [self creatChannelButton];
    
    [self setSelectedAtIndex:1];
    

    
}
-(void)setChannelText:(NSString *)text andIndex:(NSInteger)index
{
    [self loadPlistData];
    
    [self creatChannelButton];
    
    [self setSelectedAtIndex:index];

    
    
    
    
}
#pragma mark+++加载plist数据++++++
-(void)loadPlistData
{
  
    //plist 数据
    NSString*path=[[NSBundle mainBundle]pathForResource:@"ID.plist" ofType:nil];
    _rootdict=[NSDictionary dictionaryWithContentsOfFile:path];
    
    // 沙河
    NSArray*array=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    // 拼接路径
    NSString*dataPath=[array[0] stringByAppendingPathComponent:@"channel.plist"];
    //读取沙河文件
    _dataArray=[NSMutableArray arrayWithContentsOfFile:dataPath];
    
    //文件初始值为空时赋默认值
    if (_dataArray.count==0||_dataArray==nil)
    {
        _dataArray=[NSMutableArray arrayWithObjects:@"推荐",@"热点",@"社会",@"财经",@"体育",@"军事",@"科技",@"汽车",@"房产",@"国际", nil];
        [_dataArray writeToFile:dataPath atomically:YES];
    }
    
    
}
#pragma mark++初始化scrollView+++
-(void)loadScrollView
{
    _scrollView=[[UIScrollView alloc]init];

    [_scrollView setFrame:CGRectMake(0, 14,ks_width-padding*3,channelBtn_Height)];

    UIButton*editBtn=[[UIButton alloc]initWithFrame:CGRectMake(ks_width-padding*3, 14, padding*3, padding*3)];
    
    [editBtn  setTitle:@"十" forState:UIControlStateNormal];
    [editBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [editBtn addTarget:self action:@selector(editBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.navigationController.navigationBar addSubview:editBtn];
    
    //取消弹簧效果
    [self.scrollView setBounces:NO];
    //取消竖直滚动条
    [self.scrollView setShowsVerticalScrollIndicator:NO];
    //取消水平滚动条
    [self.scrollView setShowsHorizontalScrollIndicator:NO];
    
    //添加到导航栏上
    [self.navigationController.navigationBar addSubview:self.scrollView];
    self.navigationController.navigationBar.barTintColor=[UIColor redColor];
    
}
#pragma mark++  加号按钮的点击事件 ++++++
-(void)editBtnAction:(UIButton*)sender
{
    ChannelViewController*channel=[[ChannelViewController alloc]init];
    
    channel.bacreFreshDelegate=self;

    [self presentViewController:channel animated:YES completion:nil];
    
    
}
#pragma mark+++创建频道分类按钮++
-(void)creatChannelButton
{
    
    //移除scrollview上所有的按钮 下划线
    for (UIView*view in _scrollView.subviews)
    {
        if ([view isKindOfClass:[UIButton class]])
        {
            [view removeFromSuperview];
        }
        
//        if ([view isKindOfClass:[UILabel class]])
//        {
//            [view removeFromSuperview];
//            
//        }
        
        
    }
    
    
    

    //设置滚动视图的画幅
    [_scrollView setContentSize:CGSizeMake(_dataArray.count*channelBtn_Width, channelBtn_Height)];

    
    NSInteger i=0;
    
    for (NSString*str in _dataArray)
    {
        UIButton*btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(i*channelBtn_Width, 0, channelBtn_Width, channelBtn_Height);

        [btn setTitle:str forState:UIControlStateNormal];
        
        [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected ];
        //添加点击事件
        [btn addTarget:self action:@selector(channelBtn_Action:) forControlEvents:UIControlEventTouchUpInside];
        
        [_scrollView addSubview:btn];
        
        i++;
    }
    
    
    
}

#pragma mark+++频道分类按钮的点击事件++++
-(void)channelBtn_Action:(UIButton*)sender
{
//    [_currentBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    _currentBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    
    //取消上一个按钮
    _currentBtn.selected=NO;
    //记录当前按钮
    _currentBtn=sender;
    //选中当前按钮
    sender.selected=YES;
    
//    [sender.titleLabel setFont:[UIFont systemFontOfSize:20]];
    
    sender.titleLabel.font=[UIFont systemFontOfSize:20];
//    [sender setFont:[UIFont systemFontOfSize:20]];
    
    

    
//    //获取当前窗口
//    UIWindow*window=[[[UIApplication sharedApplication]delegate]window];
//    
//    //获取当前选中的按钮在窗口的坐标
//    CGRect _rect=[sender convertRect:sender.bounds toView:window];
    
    //判断当前滚动视图的画幅是否小于其可见的fram 小于或等于时点击按钮不移动
    if (_scrollView.contentSize.width<=_scrollView.frame.size.width)
    {
        
    }
    else//滚动视图的画幅大于其可见范围 按钮显示不全
    {
        // 计算按钮的偏移值  按钮在scrollview上相对于屏幕中间的位移
        CGFloat moveNum=sender.center.x-_scrollView.frame.size.width/2;
        
        if (moveNum<0) moveNum=0; //在窗口最左端不移动
        //计算按钮的最大可偏移量, 防止scrollview上最右端的按钮发生偏移
        CGFloat maxNum=_scrollView.contentSize.width-_scrollView.frame.size.width;
        
        if (moveNum>maxNum) //如果按钮的可移动范围如果超出最大值要调整
        {
            moveNum=maxNum;
            
        }
        
        [_scrollView setContentOffset:CGPointMake(moveNum, 0) animated:YES];
    }
    
    CGPoint linePoint=_line.center;
    linePoint.x=sender.center.x;
    _line.center=linePoint;

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
