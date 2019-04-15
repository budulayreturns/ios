#import "DateMachine.h"

@implementation StartDateTextField
- (BOOL) validateText {
    BOOL isValid = NO;
    NSString *pattern = [[NSString alloc] initWithString:@"^(3[01]|[12][0-9]|0[1-9])/(1[0-2]|0[1-9])/[0-9]{4} (2[0-3]|[01]?[0-9]):([0-5]?[0-9])$"];
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:nil];
    NSInteger matches = [regex numberOfMatchesInString:self.text options:0 range:NSMakeRange(0, self.text.length)];
    if (matches) {
        isValid = YES;
    }
    [pattern release];
    [regex release];
    return isValid;
}
@end

@implementation StepTextField
- (BOOL) validateText {
    BOOL isValid = NO;
    NSCharacterSet *allowedCharacterSet = [[NSCharacterSet decimalDigitCharacterSet] retain];
    NSCharacterSet *receivedCharacterSet = [[NSCharacterSet characterSetWithCharactersInString:self.text] retain];
    isValid = [allowedCharacterSet isSupersetOfSet:receivedCharacterSet];
    [allowedCharacterSet release];
    [receivedCharacterSet release];
    return isValid;
}

- (BOOL) validateText: (NSString *) subString {
    BOOL isValid = NO;
    [subString retain];
    NSCharacterSet *allowedCharacterSet = [[NSCharacterSet decimalDigitCharacterSet] retain];
    NSCharacterSet *receivedCharacterSet = [[NSCharacterSet characterSetWithCharactersInString:subString] retain];
    isValid = [allowedCharacterSet isSupersetOfSet:receivedCharacterSet];
    [subString release];
    [allowedCharacterSet release];
    [receivedCharacterSet release];
    return isValid;
}

- (void) setInputProperties {
    [self setClearsOnBeginEditing:YES];
    [self setClearButtonMode:UITextFieldViewModeWhileEditing];
    self.keyboardType = UIKeyboardTypeNumberPad;
}

@end

@implementation DateUnitTextField
- (BOOL) validateText {
    BOOL isValid = NO;
    NSSet *allowedWordsSet = [[NSSet alloc] initWithArray:@[@"year", @"month", @"week", @"day", @"hour", @"minute"]];
    NSSet *word = [[NSSet alloc] initWithArray:@[[self.text lowercaseString]]];
    isValid = [allowedWordsSet intersectsSet:word];
    [allowedWordsSet release];
    [word release];
    return isValid;
}
- (BOOL) validateText: (NSString *) subString andIndex: (NSInteger) index{
    [subString retain];
    __block BOOL checkFlag = NO;
    if ([subString isEqualToString:@""]) {
        checkFlag = YES;
    }
    else {
        NSArray *array = [[NSArray alloc] initWithObjects:@"year", @"month", @"week", @"day", @"hour", @"minute", nil];
        NSMutableString *resultString = [[NSMutableString alloc] initWithString:self.text];
        if (self.text.length >= index) {
            [resultString insertString:subString atIndex:index];
        }
        else {
            [resultString appendString:subString];
        }
        NSString *pattern;
        if (index == 0) {
            pattern =  [[NSString alloc] initWithFormat:@"\\b(%@)", resultString];
        }
        else {
            pattern =  [[NSString alloc] initWithFormat:@"(%@)", resultString];
        }
        NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
        [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSInteger matches = [regex numberOfMatchesInString:obj options:0 range:NSMakeRange(0,  ((NSString *)obj).length)];
            if (matches > 0) {
                *stop = YES;
                checkFlag = YES;
            }
        }];
        [resultString release];
        [pattern release];
        [regex release];
        [array release];
    }
    [subString release];
    return checkFlag;
}
@end

@implementation UIButton (RSSchool_Extension_Name)
- (void) addBorder {
    self.layer.borderWidth = 1.0;
    self.layer.borderColor = [[UIColor blueColor] CGColor];
    self.layer.cornerRadius = 6.0;
}
- (void) setColorProperties {
    [self setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self setBackgroundColor:[UIColor whiteColor]];
}
@end

@implementation UITextField (RSSchool_Extension_Name)
- (BOOL) validateText {
    return YES;
}
- (void) addBorder {
    self.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.layer.borderWidth = 1.0;
    self.layer.cornerRadius = 6.0;
}
- (void) setTextProperties {
    self.textAlignment = NSTextAlignmentCenter;
    [self setTextColor:[UIColor blackColor]];
}
- (void) setInputProperties {
    [self setClearsOnBeginEditing:YES];
    [self setClearButtonMode:UITextFieldViewModeWhileEditing];
    self.keyboardType = UIKeyboardTypeAlphabet;
    self.returnKeyType = UIReturnKeyDone;
}
@end

@implementation NSDate(RSSchool_Extension_Name)

- (NSString*)getStringDate {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[NSLocale currentLocale]];
    [formatter setTimeZone:[NSTimeZone localTimeZone]];
    [formatter setDateFormat:@"dd/MM/yyyy HH:mm"];
    NSString *stringDate = [[[NSString alloc] initWithString:[formatter stringFromDate:self]] autorelease];
    [formatter release];
    return stringDate;
}

+ (NSDate *) dateFromString: (NSString*) dateString {
    [dateString retain];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[NSLocale currentLocale]];
    [formatter setTimeZone:[NSTimeZone localTimeZone]];
    [formatter setDateFormat:@"dd/MM/yyyy HH:mm"];
    NSDate *date = [[[formatter dateFromString:dateString]retain]autorelease];
    [formatter release];
    [dateString release];
    return  date;
}

+ (NSDate*) performOperationWithDate: (NSDate*) date andValue:(NSInteger) value andTypeOfPeriod: (Period) period {
    [date retain];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    switch (period) {
        case year:
            [components setYear:value];
            break;
        case month:
            [components setMonth:value];
            break;
        case week:
            [components setDay:value*7];
            break;
        case day:
            [components setDay:value];
            break;
        case hour:
            [components setHour:value];
            break;
        case minute:
            [components setMinute:value];
            break;
        default:
            break;
    }
    NSDate *newDate = [[[[NSCalendar currentCalendar] dateByAddingComponents:components toDate:date options:0] retain] autorelease];
    [date release];
    [components release];
    return newDate;
}
@end

@interface DateMachine()
@property (nonatomic, retain) NSDate *date;
@end

@implementation DateMachine

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createResultLabel];
    [self createAddButton];
    [self createSubButton];
    [self createStartDateTextField];
    [self createStepTextField];
    [self createDateUnitTextField];
    [self addTapGesureToHideKeyboard];
}

- (void)viewWillAppear:(BOOL)animated {
    [self registerAsObserverForDate];
    if (self.date == nil) {
        self.date = [NSDate date];
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [self unregisterAsObserverForDate];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    [keyPath retain];
    [change retain];
    [(id)context retain];
    if ([keyPath isEqualToString:@"date"]){
        self.resultLabel.text = [change[@"new"] getStringDate];
    }
     else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
    [(id)context release];
    [keyPath release];
    [change release];
}

- (void)startDateTextFieldDidChanged:(id)sender {
    if ([sender validateText]) {
        self.date = [NSDate dateFromString:((StartDateTextField*)sender).text];
    }
}

- (void) registerAsObserverForDate {
    [self addObserver:self forKeyPath:@"date" options:NSKeyValueObservingOptionNew context:NULL];
}

- (void) unregisterAsObserverForDate {
    [self removeObserver:self forKeyPath:@"date"];
}

- (void) addTapGesureToHideKeyboard {
    UITapGestureRecognizer *tapGesture = [[[UITapGestureRecognizer alloc] init] autorelease];
    [tapGesture addTarget:self action:@selector(tapGesture:)];
    [self.view addGestureRecognizer:tapGesture];
    [tapGesture release];
}

- (void) tapGesture: (id) sender {
    [self.view endEditing:YES];
}

- (void) createAddButton {
    UIButton *addButton = [[UIButton alloc] initWithFrame:CGRectMake([self.view frame].origin.x + 15, [self.view center].y + 45, 100, 44)];
    [addButton setColorProperties];
    [addButton addBorder];
    [addButton setTitle:@"Add" forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addButton];
    [addButton release];
}
- (void) createSubButton {
    UIButton *subButton = [[UIButton alloc] initWithFrame:CGRectMake([self.view frame].size.width - 115, [self.view center].y + 45, 100, 44)];
    [subButton setColorProperties];
    [subButton addBorder];
    [subButton setTitle:@"Sub" forState:UIControlStateNormal];
    [subButton addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:subButton];
    [subButton release];
}

- (void) createResultLabel {
    UILabel *resultLabel = [[UILabel alloc] initWithFrame:CGRectMake([self.view frame].origin.x + 15, [self.view center].y, [self.view frame].size.width - 30, 44)];
    resultLabel.textColor = [UIColor blackColor];
    resultLabel.numberOfLines = 1;
    resultLabel.tag = 1;
    resultLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:resultLabel];
    self.resultLabel = resultLabel;
    [resultLabel release];
}

- (void) createStartDateTextField {
    StartDateTextField *startDateTextField = [[StartDateTextField alloc] initWithFrame:CGRectMake(15, [self.view frame].origin.y + 100, [self.view frame].size.width-30, 44)];
    startDateTextField.placeholder = @"Start date";
    startDateTextField.delegate = self;
    [startDateTextField addBorder];
    [startDateTextField setTextProperties];
    [startDateTextField setInputProperties];
    startDateTextField.tag = 4;
    [startDateTextField addTarget:self action:@selector(startDateTextFieldDidChanged:)
        forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:startDateTextField];
    self.startDateTextField = startDateTextField;
    [startDateTextField release];
}

- (void) createStepTextField {
    StepTextField *stepTextField = [[StepTextField alloc] initWithFrame:CGRectMake(15, [self.view frame].origin.y + 159, [self.view frame].size.width-30, 44)];
    stepTextField.placeholder = @"Step";
    stepTextField.delegate = self;
    [stepTextField addBorder];
    [stepTextField setTextProperties];
    [stepTextField setInputProperties];
    stepTextField.tag = 5;
    [self.view addSubview:stepTextField];
    self.stepTextField= stepTextField;
    [stepTextField release];
}

- (void) createDateUnitTextField {
    DateUnitTextField *dateUnitTextField = [[DateUnitTextField alloc] initWithFrame:CGRectMake(15, [self.view frame].origin.y + 218, [self.view frame].size.width-30, 44)];
    dateUnitTextField.placeholder = @"Date unit";
    dateUnitTextField.delegate = self;
    [dateUnitTextField addBorder];
    [dateUnitTextField setTextProperties];
    [dateUnitTextField setInputProperties];
    dateUnitTextField.tag = 6;
    [self.view addSubview:dateUnitTextField];
    self.dateUnitTextField= dateUnitTextField;
    [dateUnitTextField release];
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    BOOL isValid = YES;
    [textField retain];
    [string retain];
    if ([textField respondsToSelector:@selector(validateText:andIndex:)]) {
        isValid = [textField validateText:string andIndex:range.location];
    }
    else if ([textField respondsToSelector:@selector(validateText:)]) {
        isValid = [textField validateText:string];
    }
    [textField release];
    [string release];
    return isValid;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField retain];
    if ([textField isFirstResponder]) {
         [textField resignFirstResponder];
    }
    [textField release];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [textField retain];
    if ([textField validateText]) {
        if (textField.tag == 4) {
            self.date = [NSDate dateFromString:textField.text];
        }
    }
    else {
        textField.text = @"";
    }
    [textField release];
}

- (Period) convertFromString: (NSString *) string {
    [string retain];
    NSDictionary *dict = [[NSDictionary alloc] initWithDictionary:@{@"year":@0, @"month":@1, @"week":@2, @"day":@3, @"hour":@4, @"minute":@5}];
    NSString *lowerCaseString = [[string lowercaseString] copy];
    Period period = 0;
    if ([dict objectForKey:lowerCaseString]){
       period = [[dict objectForKey:lowerCaseString] integerValue];
    }
    [string release];
    [lowerCaseString release];
    [dict release];
    return period;
}

- (void) buttonTapped: (id) sender {
    if ([self.stepTextField.text isEqualToString:@""]||[self.dateUnitTextField.text isEqualToString:@""]){
        return;
    }
    NSInteger value = [self.stepTextField.text integerValue];
    Period typeOfPeriod = [self convertFromString:self.dateUnitTextField.text];
    if ([[sender currentTitle] isEqualToString:@"Add"]) {
        self.date = [NSDate performOperationWithDate:self.date andValue:value andTypeOfPeriod:typeOfPeriod];
    }
    else if ([[sender currentTitle] isEqualToString:@"Sub"]) {
        self.date = [NSDate performOperationWithDate:self.date andValue:-value andTypeOfPeriod:typeOfPeriod];
    }
}

- (void)dealloc {
    [_date release];
    [_resultLabel release];
    [_startDateTextField release];
    [_stepTextField release];
    [_dateUnitTextField release];
    [super dealloc];
}
@end


