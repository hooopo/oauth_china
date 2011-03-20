# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "oauth_china/version"

Gem::Specification.new do |s|
  s.name        = "oauth_china"
  s.version     = OauthChina::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Hooopo"]
  s.email       = ["hoooopo@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{新浪，豆瓣，腾讯等国内微薄OAuth认证}
  s.description = %q{新浪，豆瓣，腾讯等国内微薄OAuth认证}

  s.rubyforge_project = "oauth_china"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.add_development_dependency "oauth"
end