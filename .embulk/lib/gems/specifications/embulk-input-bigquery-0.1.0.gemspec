# -*- encoding: utf-8 -*-
# stub: embulk-input-bigquery 0.1.0 ruby lib

Gem::Specification.new do |s|
  s.name = "embulk-input-bigquery".freeze
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["potato2003".freeze, "Naotoshi Seo".freeze, "Takeru Narita".freeze]
  s.date = "2022-10-08"
  s.description = "embulk input plugin from bigquery.".freeze
  s.email = ["potato2003@gmail.com".freeze, "sonots@gmail.com".freeze, "naritano77@gmail.com".freeze]
  s.homepage = "https://github.com/medjed/embulk-input-bigquery".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.6.14".freeze
  s.summary = "Embulk input plugin from bigquery.".freeze

  s.installed_by_version = "2.6.14" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<signet>.freeze, ["< 0.12.0", "~> 0.7"])
      s.add_runtime_dependency(%q<google-api-client>.freeze, ["< 0.33.0"])
      s.add_runtime_dependency(%q<google-cloud-env>.freeze, ["< 1.3.0"])
      s.add_runtime_dependency(%q<google-cloud-core>.freeze, ["< 1.4.0"])
      s.add_runtime_dependency(%q<google-cloud-bigquery>.freeze, ["< 1.12", ">= 1.2"])
      s.add_development_dependency(%q<bundler>.freeze, ["~> 1.3"])
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
    else
      s.add_dependency(%q<signet>.freeze, ["< 0.12.0", "~> 0.7"])
      s.add_dependency(%q<google-api-client>.freeze, ["< 0.33.0"])
      s.add_dependency(%q<google-cloud-env>.freeze, ["< 1.3.0"])
      s.add_dependency(%q<google-cloud-core>.freeze, ["< 1.4.0"])
      s.add_dependency(%q<google-cloud-bigquery>.freeze, ["< 1.12", ">= 1.2"])
      s.add_dependency(%q<bundler>.freeze, ["~> 1.3"])
      s.add_dependency(%q<rake>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<signet>.freeze, ["< 0.12.0", "~> 0.7"])
    s.add_dependency(%q<google-api-client>.freeze, ["< 0.33.0"])
    s.add_dependency(%q<google-cloud-env>.freeze, ["< 1.3.0"])
    s.add_dependency(%q<google-cloud-core>.freeze, ["< 1.4.0"])
    s.add_dependency(%q<google-cloud-bigquery>.freeze, ["< 1.12", ">= 1.2"])
    s.add_dependency(%q<bundler>.freeze, ["~> 1.3"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
  end
end
