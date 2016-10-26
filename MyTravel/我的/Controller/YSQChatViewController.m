//
//  YSQChatViewController.m
//  MyTravel
//
//  Created by ysq on 2016/10/14.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQChatViewController.h"
#import "YSQSocket.h"

@interface YSQChatViewController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UITextView *input;
@property (nonatomic, assign) CGFloat keyboardHeight;
@property (nonatomic, assign) BOOL isShow;
@end

@implementation YSQChatViewController

- (void)awakeFromNib {
    [super awakeFromNib];
    self.input.layer.cornerRadius = 4;
    self.input.layer.masksToBounds = YES;
    self.input.layer.shouldRasterize = YES;
}

#pragma mark --life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.input.delegate = self;
    [self connectToSocket];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [SQNotiCenter addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [SQNotiCenter addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)dealloc {
    [SQNotiCenter removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)connectToSocket {
    [[YSQSocket shareSocket] startConneted:@"192.168.1.32" onPort:8080];
    [[YSQSocket shareSocket] sendMessage:@"hello world"];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.input resignFirstResponder];
}

#pragma mark --response Function

- (void)keyboardWillShow:(NSNotification *)noti {
    self.isShow = YES;
    self.keyboardHeight = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    [self.view setNeedsUpdateConstraints];
    [self.view updateConstraintsIfNeeded];
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)keyboardDidHide:(NSNotification *)noti {
    self.isShow = NO;
    [self.view setNeedsUpdateConstraints];
    [self.view updateConstraintsIfNeeded];
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)updateViewConstraints {
    if (self.isShow) {
        [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.view).offset(-self.keyboardHeight);
        }];
    } else {
        [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.view).offset(0);
        }];
    }
    [super updateViewConstraints];
}

#pragma mark ---UITextViewDelegate

- (void)textViewDidEndEditing:(UITextView *)textView {
    NSLog(@"send");
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        NSLog(@"send");
        
        [self.input resignFirstResponder];

    }
    return YES;
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
