 #
# Be sure to run `pod lib lint netfox-Droar.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'OHHTTPStubs-Droar'
  s.version          = '1.0.0'
  s.summary          = 'An OHHTTPStubs plugin for Droar'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
This adds fields for controlling OHHTTPStubs straight in Droar.
                       DESC

  s.homepage         = 'https://github.com/myriadmobile/OHHTTPStubs-Droar'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Myriad Mobile' => 'developers@myriadmobile.com' }
  s.source           = { :git => 'https://github.com/myriadmobile/OHHTTPStubs-Droar.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'OHHTTPStubs-Droar/Classes/**/*'
  
# s.resource_bundles = {
#   'OHHTTPStubs-Droar' => ['OHHTTPStubs-Droar/Classes/**/*.{xib,png,jpeg,jpg,txt}']
# }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'OHHTTPStubs_Bushel'
  s.dependency 'Droar'
end
