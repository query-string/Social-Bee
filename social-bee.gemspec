# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "social-bee/version"

Gem::Specification.new do |s|
  s.name        = "social-bee"
  s.version     = SocialBee::VERSION
  s.authors     = ["Alexander Timofeev"]
  s.email       = ["atimofeev@reactant.ru"]
  s.homepage    = "https://github.com/ATimofeev/Social-Bee"
  s.summary     = %q{Be social}
  s.description = %q{Simple messaging wrapper for Facebook, Twitter, Vkontakte}

  s.rubyforge_project = "social-bee"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  s.add_runtime_dependency "twitter"
  s.add_runtime_dependency "koala"
  s.add_runtime_dependency "vk-ruby"
end
