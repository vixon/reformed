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
    
    def wrap(method, options = {}, &block)
      controls = {}
      controls[:input] = text_field(method, extract_options(options, :input))
      controls[:label] = label_wrap(method, extract_options(options, :label))
      controls[:hint] = hint(method, extract_options(options, :hint))
      controls[:error] = error(method, extract_options(options, :error))

      @@input_wrapper.call(controls)
    end

    def input_wrap(method, options, &block)

    end

    def hint_wrap(method, options, &block)

    end

    def error_wrap(method, options, &block)

    end

    def label_wrap(method, options = {}, &block)
      @@label_wrapper.call(label: label(method, options = {}, &block))
    end

    def extract_options(options, type = nil)
      options[type.to_sym] || {}
    end

    def input(method, options = {})
      raw wrap(method, options)
    end

    def hint(method, options = {})

    end

    def error(method, options = {})

    end

    def reform_fields_for(record_or_name_or_array, *args, &block)
      options = args.extract_options!
      options[:builder] ||= self.class
      fields_for(record_or_name_or_array, *(args << options), &block)
    end

  end
end
