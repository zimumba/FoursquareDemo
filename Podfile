platform :ios, ’10.0’
use_frameworks!
inhibit_all_warnings!

def sharedPods
	pod 'SVProgressHUD'
	pod 'SDWebImage'
	pod 'FastEasyMapping'
	pod 'AFNetworking'
  pod 'KeychainSwift'

  pod 'SwiftGen'
end

target 'FoursquareDemo' do
	sharedPods
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['EXPANDED_CODE_SIGN_IDENTITY'] = ""
      config.build_settings['CODE_SIGNING_REQUIRED'] = "NO"
      config.build_settings['CODE_SIGNING_ALLOWED'] = "NO"
    end
  end
end

