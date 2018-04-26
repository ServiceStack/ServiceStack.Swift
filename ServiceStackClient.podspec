Pod::Spec.new do |s|

s.name             = "ServiceStackClient"
s.version          = "1.0.0"
s.summary          = "ServiceStackClient implementation in swift"
s.description      = <<-DESC
                        ServiceStack DTO
                        DESC
s.homepage         = "https://github.com/ServiceStack/ServiceStack.Swift"
s.license          = 'Copyright (c) 2018 ServiceStack, Inc. All rights reserved.'
s.author           = { "ServiceStack, Inc" => "team@servicestack.com" }
s.source           = { :git => "https://github.com/ServiceStack/ServiceStack.Swift.git", :tag => s.version.to_s }

s.ios.deployment_target = "8.3"
# s.osx.deployment_target = "10.9"
# s.watchos.deployment_target = "2.0"
# s.tvos.deployment_target = "9.0"
s.requires_arc = true

#s.public_header_files = 'Pod/Classes/**/*.h'
s.source_files  = "Sources/**/*"
#s.resources 		= 'Source/**/*.{bundle,png,lproj}'
#s.resource_bundles = { "ServiceStack" => ["Resources/*.lproj"] }

s.frameworks  = "Foundation"
s.dependency 'PromiseKit'

end
