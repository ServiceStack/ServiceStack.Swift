Pod::Spec.new do |s|

s.name             = "ServiceStack"
s.version          = "1.0.0"
s.summary          = "The YNAP pod provides access to the YNAP platform"
s.description      = <<-DESC
                        ServiceStack DTO
                        DESC
s.homepage         = "https://github.com/ServiceStack/ServiceStack.Swift"
s.license          = 'Copyright (c) 2015 ServiceStack LLC. All rights reserved.'
s.author           = { "Demis Bellot" => "mythz@servicestack.com" }
s.source           = { :git => "https://github.com/ServiceStack/ServiceStack.Swift.git", :tag => s.version.to_s }

s.platforms = { :ios => "9.0" }
s.requires_arc = true

#s.public_header_files = 'Pod/Classes/**/*.h'
s.source_files = [
  'src/ServiceStackClient/ServiceStackClient/DateExtensions.swift',
  'src/ServiceStackClient/ServiceStackClient/DynamicJson.swift',
  'src/ServiceStackClient/ServiceStackClient/Json.swift',
  'src/ServiceStackClient/ServiceStackClient/JsonServiceClient.swift',
  'src/ServiceStackClient/ServiceStackClient/StringExtensions.swift'
]
#s.resources 		= 'Source/**/*.{bundle,png,lproj}'
#s.resource_bundles = { "ServiceStack" => ["Resources/*.lproj"] }

s.dependency 'PromiseKit'

end
