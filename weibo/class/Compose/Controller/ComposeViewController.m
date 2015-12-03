//
//  ComposeViewController.m
//  weibo
//
//  Created by happy on 15/11/7.
//  Copyright © 2015年 happy. All rights reserved.
//

#import "ComposeViewController.h"
#import "UIView+extension.h"
#import "AccountTool.h"
#import "Account.h"
#import "InputTextView.h"
#import "AFNetworking.h"
#import "ToolBar.h"
#import "MBProgressHUD.h"
#import "ComposePicturesView.h"
#import "EmotionKeyboardView.h"

@interface ComposeViewController () <UITextViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, weak)InputTextView *textView;
@property (nonatomic, weak)ToolBar *keyboardToolBar;
@property (nonatomic, weak)ComposePicturesView *picturesView;
@property (nonatomic, strong)EmotionKeyboardView *emotionKeyboard;
@property (nonatomic)BOOL isSwitchingKeyboard;

@end

@implementation ComposeViewController

#pragma mark - lazy alloc

- (EmotionKeyboardView *)emotionKeyboard {
    if (!_emotionKeyboard) {
        _emotionKeyboard = [[EmotionKeyboardView alloc] init];
        
        _emotionKeyboard.width = self.view.width;
        _emotionKeyboard.height = 254;
        self.emotionKeyboard = _emotionKeyboard;
    }
    return _emotionKeyboard;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupNav];
    [self setupTextView];
    [self setupPicturesView];
    [self setupKeyBoardToolBar];
    

}

#pragma mark - view life circle

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [self.textView becomeFirstResponder];
    
    //    self.navigationItem.rightBarButtonItem.enabled = NO;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.textView becomeFirstResponder];
}

#pragma mark - setup method

- (void)setupKeyBoardToolBar {
    ToolBar *tb = [[ToolBar alloc] init];
    tb.width = self.view.width;
    tb.height = 44;
    tb.y = self.view.height - tb.height;
    
    [tb addButton:@"compose_camerabutton_background" highlightedImage:@"compose_camerabutton_background_highlighted" target:self action:@selector(cameraClicked)];
    [tb addButton:@"compose_toolbar_picture" highlightedImage:@"compose_toolbar_picture_highlighted" target:self action:@selector(pickAlbum)];
    [tb addButton:@"compose_mentionbutton_background" highlightedImage:@"compose_mentionbutton_background_highlighted" target:self action:@selector(mention)];
    [tb addButton:@"compose_trendbutton_background" highlightedImage:@"compose_trendbutton_background_highlighted" target:self action:@selector(trend)];
    [tb addButton:@"compose_emoticonbutton_background" highlightedImage:@"compose_emoticonbutton_background_highlighted" target:self action:@selector(pickEmoticon:)];
    
    [self.view addSubview:tb];
    self.keyboardToolBar = tb;
//    self.textView.inputAccessoryView = tb;
}

- (void)setupTextView {
    InputTextView *textView = [[InputTextView alloc] init];
    textView.frame = self.view.bounds;
    textView.placeholder = @"分享新鲜事......";
    textView.font = [UIFont systemFontOfSize:15];
    textView.delegate = self;
    [self.view addSubview:textView];
    self.textView = textView;
    
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:textView];
    [notificationCenter addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)setupNav {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(send)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.width = 100;
    titleLabel.height = 44;
    // 自动换行
    titleLabel.numberOfLines = 0;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    //    NSString *name = [AccountTool account].
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:@"发微博\n😄"];
    //    [attrStr addAttribute:<#(nonnull NSString *)#> value:<#(nonnull id)#> range:<#(NSRange)#>]
    titleLabel.attributedText = attrStr;
    self.navigationItem.titleView = titleLabel;
}

- (void)setupPicturesView {
    ComposePicturesView *pv = [[ComposePicturesView alloc] init];
    pv.y = 100;
    pv.width = self.view.width;
    pv.height = self.view.height;
    [self.textView addSubview:pv];
    self.picturesView = pv;
}

- (void)cancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)send {
    
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [AccountTool account].access_token;
    params[@"status"] = self.textView.text;
    
    UIImage *image = [self.picturesView.pictures firstObject];
    
    if (image) {
        [mgr POST:@"https://api.weibo.com/2/statuses/upload.json" parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
            [formData appendPartWithFileData:imageData name:@"pic" fileName:@"test.jpg" mimeType:@"image/jpeg"];
        } success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
            hud.labelText = @"发送成功";
            hud.mode = MBProgressHUDModeText;
            hud.removeFromSuperViewOnHide = YES;
            [hud hide:YES afterDelay:2];
        } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
            hud.labelText = @"发送失败";
            hud.detailsLabelText = [error localizedDescription];
            hud.mode = MBProgressHUDModeText;
            hud.userInteractionEnabled = NO;
            hud.removeFromSuperViewOnHide = YES;
            [hud hide:YES afterDelay:2];
        }];
    } else {
        [mgr POST:@"https://api.weibo.com/2/statuses/update.json" parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
            hud.labelText = @"发送成功";
            hud.mode = MBProgressHUDModeText;
            hud.removeFromSuperViewOnHide = YES;
            [hud hide:YES afterDelay:2];
            
        } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
            hud.labelText = @"发送失败";
            hud.detailsLabelText = [error localizedDescription];
            hud.mode = MBProgressHUDModeText;
            hud.userInteractionEnabled = NO;
            hud.removeFromSuperViewOnHide = YES;
            [hud hide:YES afterDelay:2];
            
        }];
    }
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)textDidChange {
    self.navigationItem.rightBarButtonItem.enabled = self.textView.hasText;
}

- (void)keyboardWillChangeFrame:(NSNotification *)notification {
    if (self.isSwitchingKeyboard) {
        return;
    }
    
    NSDictionary *info = notification.userInfo;
    double duration = [info[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect keyboardF = [info[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    [UIView animateWithDuration:duration animations:^{
        self.keyboardToolBar.y = keyboardF.origin.y - self.keyboardToolBar.height;
    }];
}


#pragma mark - UITextViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.textView endEditing:YES];
}

#pragma mark - toolbar buttons actions

- (void)cameraClicked {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    UIImagePickerController *imc = [[UIImagePickerController alloc] init];
    
    imc.sourceType = UIImagePickerControllerSourceTypeCamera;
    imc.delegate = self;
    
    [self presentViewController:imc animated:YES completion:nil];
}

- (void)pickAlbum {
    UIImagePickerController *imc = [[UIImagePickerController alloc] init];
    
    imc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imc.delegate = self;
    
    [self presentViewController:imc animated:YES completion:nil];
}

- (void)mention {
    
}

- (void)trend {
    
}

- (void)pickEmoticon:(UIButton *)button {
    
    if (self.textView.inputView) {  // switch to default keyboard
        self.textView.inputView = nil;
        [button setImage:[UIImage imageNamed:@"compose_emoticonbutton_background"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"compose_emoticonbutton_background_highlighted"] forState:UIControlStateHighlighted];

    } else {    // switch to emotion keyboard
        self.textView.inputView = self.emotionKeyboard;
        [button setImage:[UIImage imageNamed:@"compose_keyboardbutton_background"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"compose_keyboardbutton_background_highlighted"] forState:UIControlStateHighlighted];
    }
    self.isSwitchingKeyboard = YES;
    [self.textView resignFirstResponder];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self.textView becomeFirstResponder];
        self.isSwitchingKeyboard = NO;

    });
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    [self.picturesView addPicture:image];
}
@end
