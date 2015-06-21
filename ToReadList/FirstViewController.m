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

@interface FirstViewController () {
    NSMutableArray* unReadBookArray;
    NSMutableArray* hasReadBookArray;
    NSArray* bookArray;
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

#pragma mark - tableview
- (BOOL)tableView:(UITableView*)tableView canEditRowAtIndexPath:(NSIndexPath*)indexPath
{
    return YES;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return bookArray.count;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return [bookArray[section] count];
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    static NSString* identifier = @"BookTableViewCell";
    Book* book = bookArray[indexPath.section][indexPath.row];
    BookTableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    [cell initWithBook:book];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (NSString*)tableView:(UITableView*)tableView titleForHeaderInSection:(NSInteger)section
{
    return section == 0 ? @"TO READ" : @"HAS READ";
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

                       Book* book = bookArray[indexPath.section][indexPath.row];
                       [bookArray[indexPath.section] removeObject:book];
                       [book MR_deleteEntity];
                       [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
                       [tableView deleteRowsAtIndexPaths:@[ indexPath ] withRowAnimation:UITableViewRowAnimationAutomatic];
                       [self checkBookListIsEmpty];
                   }];
    UITableViewRowAction* completeAction = [UITableViewRowAction
        rowActionWithStyle:UITableViewRowActionStyleNormal
                     title:indexPath.section == 0 ? @"Done" : @"UnRead"
                   handler:^(UITableViewRowAction* action, NSIndexPath* indexPath) {
                       unsigned long anotherSection = (indexPath.section + 1) % bookArray.count;
                       Book* book = bookArray[indexPath.section][indexPath.row];
                       [bookArray[indexPath.section] removeObject:book];
                       [bookArray[anotherSection] addObject:book];
                       book.doneValue = !book.doneValue;
                       [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];

                       //begin animation
                       [self.tableView beginUpdates];
                       NSIndexPath* insertIndexPath = [NSIndexPath indexPathForRow:[bookArray[anotherSection] count] - 1 inSection:anotherSection];
                       [tableView insertRowsAtIndexPaths:@[ insertIndexPath ] withRowAnimation:UITableViewRowAnimationAutomatic];
                       [tableView deleteRowsAtIndexPaths:@[ indexPath ] withRowAnimation:UITableViewRowAnimationAutomatic];

                       [self.tableView endUpdates];
                   }];
    completeAction.backgroundEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];

    return @[ deleteRowAction, completeAction ];
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    BookViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"BookViewController"];
    [vc setBook:bookArray[indexPath.section][indexPath.row]];
    [self.navigationController pushViewController:vc animated:true];
}

@end
