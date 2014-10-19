
Pod::Spec.new do |s|
  s.name             = "STNotificationHelper"
  s.version          = "1.0.0"
  s.summary          = "ViewController to describe the User how to turn on the Notifications on iOS7 and iOS8."
  s.description      = <<-DESC
                    ViewController to describe the User how to turn on the Notifications on iOS7 and iOS8.
                    Supports languages en, es, de, fr, id, it, pl, pt, ru, sv.
                    Origanally a fork of MHNotificationHelper (https://github.com/mariohahn/MHNotificationHelper/), but with iOS8 support and more languages.
                       DESC
  s.homepage         = "https://github.com/nmaletm/STNotificationHelper"
  s.screenshots      = "https://raw.githubusercontent.com/nmaletm/STNotificationHelper/master/Screenshots/screenshote-ios7.png", "https://raw.githubusercontent.com/nmaletm/STNotificationHelper/master/Screenshots/screenshote-ios8.png"
  s.license          = 'MIT'
  s.author           = { "Nestor Malet" => "nmaletm@gmail.com" }
  s.source           = { :git => "https://github.com/nmaletm/STNotificationHelper.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/NestorMalet'

  s.platform     = :ios, '6.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes'

  s.resource = "Pod/Assets/*"

  s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
  s.dependency "Masonry"
end
