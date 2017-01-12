require 'active_support/log_subscriber'

module LDAPR
  module Instrumentation

    # LogSubscriber to log LDAPR request URLs and timings
    #
    class LogSubscriber < ActiveSupport::LogSubscriber
      def request(event)
        self.class.runtime += event.duration

        info 'LDAPR: %s %s (%.1fms)' % [
          event.payload[:method].upcase,
          event.payload[:url],
          event.duration,
        ]
      end

      class << self
        def runtime=(value)
          Thread.current[:ldapr_runtime] = value
        end

        def runtime
          Thread.current[:ldapr_runtime] ||= 0
        end

        def reset_runtime
          rt, self.runtime = runtime, 0
          rt
        end
      end
    end

    # ActionController Instrumentation to log time spent in LDAPR
    # requests at the bottom of log messages.
    #
    module ControllerRuntime
      extend ActiveSupport::Concern

      attr_internal :ldapr_runtime

      def append_info_to_payload(payload)
        super
        payload[:ldapr_runtime] = (ldapr_runtime || 0) + LDAPR::Instrumentation::LogSubscriber.runtime
      end
      protected :append_info_to_payload

      def cleanup_view_runtime
        ldapr_rt_before_render = LDAPR::Instrumentation::LogSubscriber.reset_runtime
        runtime = super
        ldapr_rt_after_render = LDAPR::Instrumentation::LogSubscriber.reset_runtime
        self.ldapr_runtime = ldapr_rt_before_render + ldapr_rt_after_render
        runtime - ldapr_rt_after_render
      end
      protected :cleanup_view_runtime

      module ClassMethods
        def log_process_action(payload)
          messages, ldapr_runtime = super, payload[:ldapr_runtime]
          messages << ("LDAPR: %.1fms" % ldapr_runtime.to_f) if ldapr_runtime
          messages
        end
      end

    end
  end
end
