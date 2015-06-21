//
//  FirstViewController.m
//  ToReadList
//
//  Created by ZhongTing on 2015/6/14.
//  Copyright (c) 2015年 ZhongTing. All rights reserved.
//

#import "FirstViewController.h"
#import <MagicalRecord/MagicalRecord.h>
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

    NSLog(@"array count = %d", array.count);

    bookArray = [NSMutableArray arrayWithArray:array];
    [self.tableView reloadData];
    NSLog(@"view will appear");
}

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
    NSLog(@"numbers of rows = %d", bookArray.count);
    return bookArray.count;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    static NSString* cellIdentifier = @"MyCell";
    Book* book = bookArray[indexPath.row];

    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }

    cell.textLabel.text = book.title;
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;

    return cell;
}

- (CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

- (NSString*)tableView:(UITableView*)tableView titleForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"This is BOOK LIST!!!!!"];
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

- (void)tableView:(UITableView*)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath*)indexPath
{
    Book* book = bookArray[indexPath.row];
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Author:%@", book.author] message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];

    [alert show];
}

@end
