#import "Book.h"
#import <MagicalRecord.h>

@interface Book ()

// Private interface goes here.

@end

@implementation Book

+ (instancetype)initWithDataObject:(NSDictionary*)data
{
    Book* book = [self findFromCachedWith:data[@"industryIdentifiers"]];
    if (book == nil) {
        book = [Book MR_createEntity];
    }
    book.title = data[@"title"];
    book.subtitle = data[@"subtitle"];
    book.publisher = data[@"publisher"];
    book.publishDate = data[@"publishedDate"];
    book.desc = data[@"description"];
    book.pageCountValue = [data[@"pageCount"] integerValue];
    book.coverUrl = data[@"imageLinks"][@"thumbnail"];
    [book setISBN:data[@"industryIdentifiers"]];
    [book setAuthorWithArray:data[@"authors"]];
    //    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    return book;
}

+ (instancetype)findFromCachedWith:(NSDictionary*)data
{
    Book* book;
    for (NSDictionary* isbn in data) {
        if ([isbn[@"identifier"] length] == 13) {
            book = [Book MR_findFirstByAttribute:@"isbn13" withValue:data inContext:[NSManagedObjectContext MR_defaultContext]];
        }
        else if ([isbn[@"identifier"] length] == 10) {
            book = [Book MR_findFirstByAttribute:@"isbn10" withValue:data inContext:[NSManagedObjectContext MR_defaultContext]];
        }
        if (book)
            return book;
    }
    return book;
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
