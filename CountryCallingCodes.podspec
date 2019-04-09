#
# Be sure to run `pod lib lint CountryCallingCodes.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'CountryCallingCodes'
  s.version          = '0.1.1'
  s.summary          = 'A simple to use framework that displays a UI with a list of country names, with their calling codes and Emoji flags and returns that data.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/Ar4n3/CountryCallingCodes'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Ar4n3' => 'enaradelao@gmail.com' }
  s.source           = { :git => 'https://github.com/Ar4n3/CountryCallingCodes.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'

  s.source_files = 'CountryCallingCodes/Classes/**/*'
  
  s.resource_bundles = {
    'CountryCallingCodes' => ['CountryCallingCodes/Assets/*.{storyboard,json,png}']
  }

  s.public_header_files = 'CountryCallingCodes/Classes/CountryCallingCode.h'
  s.frameworks = 'UIKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
