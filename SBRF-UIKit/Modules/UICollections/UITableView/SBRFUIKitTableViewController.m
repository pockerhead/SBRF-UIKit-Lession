//
//  SBRFUIKitTableViewController.m
//  SBRF-UIKit
//
//  Created by Artem Balashov on 20/03/2019.
//  Copyright © 2019 pockerhead. All rights reserved.
//

#import "SBRFUIKitTableViewController.h"
#import "AnimalViewModel.h"
#import "LeftAlignedImageCell.h"
#import "RightAlignedImageCell.h"

@interface SBRFUIKitTableViewController () <UITableViewDelegate, UITableViewDataSource>
    
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray<AnimalViewModel *> *animals;
    
@end

@implementation SBRFUIKitTableViewController
    
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
    self.animals = [self getDataSource];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[RightAlignedImageCell class] forCellReuseIdentifier:NSStringFromClass([RightAlignedImageCell class])];
    [self.tableView registerClass:[LeftAlignedImageCell class] forCellReuseIdentifier:NSStringFromClass([LeftAlignedImageCell class])];
    self.navigationItem.title = @"UITableView";
}
    
- (void)viewDidLayoutSubviews
{
    self.tableView.frame = self.view.frame;
    [self.tableView layoutIfNeeded];
}
    
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    UITableViewCell<AnimalViewModelProtocol> *cell;
    if (indexPath.row % 2 == 0) {
        cell = [self.tableView dequeueReusableCellWithIdentifier:NSStringFromClass([RightAlignedImageCell class])];
    } else {
        cell = [self.tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LeftAlignedImageCell class])];
    }
    AnimalViewModel *animalViewModel = self.animals[indexPath.row];
    [cell configureWithModel:animalViewModel];
    return cell;
}
    
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.animals.count;
}

    
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
    
- (NSArray<AnimalViewModel *> *)getDataSource
{
    NSMutableArray<AnimalViewModel *> *arr = [NSMutableArray new];
    for (int i = 0; i < 50; i++) {
        [arr addObject:[[AnimalViewModel alloc] initWithName:@"Альпака" description:@"Домашнее парнокопытное животное, произошедшее от викуньи. Разводят в высокогорном поясе Южной Америки. На сегодняшний день там обитает около трёх миллионов альпака, большая часть из которых населяет Перу." andImage:[UIImage imageNamed:@"alpaka"]]];
        [arr addObject:[[AnimalViewModel alloc] initWithName:@"Обыкновенный бегемот" description:@"млекопитающее из отряда парнокопытных, подотряда свинообразных, семейства бегемотовых, единственный современный вид рода Hippopotamus." andImage:[UIImage imageNamed:@"hyppopotamus"]]];
    }
    return [arr copy];
}
    
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AnimalViewModel *selectedAnimal = self.animals[indexPath.row];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:selectedAnimal.animalName message:selectedAnimal.animalDescription preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:action];
    [self presentViewController:alertController animated:YES completion:nil];
}
    
@end
