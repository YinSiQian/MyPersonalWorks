//
//  YSQLoginViewController.m
//  MyTravel
//
//  Created by ysq on 16/5/16.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQLoginViewController.h"
#import "YSQRegisterViewController.h"
#import "YSQUserDAO.h"

@interface YSQLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *secrect;

@end

@implementation YSQLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBar.hidden = YES;
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    // 设置富文本对象的颜色
    attributes[NSForegroundColorAttributeName] = [UIColor whiteColor];
    // 设置UITextField的占位文字
    self.username.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"输入手机号" attributes:attributes];
    self.secrect.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"输入密码" attributes:attributes];
    self.username.tintColor = [UIColor whiteColor];
    self.secrect.tintColor = [UIColor whiteColor];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)close {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)userRegister {
    YSQRegisterViewController *registerVC = [[YSQRegisterViewController alloc]init];
    [self.navigationController pushViewController:registerVC animated:YES];
}


- (IBAction)QQLogin {
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ];
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        //          获取微博用户名、uid、token等
        if (response.responseCode == UMSResponseCodeSuccess) {
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:snsPlatform.platformName];
            YSQUserDAO *user = [YSQUserDAO shared];
            user.username = snsAccount.userName;
            user.ID = [NSNumber numberWithString:snsAccount.usid];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self dismissViewControllerAnimated:YES completion:nil];
            });
        }});
}

- (IBAction)sinaWeiboLogin {
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        //          获取微博用户名、uid、token等
        if (response.responseCode == UMSResponseCodeSuccess) {
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:snsPlatform.platformName];
            YSQUserDAO *user = [YSQUserDAO shared];
            user.username = snsAccount.userName;
            user.ID = [NSNumber numberWithString:snsAccount.usid];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self dismissViewControllerAnimated:YES completion:nil];
            });
        }});
    
}

- (IBAction)login {
    NSString *url = [NSString stringWithFormat:@"http://localhost:63342/htdocs/YSQTravelAPI/userLogin.php?account=%@&password=%@",self.username.text,self.secrect.text];
    
    [NetWorkManager getDataWithURL:url success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        if (responseObject[@"success"]) {
            [SQProgressHUD showSuccessToView:self.view];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self dismissViewControllerAnimated:YES completion:nil];
            });
        } else {
            [SQProgressHUD showFailToView:self.view message:@"未知错误" shake:YES];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];

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
