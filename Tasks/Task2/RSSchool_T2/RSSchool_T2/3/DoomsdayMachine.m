#import "DoomsdayMachine.h"

@interface AssimilationInfoWrapper: NSObject <AssimilationInfo>

@property (nonatomic, readonly) NSInteger years;
@property (nonatomic, readonly) NSInteger months;
@property (nonatomic, readonly) NSInteger days;
@property (nonatomic, readonly) NSInteger hours;
@property (nonatomic, readonly) NSInteger minutes;
@property (nonatomic, readonly) NSInteger seconds;

@end


@implementation AssimilationInfoWrapper

- (id) initWithYears: (NSUInteger) years andMonths: (NSUInteger) months andDays: (NSInteger) days andHours: (NSUInteger) hours andMinutes: (NSUInteger) minutes andSeconds: (NSUInteger) seconds{
    
    if (self = [super init]) {
        _years = years;
        _months = months;
        _days = days;
        _hours = hours;
        _minutes = minutes;
        _seconds = seconds;
    }
    return self;
}

- (void)dealloc {
    [super dealloc];
}
@end


@implementation DoomsdayMachine

- (id) init {
    if (self = [super init]) {
        NSString *doomsDayString = [[NSString alloc] initWithFormat:@"14 August 2208 03:13:37"];
        _doomsDate = [self convertDateStringToDate:doomsDayString WithFormat:@"dd MMMM yyyy HH:mm:ss"];
        [doomsDayString release];
    }
    return self;
}

- (NSDate*) convertDateStringToDate: (NSString*) dateString WithFormat: (NSString*) format {
    [dateString retain];
    [format retain];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    [dateFormatter setDateFormat:format];
    NSDate *date = [[dateFormatter dateFromString:dateString] autorelease];
    
    [dateFormatter release];
    [format release];
    [dateString release];
    return date;
}

- (NSString *) convertDateToString: (NSDate *) date withFormat:(NSString*) format {
    
    [date retain];
    [format retain];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    [dateFormatter setDateFormat:format];
    
     NSString *string = [[[NSString alloc] initWithString: [dateFormatter stringFromDate:date]] autorelease];
    
    [dateFormatter release];
    [format release];
    [date release];
    return string;
}

- (id<AssimilationInfo>)assimilationInfoForCurrentDateString:(NSString *)dateString {
   [dateString retain];
    
    NSDate *currentdate = [[self convertDateStringToDate:dateString WithFormat:@"yyyy:MM:dd@ss\\mm/HH"] autorelease];
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    unsigned int unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |NSCalendarUnitDay| NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    NSDateComponents *comps = [gregorian components:unitFlags fromDate:currentdate  toDate:[self doomsDate]  options:0];
    
    id <AssimilationInfo> info = [[[AssimilationInfoWrapper alloc] initWithYears:[comps year] andMonths:[comps month] andDays:[comps day] andHours:[comps hour] andMinutes:[comps minute] andSeconds:[comps second]] autorelease];
    
    [gregorian release];
    [dateString release];
    return info;
}

- (NSString *)doomsdayString {
    NSString *doomsDayString = [self convertDateToString:[self doomsDate] withFormat:@"EEEE, MMMM dd, yyyy"];
    return doomsDayString;
}

- (void)dealloc
{
    [_doomsDate release];
    [super dealloc];
}
@end
