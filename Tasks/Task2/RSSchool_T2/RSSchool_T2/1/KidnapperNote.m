#import "KidnapperNote.h"

@implementation KidnapperNote
// your code here

- (BOOL) checkMagazine:(NSString *)magaine note:(NSString *)note {
    
    [magaine retain];
    [note retain];
    
    BOOL answer = NO;
    
    NSMutableCharacterSet *set = [NSMutableCharacterSet whitespaceAndNewlineCharacterSet];
    [set formUnionWithCharacterSet:[NSCharacterSet punctuationCharacterSet]];
   
    NSArray * magazineArray = [[magaine lowercaseString] componentsSeparatedByCharactersInSet:set];
    NSArray * noteArray = [[note lowercaseString] componentsSeparatedByCharactersInSet:set];
    
    NSCountedSet *magazineWords = [[NSCountedSet alloc] initWithArray:magazineArray];
    NSCountedSet *noteWords = [[NSCountedSet alloc] initWithArray:noteArray];
    
    [noteWords minusSet:magazineWords];

    if (noteWords.count == 0) {
        answer = YES;
    }
    
    [magaine release];
    [note release];
    [magazineWords release];
    [noteWords release];
    return answer;
}

- (void)dealloc
{
    [super dealloc];
}

@end

//([\w]+)
//[a-z-]{1,}
