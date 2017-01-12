Gem::Specification.new do |s|
  s.name                    = "ldapr-client"
  s.version                 = "0.1.0"
  s.summary                 = "A simple client to consume LDAPR API"
  s.description             = "A simple client to consume LDAPR API"

  s.authors                 = ["Thimios Dimopulos"]
  s.email                   = ["e.dimopoulos@ifad.org"]
  s.homepage                = "https://github.com/ifad/ldapr-client"

  s.files                   = `git ls-files`.split("\n")
  s.require_paths           = ["lib"]

  s.add_dependency("activesupport", ">= 3.0")
  s.add_dependency("typhoeus", ">= 0.6")
  s.add_dependency("multi_json")
  s.add_dependency("ethon")
  s.add_dependency("hawk")

  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'dotenv'
  s.add_development_dependency 'vcr'
  s.add_development_dependency 'yard'
  s.add_development_dependency 'pry'

  s.add_development_dependency(
    case RUBY_VERSION.to_f
    when 1.8 then 'ruby-debug'
    when 1.9 then 'ruby-debug19'
    else 'byebug'
    end
  )
end
