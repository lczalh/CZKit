Pod::Spec.new do |spec|
  spec.name         = "CZKit"
  spec.version      = "0.0.2"
  spec.summary      = "Swift 工具箱"
  spec.description  = <<-DESC
                            TODO: Swift 开发组件.
                        DESC

  spec.homepage     = "https://github.com/lczalh/CZKit"
  spec.license      = "MIT"
  spec.author             = { "lczalh" => "824092805@qq.com" }

  spec.ios.deployment_target = "10.0"
  spec.swift_version = ['5.0']
  spec.source       = { :git => "https://github.com/lczalh/CZKit.git", :tag => spec.version.to_s }
  
  # Core
  spec.subspec 'Core' do |core|
    core.source_files = 'CZKit/Core/*.swift'
  end
  
  # ChainKit
  spec.subspec 'ChainKit' do |ck|
    ck.source_files = 'CZKit/ChainKit/*.swift'
    ck.dependency 'CZKit/Core'
  end
  
  # ChainKit+SnapKit
  spec.subspec 'ChainKit+SnapKit' do |cksk|
    cksk.source_files = 'CZKit/ChainKit+SnapKit/*.swift'
    cksk.dependency 'CZKit/ChainKit'
    cksk.dependency 'SnapKit'
  end
  
  # Date
  spec.subspec 'Date' do |date|
    date.source_files = 'CZKit/Date/*.swift'
    date.dependency 'CZKit/ChainKit'
  end
  
  # UI
  spec.subspec 'UI' do |ui|
    ui.source_files = 'CZKit/UI/*.swift'
    ui.dependency 'CZKit/ChainKit'
  end
  
  spec.frameworks = 'UIKit', 'Foundation'

end
