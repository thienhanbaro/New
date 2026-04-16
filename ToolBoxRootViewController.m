#import "ToolBoxRootViewController.h"

@implementation ToolBoxRootViewController {
    UITableView *_tableView;
    NSArray *_sections;
    NSArray *_options;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"OPTIMIZER PRO";
    self.view.backgroundColor = [UIColor blackColor];
    
    // Cấu hình Navigation Bar tối
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.translucent = NO;

    _sections = @[@"DEVICE INFO", @"GAMING PERFORMANCE", @"SYSTEM CLEANER"];
    _options = @[
        @[@"Model: iPhone", @"iOS: 16.0", @"CPU: 25%", @"RAM: 45%"],
        @[@"Unlock 60 FPS", @"Unlock 90 FPS", @"Unlock 120 FPS", @"GPU Turbo Boost", @"Ultra Graphics", @"Anti-Lag Mode"],
        @[@"Clear Cache", @"Deep Clean RAM", @"Fix Touch Latency", @"Optimize Network", @"Battery Calibrate", @"Delete Logs", @"Thermal Cooling", @"Fast Boot", @"DNS Flush", @"UI Speed Up"]
    ];

    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.backgroundColor = [UIColor blackColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorColor = [UIColor darkGrayColor];
    [self.view addSubview:_tableView];
}

// --- TABLEVIEW METHODS ---

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_options[section] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return _sections[section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
        cell.backgroundColor = [UIColor colorWithWhite:0.1 alpha:1.0];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.detailTextLabel.textColor = [UIColor cyanColor];
    }
    
    cell.textLabel.text = _options[indexPath.section][indexPath.row];
    cell.accessoryType = (indexPath.section == 0) ? UITableViewCellAccessoryNone : UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section > 0) {
        NSString *name = _options[indexPath.section][indexPath.row];
        [self showToast:[NSString stringWithFormat:@"%@: Active", name]];
    }
}

// --- DYNAMIC TOAST (Viên thuốc đen) ---
- (void)showToast:(NSString *)message {
    UIView *toast = [[UIView alloc] initWithFrame:CGRectMake(20, -100, self.view.frame.size.width - 40, 60)];
    toast.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.95];
    toast.layer.cornerRadius = 30;
    toast.clipsToBounds = YES;
    
    UILabel *label = [[UILabel alloc] initWithFrame:toast.bounds];
    label.text = message;
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:16];
    [toast addSubview:label];
    
    [self.view addSubview:toast];
    
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseOut animations:^{
        toast.frame = CGRectMake(20, 50, self.view.frame.size.width - 40, 60);
    } completion:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.5 animations:^{
            toast.alpha = 0;
            toast.frame = CGRectMake(20, -100, self.view.frame.size.width - 40, 60);
        } completion:^(BOOL finished) {
            [toast removeFromSuperview];
        }];
    });
}
@end
