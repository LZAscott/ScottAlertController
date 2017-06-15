
Pod::Spec.new do |s|
  s.name         = "ScottAlertController"
  s.version      = "0.0.2"
  s.summary      = "一款可高度自定义的提示框"
  s.homepage     = "https://github.com/LZAscott/ScottAlertController"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Scott_Mr" => "a632845514@vip.qq.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/LZAscott/ScottAlertController.git", :tag => s.version }

  s.source_files  = "ScottAlertController", "ScottAlertController/**/*.{h,m}"
  
  s.requires_arc = true

  s.subspec 'Category' do |category|
    category.source_files = 'ScottAlertController/Category/**/*'
  end

  s.subspec 'ScottAlertAnimations' do |animations|
    animations.source_files = 'ScottAlertController/ScottAlertAnimations/**/*'
  end

  s.subspec 'ScottAlertView' do |alertView|
    alertView.source_files = 'ScottAlertController/ScottAlertView/**/*'
  end

end
