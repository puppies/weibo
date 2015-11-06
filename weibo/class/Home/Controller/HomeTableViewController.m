//
//  MainTableViewController.m
//  weibo
//
//  Created by happy on 15/10/28.
//  Copyright © 2015年 happy. All rights reserved.
//

#import "HomeTableViewController.h"
#import "UIBarButtonItem+extension.h"
#import "AFNetworking.h"
#import "AccountTool.h"
#import "UIImageView+WebCache.h"
#import "TitleButton.h"
#import "UIView+extension.h"
#import "User.h"
#import "Status.h"
#import "StatusFrame.h"
#import "StatusTableViewCell.h"

@interface HomeTableViewController () <UIScrollViewDelegate>

@property (nonatomic)NSMutableArray *statusFrames;

@end

@implementation HomeTableViewController

- (NSMutableArray *)statusFrames {
    if (!_statusFrames) {
        _statusFrames = [NSMutableArray array];
    }
    return _statusFrames;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.tableView registerClass:[StatusTableViewCell class] forCellReuseIdentifier:@"statusCell"];
    
    self.tableView.backgroundColor = [UIColor colorWithRed:211 / 255.0 green:211 / 255.0 blue:211 / 255.0 alpha:1];
    
//    self.tableView.contentInset = UIEdgeInsetsMake(CellPadding, 0, 0, 0);
   
    [self setNavigationBar];
    [self setupNewRefresh];
    [self setupMoreRefresh];
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(setUnreadCount) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
}

- (void)setUnreadCount {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    Account *account = [AccountTool account];

    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"uid"] = [NSString stringWithFormat:@"%lld", account.uid];

    [manager GET:@"https://rm.api.weibo.com/2/remind/unread_count.json" parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {

        NSString *unreadCount = [responseObject[@"status"] description];
  
        self.tabBarItem.badgeValue = unreadCount.intValue == 0? nil : unreadCount;
     
        [UIApplication sharedApplication].applicationIconBadgeNumber = unreadCount.intValue;
        NSLog(@"%d", unreadCount.intValue);
        
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"%@", error);

    }];

}

- (void)setupNewRefresh {
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refreshForNew:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];
    /** 加载 最新20条微博 */
    [refreshControl beginRefreshing];
    [refreshControl sendActionsForControlEvents:UIControlEventValueChanged];
}

- (void)setupMoreRefresh {
    UIActivityIndicatorView *bottomRefresh = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    bottomRefresh.hidesWhenStopped = YES;
    bottomRefresh.height = 35;
    self.tableView.tableFooterView = bottomRefresh;
}

- (void)refreshForNew:(UIRefreshControl *)refreshControl {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    Account *account = [AccountTool account];
    StatusFrame *firstFrame = [self.statusFrames firstObject];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    if (firstFrame) {
        params[@"since_id"] = firstFrame.status.idstr;
    }
    
    [manager GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
//        for (NSDictionary *dic in responseObject[@"statuses"]) {
//            Status *status = [Status statusWithDictionary:dic];
//            [self.statuses addObject:status];
//        }
        NSLog(@"%@", responseObject);
        NSArray *newStatuses = [Status arrayOfModelsFromDictionaries:responseObject[@"statuses"]];

        NSArray *newFrames = [StatusFrame framesWithStatuses:newStatuses];
        
        NSRange range = NSMakeRange(0, newFrames.count);
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.statusFrames insertObjects:newFrames atIndexes:indexSet];
        
        [self.tableView reloadData];
        
        [refreshControl endRefreshing];
        [self showNewstatusNotification:newFrames.count];
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"%@", error);
        [refreshControl endRefreshing];
    }];
}

- (void)showNewstatusNotification:(unsigned long)count {
    
    /** clean unread count*/
    self.tabBarItem.badgeValue = nil;
    
    UILabel *notifyLabel = [[UILabel alloc] init];
    notifyLabel.text = [NSString stringWithFormat:@"有%lu条新微博", count];
    notifyLabel.textAlignment = NSTextAlignmentCenter;
    notifyLabel.width = self.tableView.width;
    notifyLabel.height = 20;
    
//    notifyLabel.backgroundColor = [UIColor orangeColor];
    notifyLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    //        [self.navigationController.view addSubview:notifyLabel];
    
    [self.navigationController.view insertSubview:notifyLabel belowSubview:self.navigationController.navigationBar];
    
//    notifyLabel.alpha = 0.0;
    notifyLabel.y = 64 - notifyLabel.height;
    
    [UIView animateWithDuration:1.0 animations:^{
//        notifyLabel.alpha = 1.0;
//        notifyLabel.y = 64;
        notifyLabel.transform = CGAffineTransformMakeTranslation(0, notifyLabel.height);
    } completion:^(BOOL finished) {
        //            [UIView animateWithDuration:3.0 animations:^{
        //                notifyLabel.alpha = 0.0;
        //                notifyLabel.y = -20;
        //            }];
        [UIView animateWithDuration:1.0 delay:1.5 options:UIViewAnimationOptionCurveLinear animations:^{
//            notifyLabel.alpha = 0.0;
//            notifyLabel.y = 64-20;
            notifyLabel.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [notifyLabel removeFromSuperview];
        }];
    }];

}

- (void)setNavigationBar {
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(friendsearch) image:@"navigationbar_friendsearch" highlightedImage:@"navigationbar_friendsearch_highlighted"];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(pop) image:@"navigationbar_pop" highlightedImage:@"navigationbar_pop_highlighted"];
    
    [self setTitleButton];
}

- (void)setTitleButton {
    
    TitleButton *titleButton = [[TitleButton alloc] init];
    [titleButton setTitle:@"首页" forState:UIControlStateNormal];
    [titleButton sizeToFit];
    [titleButton addTarget:self action:@selector(titleClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleButton;
}

- (void)titleClicked:(UIButton *)button {
    button.selected = !button.isSelected;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.statusFrames.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    StatusFrame *statusFrame = self.statusFrames[indexPath.row];
    return statusFrame.cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
     StatusTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"statusCell" forIndexPath:indexPath];
    
    // Configure the cell...
    StatusFrame *frame = self.statusFrames[indexPath.row];
    cell.statusFrame = frame;
//    Status *status = frame.status;
//    User *user = status.user;
//    cell.textLabel.text = status.text;
//    cell.textLabel.numberOfLines = 0;
//    
//    UIImage *placeholder = [UIImage imageNamed:@"avatar_default_small"];
//    NSURL *url = [NSURL URLWithString:user.profile_image_url];
//
//    [cell.imageView sd_setImageWithURL:url placeholderImage:placeholder];
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.navigationController pushViewController:[[UIViewController alloc] init] animated:YES];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)friendsearch {
    
}

- (void)pop {
    
}

- (void)refreshForMore {
    
    UIActivityIndicatorView *bottomRefresh = (UIActivityIndicatorView *)(self.tableView.tableFooterView);
    [bottomRefresh startAnimating];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    Account *account = [AccountTool account];
    StatusFrame *lastFrame = [self.statusFrames lastObject];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    if (lastFrame) {
//        NSLog(@"%@", lastSFrames.status.idstr);
        params[@"max_id"] = [NSString stringWithFormat:@"%lld", (lastFrame.status.idstr.longLongValue - 1)];
    }
    
    [manager GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        //        for (NSDictionary *dic in responseObject[@"statuses"]) {
        //            Status *status = [Status statusWithDictionary:dic];
        //            [self.statuses addObject:status];
        //        }
        NSLog(@"%@", responseObject);

        NSArray *moreStatuses = [Status arrayOfModelsFromDictionaries:responseObject[@"statuses"]];
        
        NSArray *moreFrames = [StatusFrame framesWithStatuses:moreStatuses];
        
        [self.statusFrames addObjectsFromArray:moreFrames];
        
        [self.tableView reloadData];
        
        [bottomRefresh stopAnimating];
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"%@", error);
        [bottomRefresh stopAnimating];
    }];

}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if ((self.statusFrames.count == 0) || !self.tableView.tableFooterView.isHidden) {
        return;
    }
    
    if (scrollView.contentOffset.y > scrollView.contentSize.height - scrollView.height + scrollView.contentInset.bottom - self.tableView.tableFooterView.height) {
        [self refreshForMore];
    }
}

@end
