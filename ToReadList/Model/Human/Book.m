#import "Book.h"
#import <MagicalRecord.h>

@interface Book ()

// Private interface goes here.

@end

@implementation Book

+ (instancetype)initWithDataObject:(NSDictionary*)data
{
    Book* book = [self findFromCachedWith:data[@"industryIdentifiers"]];
    NSString* noData = @"無資料";
    if (book == nil) {
        book = [Book MR_createEntity];
    }
    book.title = data[@"title"];
    book.subtitle = data[@"subtitle"];
    book.publisher = [self stringWithDefaultValue:data[@"publisher"] defaultValue:noData];
    book.publishDate = [self stringWithDefaultValue:data[@"publishedDate"] defaultValue:noData];
    book.desc = [self stringWithDefaultValue:data[@"description"] defaultValue:noData];
    book.pageCount = [self stringWithDefaultValue:[data[@"pageCount"] stringValue] defaultValue:noData];
    book.ratingsCount = [self stringWithDefaultValue:[data[@"ratingsCount"] stringValue] defaultValue:noData];
    book.averageRating = [self stringWithDefaultValue:[data[@"averageRating"] stringValue] defaultValue:noData];
    NSLog(@"%@", data[@"imageLinks"]);
    book.coverUrl = [self stringWithDefaultValue:data[@"imageLinks"][@"thumbnail"] defaultValue:@""];
    book.timestamp = [NSDate date];

    [book setISBN:data[@"industryIdentifiers"]];
    [book setAuthorWithArray:data[@"authors"]];
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    return book;
}

+ (instancetype)findFromCachedWith:(NSDictionary*)data
{
    Book* book;
    for (NSDictionary* isbn in data) {
        NSString* isbnString = isbn[@"identifier"];
        if ([isbnString length] == 13) {
            book = [Book MR_findFirstByAttribute:@"isbn13" withValue:isbnString inContext:[NSManagedObjectContext MR_defaultContext]];
        }
        else if ([isbn[@"identifier"] length] == 10) {
            book = [Book MR_findFirstByAttribute:@"isbn10" withValue:isbnString inContext:[NSManagedObjectContext MR_defaultContext]];
        }
        if (book)
            return book;
    }
    return book;
}

+ (NSString*)stringWithDefaultValue:(NSString*)string defaultValue:(NSString*)defaultValue
{
    return string != nil && string.length != 0 ? string : defaultValue;
}

- (void)setISBN:(NSDictionary*)data
{
    for (NSDictionary* isbn in data) {
        if ([isbn[@"identifier"] length] == 13) {
            self.isbn13 = isbn[@"identifier"];
        }
        else if ([isbn[@"identifier"] length] == 10) {
            self.isbn10 = isbn[@"identifier"];
        }
    }
}

- (void)setAuthorWithArray:(NSArray*)data
{
    NSMutableString* result = [[NSMutableString alloc] init];
    for (NSString* author in data) {
        if (result.length != 0) {
            [result appendString:@" / "];
        }
        [result appendString:author];
    }
    self.author = result;
}

@end
