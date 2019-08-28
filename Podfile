# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Tapet' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Tapet
  pod 'Alamofire'
  pod 'ObjectMapper+Realm'
  pod 'SwiftyJSON'
  pod 'MBProgressHUD'
  pod 'TransitionButton'
  pod 'SDWebImage', '~> 4.0'
  pod 'NVActivityIndicatorView'
  pod 'Hero'
  pod 'Google-Mobile-Ads-SDK'
  
  post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['SWIFT_VERSION'] = '4.2'  # required by simple_permission
        config.build_settings['ENABLE_BITCODE'] = 'NO'
      end
    end
  end
#  pod 'SimpleCheckbox' /
#  pod 'LiquidLoader'
#  pod 'Whisper'

  target 'TapetTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'TapetUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end
