//
//  BookViewController.m
//  ToReadList
//
//  Created by ZhongTing on 2015/6/17.
//  Copyright (c) 2015年 ZhongTing. All rights reserved.
//

#import "BookViewController.h"
#import <MagicalRecord.h>
#import <UIImageView+AFNetworking.h>

@interface BookViewController ()
@property (weak, nonatomic) IBOutlet UILabel* isbn10Label;
@property (weak, nonatomic) IBOutlet UILabel* isbn13Label;

@property (weak, nonatomic) IBOutlet UIImageView* imageView;
@property (weak, nonatomic) IBOutlet UILabel* titleLabel;
@property (weak, nonatomic) IBOutlet UILabel* subTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel* publisherLabel;
@property (weak, nonatomic) IBOutlet UILabel* publishDataLabel;
@property (weak, nonatomic) IBOutlet UILabel* pageCountLabel;
@property (weak, nonatomic) IBOutlet UILabel* gradeLabel;
@property (weak, nonatomic) IBOutlet UILabel* voteCountLabel;
@property (weak, nonatomic) IBOutlet UILabel* descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel* authorLabel;
@property (weak, nonatomic) IBOutlet UIView *contentBaseView;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation BookViewController {
    Book* _book;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initWithBook:_book];
    self.navigationItem.title = @"Book Information";
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.scrollView.contentSize = self.contentBaseView.frame.size;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setBook:(Book*)book
{
    _book = book;
}

- (IBAction) delete:(id)sender
{
    [_book MR_deleteEntity];
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)initWithBook:(Book*)book
{
    [self setBook:book];
    self.isbn10Label.text = _book.isbn10;
    self.isbn13Label.text = _book.isbn13;
    self.titleLabel.text = _book.title;
    self.subTitleLabel.text = _book.subtitle;
    self.publisherLabel.text = _book.publisher;
    self.authorLabel.text = _book.author;
    self.publishDataLabel.text = _book.publishDate;
    self.pageCountLabel.text = _book.pageCount;
    self.gradeLabel.text = _book.averageRating;
    self.voteCountLabel.text = _book.ratingsCount;
    self.descriptionLabel.text = _book.desc;
    [self.imageView setImageWithURL:[NSURL URLWithString:_book.coverUrl] placeholderImage:[UIImage imageNamed:@"default_cover"]];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
