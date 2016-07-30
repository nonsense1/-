//
//  VerifyPhoneNumViewController.m
//  frameTest
//
//  Created by 许争妍 on 16/7/12.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "VerifyPhoneNumViewController.h"
#import "AFNetworking.h"
@interface VerifyPhoneNumViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneNum;
@property (weak, nonatomic) IBOutlet UITextField *password;

@end

@implementation VerifyPhoneNumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)submit:(id)sender {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *myPhoneNum = self.phoneNum.text;
    NSString *myPassword = self.password.text;
    [manager POST:@"http://ios.lsxfpt.com/Appv2/Index/mobile.html"  parameters:@{@"mobile":myPhoneNum,@"password":myPassword} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers  error:nil];
        NSLog(@"%@",dic);
        NSString* status = [dic objectForKey:@"status"];
        if ([status isEqualToString:@"success"]) {
            NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
            [userdefault setObject:myPhoneNum forKey:@"mobile"];
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error");
    }];
    
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
