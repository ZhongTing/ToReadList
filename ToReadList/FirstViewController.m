//
//  FirstViewController.m
//  ToReadList
//
//  Created by ZhongTing on 2015/6/14.
//  Copyright (c) 2015年 ZhongTing. All rights reserved.
//

#import "FirstViewController.h"
#import <MagicalRecord/MagicalRecord.h>
#import "BookViewController.h"
#import "BookTableViewCell.h"
#import "Book.h"
typedef enum {
    ALL,
    TOREAD,
    HASREAD
} FilterType;

@interface FirstViewController () {
    NSMutableArray* unReadBookArray;
    NSMutableArray* hasReadBookArray;
    NSArray* bookArray;
    FilterType filter;
}

@end

@implementation FirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"view will appear");

    //init data
    unReadBookArray = [NSMutableArray arrayWithArray:[Book MR_findByAttribute:@"done" withValue:@"0" inContext:[NSManagedObjectContext MR_defaultContext]]];
    hasReadBookArray = [NSMutableArray arrayWithArray:[Book MR_findByAttribute:@"done" withValue:@"1" inContext:[NSManagedObjectContext MR_defaultContext]]];
    [self.tableView reloadData];
    bookArray = @[ unReadBookArray, hasReadBookArray ];
    [self.tableView reloadData];
    //if tableview is empty show the add book hint
    [self checkBookListIsEmpty];
}

- (void)checkBookListIsEmpty
{
    self.tableView.alpha = unReadBookArray.count + hasReadBookArray.count == 0 ? 0 : 1;
}

- (IBAction)filterValueChange:(id)sender
{
    UISegmentedControl* segementControl = sender;
    filter = (int)segementControl.selectedSegmentIndex;
    [self.tableView reloadData];
}

- (int)getFilterSection:(NSInteger)section
{
    return filter == ALL ? (int)section : filter - 1;
}

#pragma mark - tableview

- (BOOL)tableView:(UITableView*)tableView canEditRowAtIndexPath:(NSIndexPath*)indexPath
{
    return YES;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return filter == ALL ? bookArray.count : 1;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    int index = [self getFilterSection:section];
    return [bookArray[index] count];
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    static NSString* identifier = @"BookTableViewCell";
    int section = [self getFilterSection:indexPath.section];
    Book* book = bookArray[section][indexPath.row];
    BookTableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    [cell initWithBook:book];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    return cell;
}

- (NSString*)tableView:(UITableView*)tableView titleForHeaderInSection:(NSInteger)section
{
    if (filter == ALL) {
        return section == 0 ? @"TO READ" : @"HAS READ";
    }
    else
        return filter == TOREAD ? @"TO READ" : @"HAS READ";
}

- (void)tableView:(UITableView*)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath*)indexPath
{
    //override with empty to show editactions;
}

- (NSArray*)tableView:(UITableView*)tableView editActionsForRowAtIndexPath:(NSIndexPath*)indexPath
{
    UITableViewRowAction* deleteRowAction = [UITableViewRowAction
        rowActionWithStyle:UITableViewRowActionStyleDestructive
                     title:@"Delete"
                   handler:^(UITableViewRowAction* action, NSIndexPath* indexPath) {
                       int section = [self getFilterSection:indexPath.section];
                       Book* book = bookArray[section][indexPath.row];
                       [bookArray[section] removeObject:book];
                       [book MR_deleteEntity];
                       [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
                       [tableView deleteRowsAtIndexPaths:@[ indexPath ] withRowAnimation:UITableViewRowAnimationAutomatic];
                       [self checkBookListIsEmpty];
                   }];
    NSString* completeTitle = indexPath.section == 0 ? @"Done" : @"UnRead";
    if (filter != ALL) {
        completeTitle = filter == TOREAD ? @"DONE" : @"UnRead";
    }
    UITableViewRowAction* completeAction = [UITableViewRowAction
        rowActionWithStyle:UITableViewRowActionStyleNormal
                     title:completeTitle
                   handler:^(UITableViewRowAction* action, NSIndexPath* indexPath) {
                       int section = [self getFilterSection:indexPath.section];
                       unsigned long anotherSection = (section + 1) % bookArray.count;
                       Book* book = bookArray[section][indexPath.row];
                       [bookArray[section] removeObject:book];
                       [bookArray[anotherSection] addObject:book];
                       book.doneValue = !book.doneValue;
                       [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];

                       //begin animation
                       [self.tableView beginUpdates];
                       if (filter == ALL) {
                           NSIndexPath* insertIndexPath = [NSIndexPath indexPathForRow:[bookArray[anotherSection] count] - 1 inSection:anotherSection];
                           [tableView insertRowsAtIndexPaths:@[ insertIndexPath ] withRowAnimation:UITableViewRowAnimationAutomatic];
                       }
                       [tableView deleteRowsAtIndexPaths:@[ indexPath ] withRowAnimation:UITableViewRowAnimationAutomatic];

                       [self.tableView endUpdates];
                   }];
    completeAction.backgroundEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];

    return @[ deleteRowAction, completeAction ];
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    BookViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"BookViewController"];
    int section = [self getFilterSection:indexPath.section];
    [vc setBook:bookArray[section][indexPath.row]];
    [self.navigationController pushViewController:vc animated:true];
}

- (IBAction)filterButton:(id)sender
{
    NSLog(@"Filter Button is clicked!!!!!!");
}

@end
