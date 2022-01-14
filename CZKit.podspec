Pod::Spec.new do |spec|
spec.name         = "CZKit"
spec.version      = "0.0.1"
spec.summary      = "Swift 工具箱"
spec.description  = <<-DESC
TODO: Swift 工具箱.
DESC

spec.homepage     = "https://github.com/lczalh/CZKit"
spec.license      = "MIT"
spec.author             = { "lczalh" => "824092805@qq.com" }

spec.ios.deployment_target = "12.0"
spec.swift_version = ['5.0']
spec.source       = { :git => "https://github.com/lczalh/CZKit.git", :tag => spec.version.to_s }

spec.subspec 'CZCore' do |cz|
    cz.source_files = 'CZKit/ChainKit', 'CZKit/Manage', 'CZKit/Extension'
end

spec.subspec 'CZUi' do |cz|
    cz.source_files = 'CZKit/ChainKit+SnapKit', 'CZKit/Ui'
    cz.dependency 'SnapKit', '~> 5.0.1'
    cz.dependency 'CZKit/CZCore'
end

spec.subspec 'CZMJRefreshExtension' do |cz|
    cz.source_files = 'CZKit/MJRefresh'
    cz.dependency 'MJRefresh', '~> 3.6.1'
end

spec.subspec 'CZKingfisherExtension' do |cz|
    cz.source_files = 'CZKit/Kingfisher'
    cz.dependency 'Kingfisher', '~> 7.0.0'
end

spec.subspec 'CZHud' do |cz|
    cz.source_files = 'CZKit/Hud'
    cz.dependency 'SVProgressHUD', '~> 2.2.5'
end

spec.frameworks = 'UIKit', 'Foundation', 'WebKit', 'Photos', 'AudioToolbox', 'AppTrackingTransparency', 'AdSupport'

spec.dependency 'SnapKit'
end
