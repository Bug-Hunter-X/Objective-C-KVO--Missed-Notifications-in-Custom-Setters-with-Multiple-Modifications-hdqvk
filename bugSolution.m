To fix this issue, avoid modifying the observed property multiple times within the setter. Instead, use temporary variables and call `willChangeValueForKey:` and `didChangeValueForKey:` for each change:

```objectivec
@property (nonatomic, strong) NSString *myString;

- (void)setMyString:(NSString *)newString {
    if (newString != _myString) {
        NSString *intermediateString = [newString uppercaseString]; // Modify 1
        [self willChangeValueForKey:@"myString"];
        _myString = intermediateString;
        [self didChangeValueForKey:@"myString"];

        intermediateString = [_myString stringByAppendingString:@"!"]; // Modify 2
        [self willChangeValueForKey:@"myString"];
        _myString = intermediateString;
        [self didChangeValueForKey:@"myString"];
    }
}
```

This ensures that observers receive notifications for each intermediate state, correctly reflecting all changes made to the observed property.