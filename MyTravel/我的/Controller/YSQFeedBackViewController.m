//
//  YSQFeedBackViewController.m
//  MyTravel
//
//  Created by ysq on 16/5/30.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQFeedBackViewController.h"

@interface YSQFeedBackViewController ()<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *suggest;
@property (weak, nonatomic) IBOutlet UILabel *placeHolder;

@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UIButton *commitBtn;

@end

@implementation YSQFeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"意见反馈";
    self.commitBtn.layer.cornerRadius = 6;
    self.commitBtn.layer.masksToBounds = YES;
    self.suggest.delegate = self;
}


- (IBAction)commit {
    if (!self.suggest.text || !self.email.text) {
        [SQProgressHUD showFailToView:self.view message:@"请完善信息！" shake:NO];
        return;
    }
    if (![self validateEmail:self.email.text]) {
        UIAlertView *alter = [[UIAlertView alloc]initWithTitle:@"提示" message:@"邮箱地址不正确" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alter show];
    }
    NSString *urlcode = [self.suggest.text stringByURLEncode];
    NSString *urlString = [NSString stringWithFormat:@"http://localhost:63342/htdocs/YSQTravelAPI/advise.php?email=%@&adviseText=%@",self.email.text,urlcode];
    [NetWorkManager getDataWithURL:urlString success:^(id responseObject) {
        if ([responseObject[@"success"] isEqual:@1]) {
            [SQProgressHUD showSuccessToView:self.view];
        } else {
            [SQProgressHUD showFailToView:self.view message:@"提交失败！" shake:NO];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)textViewDidChange:(UITextView *)textView {
    if (self.suggest.text.length >= 1) {
        self.placeHolder.hidden = YES;
    } else {
        self.placeHolder.hidden = NO;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.suggest resignFirstResponder];
    [self.email resignFirstResponder];
}


- (BOOL)validateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
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
