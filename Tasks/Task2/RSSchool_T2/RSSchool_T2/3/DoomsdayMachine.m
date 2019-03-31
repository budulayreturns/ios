#import "DoomsdayMachine.h"

/*
 You are a Borg and you are going to assimilate the humans.
 The date of assimilation is set to 14 August 2208 03:13:37 (in obsolete human calendar)
 However, the Borg messep up the date format with their own,
 so 26 March 2019 12:34:56 in human will look like:
 2019:03:26@56\34/12
 
 As an engineer, you need to design a program which will take a messed up date string and
 return how many years, months, weeks, days, hours, minutes and seconds left between
 the specified date and the assimilation date. You need to create a class conforming to
 AssimilationInfo protocol and use it as a wrapper for the returned data.
 - Example
 Input: 2200:01:01@15\30/00
 Output: AssimilationInfo(years:8, months:7, days:13, hours:2, minutes:43, seconds:22)
 
 The machine should also be able to return the assimilation date in string
 representation for humans to behold and the format should be easily read by them.
 (as it would be displayed on the countdown screen)
 - Example
 Output: Sunday, August 14, 2208
 */


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
