//
//  YSQRegisterViewController.m
//  MyTravel
//
//  Created by ysq on 16/5/16.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQRegisterViewController.h"

@interface YSQRegisterViewController ()

@property (weak, nonatomic) IBOutlet UIButton *back;

@property (weak, nonatomic) IBOutlet UITextField *username;

@property (weak, nonatomic) IBOutlet UITextField *phoneNum;

@property (weak, nonatomic) IBOutlet UITextField *secrect;

@end

@implementation YSQRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.back.tintColor = [UIColor whiteColor];
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    // 设置富文本对象的颜色
    attributes[NSForegroundColorAttributeName] = [UIColor whiteColor];
    // 设置UITextField的占位文字
    self.username.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"输入用户名" attributes:attributes];
    self.secrect.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"输入密码" attributes:attributes];
    self.phoneNum.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"输入手机号码" attributes:attributes];
    self.username.tintColor = [UIColor whiteColor];
    self.secrect.tintColor = [UIColor whiteColor];
    self.phoneNum.tintColor = [UIColor whiteColor];

}

- (IBAction)leave:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)complection:(id)sender {
    if (![self isMobileNumber:self.phoneNum.text]) {
        [SQProgressHUD showFailToView:self.view message:@"手机号码错误" shake:YES];
        return;
    }
    if (!self.username.text ||!self.phoneNum.text ||!self.secrect.text) {
        [SQProgressHUD showFailToView:self.view message:@"请输入完整信息" shake:YES];
        return;
    }
    NSString *url = [NSString stringWithFormat:@"http://localhost:63342/htdocs/YSQTravelAPI/userRegister.php?username=%@&password=%@&account=%@",self.username.text,self.secrect.text,self.phoneNum.text];
    
    [NetWorkManager getDataWithURL:url success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        if ([responseObject[@"success"] isEqual:@1]) {
            [SQProgressHUD showSuccessToView:self.view];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        } else if ([responseObject[@"message"] isEqualToString:@"该账号已注册"]){
            [SQProgressHUD showFailToView:self.view message:@"该账号已注册！" shake:YES];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}
- (IBAction)showSecrect:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        self.secrect.secureTextEntry = NO;
    } else {
        self.secrect.secureTextEntry = YES;
    }

}

- (BOOL)isMobileNumber:(NSString *)mobileNum{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189,181(增加)
     */
    NSString * MOBIL = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,183,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[2378])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186,170,171
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|7[01]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189,181(增加)
     22         */
    NSString * CT = @"^1((33|53|8[019])[0-9]|349)\\d{7}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBIL];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum]
         || [regextestcm evaluateWithObject:mobileNum]
         || [regextestct evaluateWithObject:mobileNum]
         || [regextestcu evaluateWithObject:mobileNum])) {
        return YES;
    }
    return NO;
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
