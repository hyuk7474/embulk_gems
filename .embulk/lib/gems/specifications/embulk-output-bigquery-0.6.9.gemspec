# -*- encoding: utf-8 -*-
# stub: embulk-output-bigquery 0.6.9 ruby lib

Gem::Specification.new do |s|
  s.name = "embulk-output-bigquery".freeze
  s.version = "0.6.9"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Satoshi Akama".freeze, "Naotoshi Seo".freeze]
  s.date = "2023-03-17"
  s.description = "Embulk plugin that insert records to Google BigQuery.".freeze
  s.email = ["satoshiakama@gmail.com".freeze, "sonots@gmail.com".freeze]
  s.homepage = "https://github.com/embulk/embulk-output-bigquery".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.6.14".freeze
  s.summary = "Google BigQuery output plugin for Embulk".freeze

  s.installed_by_version = "2.6.14" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<signet>.freeze, ["< 0.12.0", "~> 0.7"])
      s.add_runtime_dependency(%q<google-api-client>.freeze, ["< 0.33.0"])
      s.add_runtime_dependency(%q<time_with_zone>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<representable>.freeze, ["< 3.1", "~> 3.0.0"])
      s.add_runtime_dependency(%q<faraday>.freeze, ["~> 0.12"])
      s.add_development_dependency(%q<bundler>.freeze, [">= 1.10.6"])
      s.add_development_dependency(%q<rake>.freeze, [">= 10.0"])
    else
      s.add_dependency(%q<signet>.freeze, ["< 0.12.0", "~> 0.7"])
      s.add_dependency(%q<google-api-client>.freeze, ["< 0.33.0"])
      s.add_dependency(%q<time_with_zone>.freeze, [">= 0"])
      s.add_dependency(%q<representable>.freeze, ["< 3.1", "~> 3.0.0"])
      s.add_dependency(%q<faraday>.freeze, ["~> 0.12"])
      s.add_dependency(%q<bundler>.freeze, [">= 1.10.6"])
      s.add_dependency(%q<rake>.freeze, [">= 10.0"])
    end
  else
    s.add_dependency(%q<signet>.freeze, ["< 0.12.0", "~> 0.7"])
    s.add_dependency(%q<google-api-client>.freeze, ["< 0.33.0"])
    s.add_dependency(%q<time_with_zone>.freeze, [">= 0"])
    s.add_dependency(%q<representable>.freeze, ["< 3.1", "~> 3.0.0"])
    s.add_dependency(%q<faraday>.freeze, ["~> 0.12"])
    s.add_dependency(%q<bundler>.freeze, [">= 1.10.6"])
    s.add_dependency(%q<rake>.freeze, [">= 10.0"])
  end
end
