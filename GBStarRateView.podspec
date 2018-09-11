Pod::Spec.new do |s|

  s.name         = "GBStarRateView"
  s.version      = "1.0.0"
  s.summary      = "star score like comment"

  s.homepage     = "https://github.com/belin11/GBStarRateView"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"


   s.license     = { :type => "MIT", :file => "LICENSE" }


  s.authors      = { "belin11" => "2665010262@qq.com" }

  s.platform     = :ios, "7.0"

  s.ios.deployment_target = "7.0"

  s.source       = { :git => "https://github.com/belin11/GBStarRateView.git", :tag => s.version }

  s.public_header_files = 'GBStarRateView/*.h'
  s.source_files = 'GBStarRateView'
  s.requires_arc = true

end
