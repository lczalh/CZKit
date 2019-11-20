Pod::Spec.new do |spec|
  spec.name         = "CZKit"
  spec.version      = "0.0.1"
  spec.summary      = "Swift 工具箱"
  spec.description  = <<-DESC
                            TODO: Swift 开发组件：项目开发通用&非通用型模块代码，多功能组件，可快速集成使用以大幅减少基础工作量；便利性扩展&链式扩展附.各种类库使用示例demo.
                        DESC

  spec.homepage     = "https://github.com/lczalh/CZKit"
  spec.license      = { :type => "MIT", :file => "FILE_LICENSE" }
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
    date.dependency 'CZKit/Core'
  end
  
  spec.frameworks = 'UIKit', 'Foundation'

end
