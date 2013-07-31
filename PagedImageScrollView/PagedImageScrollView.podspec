Pod::Spec.new do |s|
  s.name         = "PagedImageScrollView"
  s.version      = "0.0.1"
  s.summary      = "It can easily generate imagescrollview with pagecontrol, swipe two fingers can switch the image."
  s.homepage     = "https://github.com/jianpx/ios-cabin/tree/master/PagedImageScrollView"
  s.license      = 'MIT'
  s.author       = { "jianpx" => "jianpx86@gmail.com" }
  s.source       = { :git => "https://github.com/jianpx/ios-cabin.git", :tag => "0.0.1" }
  s.platform     = :ios, '5.0'
  s.source_files = 'PagedImageScrollView/*.{h,m}'
  s.requires_arc = true
end
