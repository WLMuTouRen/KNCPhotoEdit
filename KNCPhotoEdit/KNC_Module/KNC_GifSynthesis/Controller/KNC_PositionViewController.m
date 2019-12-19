//
//  KNC_PositionViewController.m
//  PSLongFigure
//
//  Created by apple on 2019/12/16.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "KNC_PositionViewController.h"
#import "KNC_AddImageTableViewCell.h"

static NSString * const PositionCellID = @"PositionCell";

@interface KNC_PositionViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)NSMutableArray *imageArr;

@property(nonatomic,strong)UITableView *editTable;

@end

@implementation KNC_PositionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = KNC_RGBColor(32, 32, 35);
    
    self.title = @"顺序调整";
    
    self.navigationController.navigationBar.barTintColor = KNC_RGBColor(0, 0, 0);
    
    [self.view addSubview:self.editTable];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    self.newImageArray(self.imageArr);
}

-(void)setOriginalOrderImageArray:(NSMutableArray *)imgArr{
    self.imageArr = [[NSMutableArray alloc]initWithArray:imgArr];
    [self.editTable reloadData];
}

- (UITableView *)editTable{
    if (!_editTable) {
        _editTable = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _editTable.delegate = self;
        _editTable.dataSource = self;
//        _editTable.backgroundColor = KNC_RGBColor(32, 32, 35);
        _editTable.contentInset = UIEdgeInsetsMake(20, 0, KNC_TabMustAdd, 0);
        _editTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _editTable.editing = YES;
        [_editTable registerClass:[KNC_AddImageTableViewCell class] forCellReuseIdentifier:PositionCellID];
    }
    return _editTable;
}

#pragma mark --UITableViewDelegate&&DataSource --
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.imageArr.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KNC_AddImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PositionCellID forIndexPath:indexPath];
    if(cell == nil){
        cell = [[KNC_AddImageTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:PositionCellID];
    }
    cell.psImageView.image = self.imageArr[indexPath.row];
    cell.psImageView.frame = CGRectMake(KNC_SCREEN_W*0.1, 5, KNC_SCREEN_W*0.8, 80);
    tableView.rowHeight = 90;
//    cell.backgroundColor = KNC_RGBColor(32, 32, 35);
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleNone;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    UIImage *image = self.imageArr[sourceIndexPath.row];
    [self.imageArr removeObjectAtIndex:sourceIndexPath.row];
    [self.imageArr insertObject:image atIndex:destinationIndexPath.row];
}

@end
