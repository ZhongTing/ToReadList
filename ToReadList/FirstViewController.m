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
    NSMutableArray* bookArray;
}

@end

@implementation FirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    bookArray = [NSMutableArray array];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    NSArray* array = [Book MR_findAll];

    bookArray = [NSMutableArray arrayWithArray:array];
    [self.tableView reloadData];
    NSLog(@"view will appear");
}

#pragma mark - tableview
- (BOOL)tableView:(UITableView*)tableView canEditRowAtIndexPath:(NSIndexPath*)indexPath
{
    return YES;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return bookArray.count;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    static NSString* identifier = @"BookTableViewCell";
    Book* book = bookArray[indexPath.row];
    BookTableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    [cell initWithBook:book];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (NSString*)tableView:(UITableView*)tableView titleForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"TO READ"];
}

- (void)tableView:(UITableView*)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath*)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if (indexPath.row < bookArray.count) {

            //tableview上面的內容清除
            Book* book = bookArray[indexPath.row];
            [bookArray removeObject:book];
            [book MR_deleteEntity];
            [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        }
    }
}
- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    BookViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"BookViewController"];
    [vc setBook:bookArray[indexPath.row]];
    [self.navigationController pushViewController:vc animated:true];
}

@end
