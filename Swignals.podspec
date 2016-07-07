#
# Be sure to run `pod lib lint Swignals.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Swignals'
  s.version          = '0.1.1'
  s.summary          = 'Swignals is an observable pattern system written entirely in Swift.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

#   s.description      = <<-DESC
# Swignals is an observable pattern system written entirely in Swift.
#                        DESC

  s.homepage         = 'https://github.com/finder39/Swignals'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Joseph Neuman' }
  s.source           = { :git => 'https://github.com/finder39/Swignals.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/finder39'

  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.9'
  s.tvos.deployment_target = '9.0'
  s.watchos.deployment_target = '2.0'

  s.source_files = 'Source/**/*'

  # s.resource_bundles = {
  #   'Swignals' => ['Swignals/Assets/*.png']
  # }
end
