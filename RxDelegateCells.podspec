Pod::Spec.new do |s|
  s.name             = "RxDelegateCells"
  s.version          = "0.1.0"
  s.summary          = "UITableView Cell Height and UICollectionView Cell Size for RxSwift"
  s.homepage         = "https://github.com/devxoul/RxDelegateCells"
  s.license          = { :type => "MIT", :file => "LICENSE" }
  s.author           = { "Suyeol Jeon" => "devxoul@gmail.com" }
  s.source           = { :git => "https://github.com/devxoul/RxDelegateCells.git",
                         :tag => s.version.to_s }
  s.source_files     = "Sources/*.swift"
  s.requires_arc     = true

  s.dependency 'RxCocoa', '~> 2.5'
  s.dependency 'RxSwift', '~> 2.5'

  s.ios.deployment_target = "8.0"
  s.osx.deployment_target = "10.9"
end
