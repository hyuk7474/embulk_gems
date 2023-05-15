# -*- encoding: utf-8 -*-
# stub: time_with_zone 0.3.1 ruby lib

Gem::Specification.new do |s|
  s.name = "time_with_zone".freeze
  s.version = "0.3.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["sonots".freeze]
  s.bindir = "exe".freeze
  s.date = "2016-10-31"
  s.description = "Handle time with zone withtout ActiveSupport or ENV['TZ']".freeze
  s.email = ["sonots@gmail.com".freeze]
  s.homepage = "https://github.com/sonots/time_with_zone".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.6.14".freeze
  s.summary = "Handle time with zone withtout ActiveSupport or ENV['TZ']".freeze

  s.installed_by_version = "2.6.14" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<tzinfo>.freeze, [">= 0"])
      s.add_development_dependency(%q<bundler>.freeze, ["~> 1.11"])
      s.add_development_dependency(%q<rake>.freeze, ["~> 10.0"])
    else
      s.add_dependency(%q<tzinfo>.freeze, [">= 0"])
      s.add_dependency(%q<bundler>.freeze, ["~> 1.11"])
      s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
    end
  else
    s.add_dependency(%q<tzinfo>.freeze, [">= 0"])
    s.add_dependency(%q<bundler>.freeze, ["~> 1.11"])
    s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
  end
end
