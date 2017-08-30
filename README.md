# CountryCallingCodes


[![Build Status](https://www.bitrise.io/app/fd809a6a86f90a46/status.svg?token=MLGxkD96wAz1TE-rwkAP9g)](https://github.com/Ar4n3/CountryCallingCodes)


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