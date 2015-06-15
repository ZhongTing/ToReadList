// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Book.m instead.

#import "_Book.h"

const struct BookAttributes BookAttributes = {
	.author = @"author",
	.averageRating = @"averageRating",
	.coverUrl = @"coverUrl",
	.desc = @"desc",
	.isbn10 = @"isbn10",
	.isbn13 = @"isbn13",
	.pageCount = @"pageCount",
	.publishDate = @"publishDate",
	.publisher = @"publisher",
	.ratingsCount = @"ratingsCount",
	.subtitle = @"subtitle",
	.timestamp = @"timestamp",
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

	if ([key isEqualToString:@"pageCountValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"pageCount"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"ratingsCountValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"ratingsCount"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic author;

@dynamic averageRating;

@dynamic coverUrl;

@dynamic desc;

@dynamic isbn10;

@dynamic isbn13;

@dynamic pageCount;

- (int64_t)pageCountValue {
	NSNumber *result = [self pageCount];
	return [result longLongValue];
}

- (void)setPageCountValue:(int64_t)value_ {
	[self setPageCount:[NSNumber numberWithLongLong:value_]];
}

- (int64_t)primitivePageCountValue {
	NSNumber *result = [self primitivePageCount];
	return [result longLongValue];
}

- (void)setPrimitivePageCountValue:(int64_t)value_ {
	[self setPrimitivePageCount:[NSNumber numberWithLongLong:value_]];
}

@dynamic publishDate;

@dynamic publisher;

@dynamic ratingsCount;

- (int64_t)ratingsCountValue {
	NSNumber *result = [self ratingsCount];
	return [result longLongValue];
}

- (void)setRatingsCountValue:(int64_t)value_ {
	[self setRatingsCount:[NSNumber numberWithLongLong:value_]];
}

- (int64_t)primitiveRatingsCountValue {
	NSNumber *result = [self primitiveRatingsCount];
	return [result longLongValue];
}

- (void)setPrimitiveRatingsCountValue:(int64_t)value_ {
	[self setPrimitiveRatingsCount:[NSNumber numberWithLongLong:value_]];
}

@dynamic subtitle;

@dynamic timestamp;

@dynamic title;

@end

