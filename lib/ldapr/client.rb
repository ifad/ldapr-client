require 'pathname'
require 'active_support/inflector'

module LDAPR
  autoload :Base,                 'ldapr/base.rb'
  autoload :Entry,                'ldapr/models/entry.rb'

  module Client
    extend self

    def self.configure &block
      Base.configure &block
      self
    end
  end
end
