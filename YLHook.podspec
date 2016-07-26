Pod::Spec.new do |s|
s.name = 'YLHook'
s.version = '0.9'
s.license = 'MIT'
s.summary = 'A delightful library inspired by Functional Programming for AOP based Aspects.'
s.homepage = 'https://github.com/ypli-chn/YLHook'
s.authors = { "Yunpeng Li" => "ypli.chn@outlook.com" }
s.source = { :git => 'https://github.com/ypli-chn/YLHook.git', :tag => s.version.to_s }
s.requires_arc = true
s.ios.deployment_target = '7.0'
s.source_files = '*.{h,m}'
s.dependency 'Aspects', '~> 1.4.1'
end