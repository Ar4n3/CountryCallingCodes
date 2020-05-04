# CountryCallingCodes


[![Build Status](https://app.bitrise.io/app/fe0994beb7f761fb.svg?token=PyJS3u6SCGVaKcnXb5Dfiw)](https://www.bitrise.io/app/fe0994beb7f761fb) [![codecov](https://codecov.io/gh/Ar4n3/CountryCallingCodes/branch/master/graph/badge.svg)](https://codecov.io/gh/Ar4n3/CountryCallingCodes) [![pod](https://cocoapod-badges.herokuapp.com/v/CountryCallingCodes/0.1.1/badge.png)](https://cocoapods.org/pods/CountryCallingCodes) [![license](https://cocoapod-badges.herokuapp.com/l/CountryCallingCodes/badge.png)](https://cocoapods.org/pods/CountryCallingCodes)




A simple and easy way to get the international calling code and Emoji flag from a selected Country. Demos are provided in Objective-C and Swift.

## Installation

You can download this project, or you can install it via Cocoapods:

```cocoapods
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'

target 'TargetName' do
pod 'CountryCallingCodes'
end
```

## How to use

### Objective-C

Get the default data for your device locale (e.g. flag => :es:, code => "+34")

```objective-c
[[CountryCallingCode sharedInstance] setDelegate:self];
NSString *buttonString = [NSString stringWithFormat:@"%@\t%@", [CountryCallingCode sharedInstance].flag, [CountryCallingCode sharedInstance].code];
[_countryButton setTitle:buttonString forState:UIControlStateNormal];
```

To select another country, make a segue to storyboard reference and on your delegate implement:

```objective-c
#pragma mark - Delegate Methods

- (void)updateCountryData {
    NSString *buttonString = [NSString stringWithFormat:@"%@\t%@", [CountryCallingCode sharedInstance].flag, [CountryCallingCode sharedInstance].code];
    [_countryButton setTitle:buttonString forState:UIControlStateNormal];
}

```

### Swift

Get the default data for your device locale (e.g. flag => :es:, code => "+34")

```swift
CountryCallingCode.sharedInstance().delegate = self
let buttonString = String.init(format: "%@\t%@", CountryCallingCode.sharedInstance().flag, CountryCallingCode.sharedInstance().code)
countryButton.setTitle(buttonString, for: .normal)
```

To select another country, make a segue to storyboard reference and on your delegate implement:

```swift
//MARK: Delegate methods
func updateCountryData() {
   let buttonString = String.init(format: "%@\t%@", CountryCallingCode.sharedInstance().flag, CountryCallingCode.sharedInstance().code)
   countryButton.setTitle(buttonString, for: .normal)
}

```
