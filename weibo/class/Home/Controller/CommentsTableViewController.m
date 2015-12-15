//
//  CommentsTableViewController.m
//  weibo
//
//  Created by happy on 15/12/11.
//  Copyright © 2015年 happy. All rights reserved.
//

#import "CommentsTableViewController.h"
#import "AFNetworking.h"
#import "Account.h"
#import "AccountTool.h"
#import "Comment.h"

@interface CommentsTableViewController ()

@property (nonatomic)NSArray *comments;

@end

@implementation CommentsTableViewController

- (instancetype)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        self.title = @"评论";
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [self requestComments];
    
}

- (void)requestComments {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    Account *account = [AccountTool account];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"id"] = self.statusID;
    
    [manager GET:@"https://api.weibo.com/2/comments/show.json" parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
       
        NSLog(@"%@", responseObject);
        self.comments = [Comment arrayOfModelsFromDictionaries:responseObject[@"comments"]];
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.comments.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    Comment *comment = self.comments[indexPath.row];
    cell.textLabel.text = comment.text;
    
    return cell;
}

@end
