// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Book.m instead.

#import "_Book.h"

const struct BookAttributes BookAttributes = {
	.author = @"author",
	.coverUrl = @"coverUrl",
	.desc = @"desc",
	.isbn10 = @"isbn10",
	.isbn13 = @"isbn13",
	.pageCount = @"pageCount",
	.publishDate = @"publishDate",
	.publisher = @"publisher",
	.subtitle = @"subtitle",
	.title = @"title",
};

@implementation BookID
@end

@implementation _Book

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Book" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Book";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Book" inManagedObjectContext:moc_];
}

- (BookID*)objectID {
	return (BookID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic author;

@dynamic coverUrl;

@dynamic desc;

@dynamic isbn10;

@dynamic isbn13;

@dynamic pageCount;

@dynamic publishDate;

@dynamic publisher;

@dynamic subtitle;

@dynamic title;

@end

