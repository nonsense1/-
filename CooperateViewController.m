//
//  CooperateViewController.m
//  frameTest
//
//  Created by 蔡晓宇 on 16/7/22.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "CooperateViewController.h"
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"
#import "FirstDViewController.h"
#import "MBProgressHUD.h"
#import "ShangjiaViewController.h"
#define URLL @"http://ios.lsxfpt.com/app/linkmobile/appstoreadd.html"


@interface CooperateViewController (){
      NSMutableArray *namearray;
      NSMutableArray *urlarray;
    NSMutableArray *imagearray;
    NSString *imageUrl;
    UIScrollView *Sview;
}

@end

@implementation CooperateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    namearray = [NSMutableArray array];
    urlarray = [NSMutableArray array];
    imagearray = [NSMutableArray array];
    // Do any additional setup after loading the view.
    self.view.frame= CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    Sview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:Sview];
    Sview.backgroundColor = [UIColor whiteColor];
    
    Sview.scrollEnabled =YES;
    Sview.contentSize = CGSizeMake(0, self.view.frame.size.height+300);
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:URLL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",dic);
        imageUrl = [dic objectForKey:@"img_url"];
        
        NSArray *listArray = [dic objectForKey:@"list"];
        for (NSDictionary *dicc in listArray) {
            NSString *name = [dicc objectForKey:@"name"];
            NSString *url = [dicc objectForKey:@"url"];
            [namearray addObject:name];
            [urlarray addObject:url];
        }
       
        [self creatUI];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}

-(void)creatUI{
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *lb = [[UILabel alloc]initWithFrame:CGRectMake(100, 10, self.view.frame.size.width-200, 100)];
    [Sview addSubview:lb];
    lb.text = @"合作加盟";
    lb.textAlignment = NSTextAlignmentCenter;
    lb.font = [UIFont systemFontOfSize:25];
    
    UIImageView * image  =[[UIImageView alloc]initWithFrame:CGRectMake(10, 110, self.view.frame.size.width-20, 600)];
    [Sview addSubview:image];
    NSLog(@"%@",imageUrl);
    [image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://ios.lsxfpt.com%@",imageUrl]]];
    NSLog(@"%@",namearray);
    for (int i=0; i<namearray.count; i++) {
        UILabel *lb = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-100, 700+70*i, 100, 50)];
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2, 700+70*i, 150, 50)];
        btn.tag =i;
        [Sview addSubview:lb];
        [Sview addSubview:btn];
        lb.text = namearray[i];
        lb.textColor = [UIColor blackColor];
        [btn setTitle:@"直接进入>>>" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}
-(void)btnClick:(UIButton *)btn{
    NSInteger i =btn.tag;
    
    
    
    
    ShangjiaViewController *first = [[ShangjiaViewController alloc]init];
    NSString *str = [NSString stringWithFormat:@"http://ios.lsxfpt.com%@",urlarray[i]];
    NSLog(@"%@",str);
    first.Web = str;
    
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"fanhui" style:UIBarButtonItemStyleBordered target:nil action:nil];
//    first.navigationItem.backBarButtonItem.title = @"fanhui";
    [self.navigationController pushViewController:first animated:YES];
    
    
    
    
    
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
