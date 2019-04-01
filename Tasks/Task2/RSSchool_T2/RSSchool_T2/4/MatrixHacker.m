#import "MatrixHacker.h"

@interface Character : NSObject <Character>
@property (nonatomic, assign, getter=isClone) BOOL clone;
@property (nonatomic, copy) NSString *name;
@end


@implementation Character

+ (instancetype)createWithName:(NSString *)name isClone:(BOOL)clone {
    return [[[self class] alloc] initWithName:name isClone:clone];
}

- (instancetype) initWithName: (NSString *)name isClone:(BOOL)clone {
    if (self = [super init]) {
        _name = [name copy];
        _clone = clone;
    }
    return self;
}

- (BOOL)isClone {
    return _clone;
}

- (NSString *)name {
    return _name;
}

- (NSString *)description {
    return [[[NSString alloc] initWithFormat:@"name:%@ isClone:%s", _name, _clone ? "YES" : "NO"] autorelease];
}
- (void)dealloc {
    [_name release];
    [super dealloc];
}
@end

@interface MatrixHacker()
@property (nonatomic, copy, readwrite) InjectBlock injection;
@end

@implementation MatrixHacker

/* Injection block
 
id<Character> (^block)(NSString*) = ^id<Character>(NSString *name) {
    [name retain];
    id<Character> ch = [name isEqualToString:@"Neo"] ? [Character createWithName:[name copy] isClone:NO] : [Character createWithName:@"Agent Smith" isClone:YES];
    [name release];
    return [ch autorelease];
};
 */

- (void)injectCode:(id<Character> (^)(NSString *name))theBlock {
    [_injection release];
    _injection = theBlock;
}

- (NSArray<id<Character>> *)runCodeWithData:(NSArray<NSString *> *)names {
    [names retain];
    __block NSMutableArray <id<Character>> *array = [[NSMutableArray alloc] init];
    [names enumerateObjectsUsingBlock:^(id name, NSUInteger idx, BOOL *stop){
        [array addObject:self.injection(name)];
    }];
    [names release];
    return [array autorelease];
}

- (void)dealloc
{
    if (_injection) {
        [_injection release];
    }
    [super dealloc];
}

@end
