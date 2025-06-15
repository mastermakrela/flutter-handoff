#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint handoff.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'handoff'
  s.version          = '0.0.1'
  s.summary          = 'A Flutter plugin for iOS Handoff URL functionality'
  s.description      = <<-DESC
A Flutter plugin that enables iOS Handoff functionality to share URLs between devices.
                       DESC
  s.homepage         = 'https://github.com/mastermakrela/flutter-handoff'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'mastermakrela' => 'github@mastermakrela.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '11.0'
  s.ios.deployment_target = '11.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'

  # If your plugin requires a privacy manifest, for example if it uses any
  # required reason APIs, update the PrivacyInfo.xcprivacy file to describe your
  # plugin's privacy impact, and then uncomment this line. For more information,
  # see https://developer.apple.com/documentation/bundleresources/privacy_manifest_files
  # s.resource_bundles = {'handoff_privacy' => ['Resources/PrivacyInfo.xcprivacy']}
end
