#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint flutter_dyscan.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'flutter_dyscan'
  s.version          = '0.0.1'
  s.summary          = 'DyScan allows users on your mobile app to add their payment information more easily.'
  s.description      = <<-DESC
DyScan allows users on your mobile app to add their payment information more easily.
                       DESC
  s.homepage         = 'https://github.com/vvvirani/flutter_dyscan'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Vishal Virani' => 'vvvirani@gmail.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.dependency 'DyScan'
  s.platform = :ios, '9.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
