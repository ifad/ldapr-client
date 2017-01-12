require 'ldapr/railtie' if defined?(Rails)

require 'ldapr/client'

module LDAPR
  def self.configure(&block)
    Client.configure(&block)
  end
end
