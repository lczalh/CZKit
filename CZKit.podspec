Pod::Spec.new do |spec|
spec.name         = "CZKit"
spec.version      = "1.0.0"
spec.summary      = "Swift 工具箱"
spec.description  = <<-DESC
TODO: Swift 工具箱.
DESC

spec.homepage     = "https://github.com/lczalh/CZKit"
spec.license      = "MIT"
spec.author             = { "lczalh" => "824092805@qq.com" }

spec.ios.deployment_target = "10.0"
spec.swift_version = ['5.0']
spec.source       = { :git => "https://github.com/lczalh/CZKit.git", :tag => spec.version.to_s }
spec.source_files = 'CZKit/ChainKit/*.swift', 'CZKit/Extension/*.swift', 'CZKit/Manage/*.swift', 'CZKit/Ui/*.swift', 'CZKit/ChainKit+SnapKit/*.swift'


spec.frameworks = 'UIKit', 'Foundation', 'WebKit', 'Photos', 'AudioToolbox', 'AppTrackingTransparency', 'AdSupport'

spec.dependency 'SnapKit'
end
