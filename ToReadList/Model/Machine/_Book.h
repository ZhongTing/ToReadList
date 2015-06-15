// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Book.h instead.

#import <CoreData/CoreData.h>

extern const struct BookAttributes {
	__unsafe_unretained NSString *author;
	__unsafe_unretained NSString *averageRating;
	__unsafe_unretained NSString *coverUrl;
	__unsafe_unretained NSString *desc;
	__unsafe_unretained NSString *isbn10;
	__unsafe_unretained NSString *isbn13;
	__unsafe_unretained NSString *pageCount;
	__unsafe_unretained NSString *publishDate;
	__unsafe_unretained NSString *publisher;
	__unsafe_unretained NSString *ratingsCount;
	__unsafe_unretained NSString *subtitle;
	__unsafe_unretained NSString *timestamp;
	__unsafe_unretained NSString *title;
} BookAttributes;

@interface BookID : NSManagedObjectID {}
@end

@interface _Book : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) BookID* objectID;

@property (nonatomic, strong) NSString* author;

//- (BOOL)validateAuthor:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* averageRating;

//- (BOOL)validateAverageRating:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* coverUrl;

//- (BOOL)validateCoverUrl:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* desc;

//- (BOOL)validateDesc:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* isbn10;

//- (BOOL)validateIsbn10:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* isbn13;

//- (BOOL)validateIsbn13:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* pageCount;

@property (atomic) int64_t pageCountValue;
- (int64_t)pageCountValue;
- (void)setPageCountValue:(int64_t)value_;

//- (BOOL)validatePageCount:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* publishDate;

//- (BOOL)validatePublishDate:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* publisher;

//- (BOOL)validatePublisher:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* ratingsCount;

@property (atomic) int64_t ratingsCountValue;
- (int64_t)ratingsCountValue;
- (void)setRatingsCountValue:(int64_t)value_;

//- (BOOL)validateRatingsCount:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* subtitle;

//- (BOOL)validateSubtitle:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSDate* timestamp;

//- (BOOL)validateTimestamp:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* title;

//- (BOOL)validateTitle:(id*)value_ error:(NSError**)error_;

@end

@interface _Book (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveAuthor;
- (void)setPrimitiveAuthor:(NSString*)value;

- (NSString*)primitiveAverageRating;
- (void)setPrimitiveAverageRating:(NSString*)value;

- (NSString*)primitiveCoverUrl;
- (void)setPrimitiveCoverUrl:(NSString*)value;

- (NSString*)primitiveDesc;
- (void)setPrimitiveDesc:(NSString*)value;

- (NSString*)primitiveIsbn10;
- (void)setPrimitiveIsbn10:(NSString*)value;

- (NSString*)primitiveIsbn13;
- (void)setPrimitiveIsbn13:(NSString*)value;

- (NSNumber*)primitivePageCount;
- (void)setPrimitivePageCount:(NSNumber*)value;

- (int64_t)primitivePageCountValue;
- (void)setPrimitivePageCountValue:(int64_t)value_;

- (NSString*)primitivePublishDate;
- (void)setPrimitivePublishDate:(NSString*)value;

- (NSString*)primitivePublisher;
- (void)setPrimitivePublisher:(NSString*)value;

- (NSNumber*)primitiveRatingsCount;
- (void)setPrimitiveRatingsCount:(NSNumber*)value;

- (int64_t)primitiveRatingsCountValue;
- (void)setPrimitiveRatingsCountValue:(int64_t)value_;

- (NSString*)primitiveSubtitle;
- (void)setPrimitiveSubtitle:(NSString*)value;

- (NSDate*)primitiveTimestamp;
- (void)setPrimitiveTimestamp:(NSDate*)value;

- (NSString*)primitiveTitle;
- (void)setPrimitiveTitle:(NSString*)value;

@end
