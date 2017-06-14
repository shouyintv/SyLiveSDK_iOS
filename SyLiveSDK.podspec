#
# Be sure to run `pod lib lint PLCameraStreamingKit.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "SyLiveSDK"
  s.version          = "0.1.0"
  s.summary          = "tv.shouyin.showing.open.sdk"
  s.homepage         = "http://code.shanggou.la/ios/openSDK"
  s.license          = 'Apache License, Version 2.0'
  s.author           = { "SyLiveSDK" => "http://www.quanmin.tv" }
  s.source           = { :git => "https://github.com/shouyintv/SyLiveSDK_iOS.git", :tag => "v#{s.version}" }

  s.platform     = :ios
  s.ios.deployment_target = '8.0'
  s.requires_arc = true  

  s.frameworks = 'UIKit','Foundation','CoreFoundation','CoreLocation','WebKit', 'AVFoundation', 'CoreGraphics', 
    'CFNetwork', 'AudioToolbox', 'CoreMedia', 'VideoToolbox','ImageIO','CoreTelephony','CoreMotion','AssetsLibrary','EventKit',
    'MessageUI','MobileCoreServices','JavaScriptCore','StoreKit','SystemConfiguration','Security'

  s.weak_framework = 'AdSupport','UserNotifications'

  s.libraries = 'z', 'c++', 'icucore', 'sqlite3','iconv'       #依赖的系统类库

  s.vendored_frameworks = 'Pod/Library/*.framework'

  s.resources =  ['Pod/Assets/SyLiveResource.bundle', 'Pod/Assets/SyLiveXib.bundle','Pod/Assets/NIMKitResouce.bundle']


  #SyLiveSDK self依赖库
  s.dependency 'AMapLocation', '2.3.1'
  s.dependency 'ProtocolBuffers', '1.9.11'
  s.dependency 'NIMSDK_LITE', '3.4.1'
  s.dependency 'SDWebImage', '~> 3.7.5'
  s.dependency 'SVProgressHUD', '~> 2.1.2'
  s.dependency 'CocoaLumberjack', '~> 2.3.0'
  s.dependency 'SSZipArchive'
  s.dependency 'LDNetDiagnoService'
  s.dependency 'UMengAnalytics', '~> 4.1.10'
  s.dependency 'MJExtension', '~> 3.0.10'
  s.dependency 'MJRefresh', '~> 3.1.0'
  s.dependency 'SDCycleScrollView', '~> 1.64'
  s.dependency 'GTSDK', '~> 1.6.2'
  s.dependency 'FMDB/standard'
  s.dependency 'AFNetworking', '~> 3.1.0'
  s.dependency 'Reachability', '~> 3.2'
  s.dependency 'YYKit', '~> 1.0.9'
  s.dependency 'FCFileManager', '~> 1.0.17'
  s.dependency 'libextobjc', '~> 0.4.1'
  s.dependency 'Masonry', '~> 1.0.1'
  # s.dependency 'Bugly', '~> 2.4.8'
# #友盟
#   s.dependency 'UMengUShare/UI'
#   s.dependency 'UMengUShare/Social/WeChat'
#   s.dependency 'UMengUShare/Social/QQ'
#   s.dependency 'UMengUShare/Social/Sina'
#   s.dependency 'UMengUShare/Plugin/IDFA'  

  #针对推流拉流的sdk
  s.dependency 'pili-librtmp', '1.0.6'
  s.dependency 'HappyDNS', '0.3.10'
  s.dependency 'QNNetDiag', '0.0.4'


  s.subspec "StreamSDK" do |ss1|
    ss1.source_files = 'Pod/Library/StreamSDK/include/*/*.h'
    ss1.vendored_libraries = 'Pod/Library/StreamSDK/*.a'   #依赖的第三方静态库
  end

  s.subspec "ZMSDK" do |ss2|
    ss2.source_files = 'Pod/Library/ZMSDK/livenessModel/*.{h,m}'
    ss2.resources = 'Pod/Library/ZMSDK/*.bundle'
    ss2.vendored_frameworks = 'Pod/Library/ZMSDK/*.framework'
  end

end
