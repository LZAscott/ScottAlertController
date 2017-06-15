
Pod::Spec.new do |s|
  s.name         = "ScottAlertController"
  s.version      = "0.0.5"
  s.summary      = "一款可高度自定义的提示框"
  s.homepage     = "https://github.com/LZAscott/ScottAlertController"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Scott_Mr" => "a632845514@vip.qq.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/LZAscott/ScottAlertController.git", :tag => s.version }

  s.source_files  = "ScottAlertController", "ScottAlertViewDemo/ScottAlertController/**/*.{h,m}"
  
  s.requires_arc = true

end
