//
//  ViewController.m
//  GrowingTextView
//
//  Created by LandToSky on 1/31/17.
//  Copyright © 2017 LandToSky. All rights reserved.
//

#import "ViewController.h"
#import "CSGrowingTextView.h"

@interface ViewController () <CSGrowingTextViewDelegate>
{
    IBOutlet CSGrowingTextView *csTxtView;
    CGFloat keyboardHeight;
}



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self initData];
}

- (void)initUI
{
    csTxtView.delegate = self;
    
    [csTxtView.internalTextView setFont:[UIFont systemFontOfSize:14]];
    [csTxtView.internalTextView setTextColor:[UIColor blueColor]];
    
    [csTxtView.placeholderLabel setTextColor:[UIColor lightGrayColor]];
    [csTxtView.placeholderLabel setText:@"Please enter content"];
    
    [csTxtView setMinimumNumberOfLines:1];
    [csTxtView setMaximumNumberOfLines:5];
    
    [csTxtView setEnablesNewlineCharacter:NO];
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTappedScreen:)]];
    

}

- (void) initData
{
    
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillChangeFrameNotification
                                                  object:nil];
}


#pragma mark - Layout Changes

- (void)keyboardWillShow:(NSNotification *)notification {
    keyboardHeight = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    [self moveCommentInputViewToUp];
}


// moving CommentInputView and CommentTV scrolling to Bottom
-(void)moveCommentInputViewToUp{
    float y = self.view.frame.size.height - keyboardHeight - csTxtView.frame.size.height;
    [ UIView animateWithDuration:.2 animations:^{
        [self moveView:csTxtView withMoveX:0 withMoveY:y];
    }];
}

-(void)moveCommentInputViewToBottom{
    [self.view endEditing:YES];
    float y = self.view.frame.size.height - csTxtView.frame.size.height;
    [ UIView animateWithDuration:.2 animations:^{
        [self moveView:csTxtView withMoveX:0 withMoveY:y];
    }];
    
}


- (void)growingTextView:(CSGrowingTextView *)growingTextView willChangeHeight:(CGFloat)height {
    
    
}


- (void)moveView:(UIView *)view withMoveX:(float)x withMoveY:(float)y{
    CGRect frame = CGRectZero;
    frame = view.frame;
    frame.origin.x = x;
    frame.origin.y = y;
    view.frame = frame;
    
}

#pragma mark - View TapGesture
- (void) onTappedScreen:(UITapGestureRecognizer*) sender {
//    if (self.isLoadingBase) return;
    [self moveCommentInputViewToBottom];
    
    
}
@end
