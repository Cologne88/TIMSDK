Pod::Spec.new do |spec|
  spec.name         = 'TUITranslationPlugin'
  spec.version      = '7.4.4643'
  spec.platform     = :ios
  spec.ios.deployment_target = '9.0'
  spec.license      = { :type => 'Proprietary',
      :text => <<-LICENSE
        copyright 2017 tencent Ltd. All rights reserved.
        LICENSE
       }
  spec.homepage     = 'https://cloud.tencent.com/document/product/269/3794'
  spec.documentation_url = 'https://cloud.tencent.com/document/product/269/9147'
  spec.authors      = 'tencent video cloud'
  spec.summary      = 'TUITranslationPlugin'
  spec.xcconfig     = { 'VALID_ARCHS' => 'armv7 arm64 x86_64', }

  spec.requires_arc = true

  spec.source = { :http => 'https://im.sdk.cloud.tencent.cn/download/tuikit/7.4.4643/ios/TUITranslationPlugin.zip'}

  spec.subspec 'CommonModel' do |commonModel|
    commonModel.source_files = '**/TUITranslationPlugin/CommonModel/*.{h,m,mm}'
    commonModel.dependency 'TUICore','7.4.4643'
    commonModel.dependency 'TIMCommon','7.4.4643'
    commonModel.dependency 'TUIChat','7.4.4643'
  end

  spec.subspec 'UI' do |commonUI|
    commonUI.subspec 'DataProvider' do |dataProvider|
      dataProvider.source_files = '**/TUITranslationPlugin/UI/DataProvider/*.{h,m,mm}'
      dataProvider.dependency "TUITranslationPlugin/CommonModel"
    end
    commonUI.subspec 'UI' do |subUI|
      subUI.source_files = '**/TUITranslationPlugin/UI/UI/*.{h,m,mm}'
      subUI.dependency "TUITranslationPlugin/UI/DataProvider"
    end
    commonUI.subspec 'Service' do |service|
      service.source_files = '**/TUITranslationPlugin/UI/Service/*.{h,m,mm}'
      service.dependency "TUITranslationPlugin/UI/UI"
    end
    commonUI.resource = [
      '**/TUITranslationPlugin/Resources/*.bundle'
    ]
  end

  spec.pod_target_xcconfig = {
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64',
    'GENERATE_INFOPLIST_FILE' => 'YES'
  }
  spec.user_target_xcconfig = { 
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64',
    'GENERATE_INFOPLIST_FILE' => 'YES'
  }
end

# pod trunk push TUITranslationPlugin.podspec --use-libraries --allow-warnings