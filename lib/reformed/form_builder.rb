module Reformed
  class FormBuilder < ActionView::Helpers::FormBuilder
    include ActionView::Helpers::OutputSafetyHelper

    cattr_accessor :input_wrapper, :label_wrapper

    @@input_wrapper = lambda { |controls|
      "
        <div class='input-control'>#{controls[:label]} #{controls[:input]}
        </div>
      "
    }

    @@label_wrapper = lambda { |controls|
      "<span>#{controls[:label]}</span>"
    }
    
    def input(method, options = {}, &block)
      controls = {}
      controls[:input] = input_wrap(method, control_options(options, :input))
      controls[:label] = label_wrap(method, control_options(options, :label))
      controls[:hint] = hint_wrap(method, control_options(options, :hint))
      controls[:error] = error_wrap(method, control_options(options, :error))
      raw @@input_wrapper.call(controls)
    end

    def input_wrap(method, options, &block)
      text_field(method, options)
    end

    def label_wrap(method, options = {}, &block)
      @@label_wrapper.call(label: label(method, options = {}, &block))
    end

    def hint_wrap(method, options, &block)
      # TODO
    end

    def error_wrap(method, options, &block)
      # TODO
    end

    def reform_fields_for(record_or_name_or_array, *args, &block)
      options = args.extract_options!
      options[:builder] ||= self.class
      fields_for(record_or_name_or_array, *(args << options), &block)
    end

    private

    def control_options(options, type = nil)
      options[type.to_sym] || {}
    end

  end
end
