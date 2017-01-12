require 'rails/railtie'

module LDAPR
  class Railtie < ::Rails::Railtie

    initializer 'ldapr.setup_instrumentation' do
      require 'ldapr/instrumentation'

      LDAPR::Instrumentation::LogSubscriber.attach_to :ldapr

      ActiveSupport.on_load(:action_controller) do
        include LDAPR::Instrumentation::ControllerRuntime
      end
    end

  end
end
