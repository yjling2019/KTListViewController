#
# Be sure to run `pod lib lint KTListViewController.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'KTListViewController'
  s.version          = '1.0.0'
  s.summary          = 'Standard ListViewController'
  s.description      = 'Standard listViewController, make list view easy to use!'

  s.homepage         = 'https://github.com/yjling2019/KTListViewController'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'KOTU' => 'yjling2019@gmail.com' }
  s.source           = { :git => 'https://github.com/yjling2019/KTListViewController.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'

  s.source_files = 'KTListViewController/Classes/**/*'

  s.user_target_xcconfig = {'CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES' => 'YES'}
  
  s.dependency 'Masonry'
  s.dependency 'KVOController'
  s.dependency 'MJRefresh'
  s.dependency 'KTUILibrary/Protocol'
  s.dependency 'KTFoundation/Category'
  
  s.subspec 'TextListView' do |sp|
	sp.source_files = 'KTListViewController/TextListView/**/*.{h,m}'
  end

end
