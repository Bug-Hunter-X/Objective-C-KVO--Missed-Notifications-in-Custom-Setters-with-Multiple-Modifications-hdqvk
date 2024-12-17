In Objective-C, a subtle bug can occur when using KVO (Key-Value Observing) with custom setters. If a custom setter modifies the observed property multiple times within its execution, only the final change will be reflected to the observer.  This is because KVO only triggers notifications after the setter completes.

Example:

```objectivec
@property (nonatomic, strong) NSString *myString;

- (void)setMyString:(NSString *)newString {
    if (newString != _myString) {
        _myString = [newString uppercaseString]; // Modify 1
        _myString = [_myString stringByAppendingString:@"!"]; // Modify 2
        [self willChangeValueForKey:@"myString"];
        [self didChangeValueForKey:@"myString"];
    }
}
```

In this example, the observer will only receive a notification for "MYSTRING!", not for "MYSTRING" which is the intermediate state.