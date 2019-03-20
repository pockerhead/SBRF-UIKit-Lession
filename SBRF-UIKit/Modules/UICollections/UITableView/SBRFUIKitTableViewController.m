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
@property (strong, nonatomic) NSMutableArray<NSArray *> *sections;
@property (strong, nonatomic) NSArray<AnimalViewModel *> *animals;
@property (strong, nonatomic) LeftAlignedImageCell *dummyCell;
    
@end

@implementation SBRFUIKitTableViewController
    
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
    self.animals = [self getDataSource];
    NSArray *initialSections = @[
                                 @[@"UICollectionView"],
                                 self.animals
                                 ];
    self.sections = [NSMutableArray arrayWithArray:initialSections];
    self.dummyCell = [[LeftAlignedImageCell alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.tableView.frame) ,0)];
    [self.tableView registerClass:[RightAlignedImageCell class] forCellReuseIdentifier:NSStringFromClass([RightAlignedImageCell class])];
    [self.tableView registerClass:[LeftAlignedImageCell class] forCellReuseIdentifier:NSStringFromClass([LeftAlignedImageCell class])];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.navigationItem.title = @"UITableView";
}
    
- (void)viewDidLayoutSubviews
{
    self.tableView.frame = self.view.frame;
    [self.tableView layoutIfNeeded];
}
    
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:{
            NSString *text = self.sections[indexPath.section][indexPath.row];
            UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"navigationCell"];
            cell.textLabel.text = text;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return cell;
            break;
        }
        case 1:{
            return [self rowForAnimalSection:indexPath];
            break;
        }
        
        default:
        break;
    }
    return [UITableViewCell new];
}
    
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.sections.count;
}
    
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.sections[section].count;
}

    
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 1:{
            AnimalViewModel *model = self.sections[indexPath.section][indexPath.row];
            return [self.dummyCell sizeForModel:model];
        }
        break;
        default:
        break;
    }
    return UITableViewAutomaticDimension;

}
    
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 1:
        [self didSelectAnimalCellAtIndexPath:indexPath];
        break;
        default:
        break;
    }
    
}
    
- (UITableViewCell *)rowForAnimalSection:(NSIndexPath *)indexPath
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
    
- (void)didSelectAnimalCellAtIndexPath:(NSIndexPath *)indexPath
{
    AnimalViewModel *selectedAnimal = self.animals[indexPath.row];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:selectedAnimal.animalName message:selectedAnimal.animalDescription preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:action];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (NSArray<AnimalViewModel *> *)getDataSource
{
    NSMutableArray<AnimalViewModel *> *arr = [NSMutableArray new];
    for (int i = 0; i < 50; i++) {
        [arr addObject:[[AnimalViewModel alloc] initWithName:@"Альпака" description:@"Домашнее парнокопытное животное, произошедшее от викуньи. Разводят в высокогорном поясе Южной Америки. На сегодняшний день там обитает около трёх миллионов альпака, большая часть из которых населяет Перу." andImage:[UIImage imageNamed:@"alpaka"]]];
        [arr addObject:[[AnimalViewModel alloc] initWithName:@"Обыкновенный бегемот" description:@"млекопитающее из отряда парнокопытных, подотряда свинообразных, семейства бегемотовых, единственный современный вид рода Hippopotamus." andImage:[UIImage imageNamed:@"hyppopotamus"]]];
        [arr addObject:[[AnimalViewModel alloc] initWithName:@"Чёрная вдова" description:@"Вид пауков, распространённый в Северной и Южной Америке. Опасен для человека." andImage:[UIImage imageNamed:@"blackWidow"]]];
    }
    return [arr copy];
}
    
    
@end
