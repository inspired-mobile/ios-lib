Pod::Spec.new do |s|
  s.name         = "byInspired"
  s.version      = "1.0.1"
  s.summary      = "byinspired SDK by Inspire Mobile LTD, for easy adverts creation."


  s.description  =  "byInspired powered by Mraid.JS  by inspire Mobile for iOS/iPhone for JS Adverts"

  s.homepage     = "https://github.com/hexims/byInspired/"

  s.license      = "MIT"

  s.author             = { "hexims" => "ashish@hexims.it" }


  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If this Pod runs only on iOS or OS X, then specify the platform and
  #  the deployment target. You can optionally include the target after the platform.
  #
    s.platform     = :ios, "11.0"



  s.source       = { :git => "https://github.com/hexims/byInspired.git", :tag => "1.0.1" }


  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  CocoaPods is smart about how it includes source code. For source files
  #  giving a folder will include any swift, h, m, mm, c & cpp files.
  #  For header files it will include any header in the folder.
  #  Not including the public_header_files will make all headers public.
  #

  s.source_files  = "byInspired/**/*"
 

end
