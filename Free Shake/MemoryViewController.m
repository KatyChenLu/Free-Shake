//
//  MemoryViewController.m
//  Free Shake
//
//  Created by qianfeng on 15/10/3.
//  Copyright (c) 2015年 WuRunTao. All rights reserved.
//

#import "PictureScanController.h"
#import "AudioViewController.h"
#import "ReadingViewController.h"
#import "MemoryViewController.h"
#import "RTUtil.h"
#import "WritingViewController.h"
#import "DetailViewController.h"

#define kYesAlertTag 800
#define kNoAlertTag 801

@interface MemoryViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    int fold[20];
}

@property (nonatomic) NSArray *classArray;

@property (nonatomic) UITableView *tableView;
@property (nonatomic) UIImageView *titleView;
//@property (nonatomic) UIButton *editBtn;
@property (nonatomic) UIView *editView;

@property (nonatomic) UIView *deleteView;

@property (nonatomic) NSMutableArray *dataArray;
@property (nonatomic) NSMutableArray *deleteArray;
@property (nonatomic) NSInteger flag;

@end

@implementation MemoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.dataArray = [NSMutableArray array];
    
    [self initData];
    
    [self addTableView];
    
    [self addEditView];
    
    [self addTitleView];
    
    [self addDeleteView];
}
- (NSMutableArray *)deleteArray{
    if (_deleteArray == nil) {
        _deleteArray = [NSMutableArray array];
    }
    return _deleteArray;
}
//初始化数据
- (void)initData{
    NSMutableArray *array = [[NoteManager sharedInstance]fetchNoteListByUserName:self.user.name];
    if (array.count == 0) {
        return;
    }
    for (NSInteger i = 0; i < array.count; i++) {
        NoteData *note1 = [array objectAtIndex:i];
        NSMutableArray *arr = [NSMutableArray array];
        [arr addObject:note1];
        if (array.count == 1) {
            [self.dataArray addObject:arr];
            return;
        }
        for (NSInteger j = i+1; j < array.count; j++) {
            NoteData *note2 = [array objectAtIndex:j];
            if ([note2.date isEqualToString:note1.date]) {
                [arr addObject:note2];
                [array removeObjectAtIndex:j];
                j--;
            }
        }
        [self.dataArray addObject:arr];
    }
}
//设置标签栏UI
- (void)addTitleView{
    self.titleView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 70)];
    _titleView.image = [UIImage imageNamed:@"title"];
    //_titleView.image = [RTUtil getRandomGradientImageByGradientType:upleftTolowRight size:_titleView.frame.size];
    [self.view addSubview:_titleView];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 50)];
    titleLabel.center = _titleView.center;
    titleLabel.text = @"独家记忆";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont boldSystemFontOfSize:25];
    [_titleView addSubview:titleLabel];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(290, 15, 60, 40);
    [button setBackgroundImage:[UIImage imageNamed:@"button"] forState:UIControlStateNormal];
    button.tintColor = [UIColor clearColor];
    button.layer.cornerRadius = 5;
    button.clipsToBounds = YES;
    [button addTarget:self action:@selector(showEditView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}
//展示下拉列表
- (void)showEditView{
    CGRect frame = self.editView.frame;
    if (self.editView.frame.origin.y == -51) {
        frame.origin.y += 121;
    }else{
        frame.origin.y -= 121;
    }
    [UIView animateWithDuration:0.5 animations:^{
        self.editView.frame = frame;
    }];
}
//添加下拉列表
- (void)addEditView{
    CGFloat editViewWidth = 150.0;
    CGFloat editViewHeight = 82.0;
    self.editView = [[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width-editViewWidth, 70-121, editViewWidth, editViewHeight)];
    [self.view addSubview:_editView];
    
    CGRect frame = _editView.bounds;
    [self addBtnWithFrame:frame selector:@selector(addNote) title:@"添加"];
    
    frame.origin.y += 39;
    [self addLineWithFrame:frame];

    frame.origin.y += 2;
    [self addBtnWithFrame:frame selector:@selector(deleteNote) title:@"删除"];
}
//添加事件
- (void)addNote{
    [self endEdit];
    WritingViewController *controller = [[WritingViewController alloc]init];
    controller.user = self.user;
    self.flag = 0;
    [controller setPassValueHandler:^(NoteData *note) {
        for (NSMutableArray *array in self.dataArray) {
            NoteData *noteData = array[0];
            if ([noteData.date isEqualToString:note.date]) {
                [array addObject:note];
                _flag ++;
            }
        }
        if (_flag == 0) {
            NSMutableArray *array = [NSMutableArray array];
            [array addObject:note];
            [self.dataArray addObject:array];
        }else{
            _flag = 0;
        }
        [self.tableView reloadData];
    }];
    [self presentViewController:controller animated:YES completion:nil];
}
//退出编辑
- (void)endEdit{
    CGRect frame = self.editView.frame;
    frame.origin.y -= 121;
    [UIView animateWithDuration:0.5 animations:^{
        self.editView.frame = frame;
    }];
}
- (void)addDeleteView{
    self.deleteView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 50)];
    
    UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    CGRect frame = _deleteView.bounds;
    frame.size.width /= 2.0;
    deleteBtn.frame = frame;
    deleteBtn.backgroundColor = [UIColor redColor];
    [deleteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    [deleteBtn addTarget:self action:@selector(confirmDelete) forControlEvents:UIControlEventTouchUpInside];
    [_deleteView addSubview:deleteBtn];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    frame.origin.x = frame.size.width;
    cancelBtn.frame = frame;
    cancelBtn.backgroundColor = [UIColor greenColor];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelDelete) forControlEvents:UIControlEventTouchUpInside];
    [_deleteView addSubview:cancelBtn];
    
    [self.view addSubview:_deleteView];
}
- (void)confirmDelete{
    [self showAlertWithTitle:@"确认删除?" tag:kYesAlertTag];
}
- (void)cancelDelete{
    [self showAlertWithTitle:@"取消删除?" tag:kNoAlertTag];
}
//弹出警告框
- (void)showAlertWithTitle:(NSString *)title tag:(NSInteger)tag{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:title message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    alert.tag = tag;
    alert.delegate = self;
    [alert show];
}
#pragma mark - <UIAlertViewDelegate>
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == alertView.firstOtherButtonIndex) {
        switch (alertView.tag) {
            case kYesAlertTag:
                [self delete];
                break;
            case kNoAlertTag:
                [self cancel];
                break;
            default:
                break;
        }
    }
}
- (void)delete{
    for (NSInteger i = 0; i < self.dataArray.count; i++) {
        NSMutableArray *mArr = self.dataArray[i];
        [mArr removeObjectsInArray:self.deleteArray];
    }
    [UIView animateWithDuration:0.25 animations:^{
        [self.tableView reloadData];
    }];
    
    NoteManager *manager = [NoteManager sharedInstance];
    for (NoteData *note in self.deleteArray) {
        [manager delete:note];
    }
    
    self.deleteArray = nil;
    [self.tableView setEditing:NO];
    [self deleteViewShow:NO];
}
- (void)cancel{
    [self.tableView setEditing:NO];
    [self deleteViewShow:NO];
}
//删除记录
- (void)deleteNote{
    [self.tableView setEditing:YES];
    [self endEdit];
    [self deleteViewShow:YES];
}
- (void)deleteViewShow:(BOOL)show{
    CGPoint center = self.deleteView.center;
    CGRect frame = self.tableView.frame;
    if (show) {
        center.y -= 50;
        frame.size.height -= 50;
    }else{
        center.y += 50;
        frame.size.height += 50;
    }
    [UIView animateWithDuration:0.5 animations:^{
        self.deleteView.center = center;
        self.tableView.frame = frame;
    }];
}
//模式化添加渐变色按钮
- (void)addBtnWithFrame:(CGRect)frame selector:(SEL)selector title:(NSString *)title{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    frame.size.height = 39;
    button.frame = frame;
    button.backgroundColor = [UIColor colorWithRed:0.447 green:0.651 blue:0.650 alpha:1.0];
    button.tintColor = [UIColor clearColor];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    [self.editView addSubview:button];
}
//添加间隔
- (void)addLineWithFrame:(CGRect)frame{
    frame.size.height = 2;
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    label.backgroundColor = [UIColor grayColor];
    [self.editView addSubview:label];
}
//添加TableView
- (void)addTableView{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height-70) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
}
#pragma mark - <UITableViewDataSource,UITableViewDelegate>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *array = self.dataArray[section];
    return fold[section] == 0 ? array.count : 0;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    NSArray *array = self.dataArray[indexPath.section];
    NoteData *note = array[indexPath.row];
    cell.textLabel.text = note.title;
    cell.detailTextLabel.text = note.time;
    cell.imageView.image = [UIImage imageNamed:note.mood];
    cell.accessoryView = [self getRightVIew];
    return cell;
}
- (UIView *)getRightVIew{
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"right"]];
    imageView.frame = CGRectMake(0, 0, 20, 20);
    return imageView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *bgView = [[UIView alloc]init];
    bgView.backgroundColor = [UIColor colorWithRed:0 green:0.463 blue:0.882 alpha:1.0];
    
    UIImageView *foldView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 7, 23, 23)];
    NSString *imageName = fold[section] == 0 ? @"fold":@"unfold";
    foldView.image = [UIImage imageNamed:imageName];
    [bgView addSubview:foldView];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(foldView.frame)+10, 5, 200, 30)];
    NSArray *array = self.dataArray[section];
    NoteData *note = array[0];
    titleLabel.text = note.date;
    titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [bgView addSubview:titleLabel];
    
    bgView.tag = 100+section;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapOnFoldView:)];
    [bgView addGestureRecognizer:tap];
    return bgView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1f;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    return view;
}
//点击队头折叠
- (void)tapOnFoldView:(UITapGestureRecognizer *)tap{
    NSInteger section = tap.view.tag - 100;
    fold[section] ^= 1;
    // 局部刷新
    NSIndexSet *set = [NSIndexSet indexSetWithIndex:section];
    [self.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationAutomatic];
}
// 设置编辑风格  
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert; // 多选模式
}
// 当选中某行时，把这行所对应的数据存放到要删除的数组_deleteArray中
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.tableView.editing) {
        NSArray *array = self.dataArray[indexPath.section];
        NoteData *note = array[indexPath.row];
        [self.deleteArray addObject:note];
    }else{
        NSArray *array = self.dataArray[indexPath.section];
        NoteData *note = array[indexPath.row];
        DetailViewController *controller = [[DetailViewController alloc]init];
        controller.note = note;
        [self presentViewController:controller animated:YES completion:nil];
    }
}
// 取消选中某行时，把这行所对应的数据从原来的_deleteArray中删除掉
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *array = self.dataArray[indexPath.section];
    NoteData *note = array[indexPath.row];
    [self.deleteArray removeObject:note];
}
// 摇一摇跳转界面
// 晃动结束
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    [self removeAllViews];
    
    self.classArray = @[[PictureScanController class],[AudioViewController class],[ReadingViewController class]];
    NSInteger index = arc4random()%3;
    Class cls = self.classArray[index];
    SuperViewController *controller = [[cls alloc]init];
    controller.user = self.user;
    [self.navigationController pushViewController:controller animated:YES];
}



@end


















