Pod::Spec.new do |spec|
spec.name         = "CZKit"
spec.version      = "0.2.0"
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

# Core
spec.subspec 'Core' do |core|
core.source_files = 'CZKit/Core/*.swift'
core.dependency 'SnapKit'
core.dependency 'SwifterSwift'
end

# UIImageView+Kingfisher
spec.subspec 'UIImageView+Kingfisher' do |kf|
kf.source_files = 'CZKit/UIImageView+Kingfisher/*.swift'
kf.dependency 'Kingfisher'
end

# UIScrollView+MJRefresh
spec.subspec 'UIScrollView+MJRefresh' do |mj|
mj.source_files = 'CZKit/UIScrollView+MJRefresh/*.swift'
mj.dependency 'MJRefresh'
end

spec.frameworks = 'UIKit', 'Foundation', 'WebKit', 'Photos', 'AudioToolbox'

end
