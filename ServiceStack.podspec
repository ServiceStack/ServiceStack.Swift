Pod::Spec.new do |s|

s.name             = "ServiceStack"
s.version          = "6.0.5"
s.summary          = "Swift ServiceStack Service Client"
s.description      = <<-DESC
                        ServiceStack's Add ServiceStack Reference feature lets iOS developers
                        generate an native typed Swift API for your ServiceStack Services
                        DESC
s.homepage         = "https://github.com/ServiceStack/ServiceStack.Swift"
s.license          = 'Copyright (c) 2013-present ServiceStack, Inc. All rights reserved.'
s.author           = { "ServiceStack, Inc" => "team@servicestack.com" }
s.source           = { :git => "https://github.com/ServiceStack/ServiceStack.Swift.git", :tag => s.version.to_s }

s.swift_version = "6.0"
s.ios.deployment_target = "16.0"
s.osx.deployment_target = "13.0"
#s.watchos.deployment_target = "8.0"
#s.tvos.deployment_target = "15.0"
s.requires_arc = true

#s.public_header_files = 'Pod/Classes/**/*.h'
s.source_files  = "Sources/**/*"
#s.resources 		= 'Source/**/*.{bundle,png,lproj}'
#s.resource_bundles = { "ServiceStack" => ["Resources/*.lproj"] }

s.frameworks  = "Foundation"

end
