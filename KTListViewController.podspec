#
# Be sure to run `pod lib lint KTListViewController.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'KTListViewController'
  s.version          = '1.0.1'
  s.summary          = 'Standard ListViewController'
  s.description      = 'Standard listViewController, make list view easy to use!'

  s.homepage         = 'https://github.com/yjling2019/KTListViewController'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'KOTU' => 'yjling2019@gmail.com' }
  s.source           = { :git => 'https://github.com/yjling2019/KTListViewController.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'

  s.user_target_xcconfig = {'CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES' => 'YES'}
  

  
  s.subspec 'Base' do |sp|
	sp.source_files = 'KTListViewController/Base/**/*'
	sp.dependency 'Masonry'
	sp.dependency 'KVOController'
	sp.dependency 'MJRefresh'
	sp.dependency 'KTUILibrary/Protocol'
	sp.dependency 'KTFoundation/Category'
  end
  
  s.subspec 'TextListView' do |sp|
	sp.source_files = 'KTListViewController/TextListView/**/*.{h,m}'
	sp.dependency 'KTListViewController/Base'
  end

end
