module Reformed
  class FormBuilder < ActionView::Helpers::FormBuilder
    include ActionView::Helpers::OutputSafetyHelper

    cattr_accessor :input_wrapper, :label_wrapper, :html5, :error_wrapper

    @@html5 = true

    @@input_wrapper = lambda { |controls, options|
      "<div class=\"input-control\">#{controls[:label]} #{controls[:input]} #{controls[:error]} #{controls[:hint]}</div>"
    }

    @@label_wrapper = lambda { |controls, options|
      "<span>#{controls[:label]}</span>"
    }

    @@hint_wrapper = lambda { |message, options|
      "<span class=\"hint\">#{message}</span>"
    }

    @@error_wrapper = lambda { |message, options|
      "<span class=\"error\">#{message}</span>"
    }

    def input(method, options = {}, &block)
      controls = {}

      if options[:hint]
        controls[:hint] = hint_wrap(options.delete(:hint), control_options(options))
      end

      if options[:error]
        controls[:error] = error_wrap(options.delete(:error), control_options(options))
      end

      controls[:label] = label_wrap(method, control_options(options.merge(method: method), :label))

      controls[:input] = input_wrap(method, control_options(options))

      raw @@input_wrapper.call(controls, options)
    end

    def input_wrap(method, options, &block)
      whatami = options[:as] || as(method)
      options.delete(:as)

      case whatami
        when :string   then text_field      method, options
        when :text     then text_area       method, options
        when :file     then file_field      method, options
        when :string   then text_field      method, options
        when :password then password_field  method, options
        when :radio    then radio_button    method, options[:choices], options
        when :boolean  then check_box       method, options
        when :url      then url_field       method, options
        when :email    then email_field     method, options
        when :phone    then phone_field     method, options
        when :number   then number_field    method, options
        when :date     then date_select     method, options, options.delete(:html) || {}
        when :time     then time_select     method, options, options.delete(:html) || {}
        when :datetime then datetime_select method, options, options.delete(:html) || {}
        when :select   then select          method, options[:choices], options, options.delete(:html) || {}
        when :hidden   then hidden_field    method, options
      end
    end

    def label_wrap(method, options = {}, &block)
      label_text = options.delete(:label) if options[:label]
      if label_text
        @@label_wrapper.call({label: label(method, label_text, options, &block)}, options)
      else
        @@label_wrapper.call({label: label(method, options[:label], &block)}, options)
      end
    end

    def hint_wrap(str, options, &block)
      @@hint_wrapper.call(str, options)
    end

    def error_wrap(str, options, &block)
      @@error_wrapper.call(str, options)
    end

    def reform_fields_for(record_or_name_or_array, *args, &block)
      options = args.extract_options!
      options[:builder] ||= self.class
      fields_for(record_or_name_or_array, *(args << options), &block)
    end

    def html5?
      @@html5
    end

    private

    def as(method)

      # determine the field type
      case "#{method}"
        when /url/      then return (html5? ? :url : :string)
        when /email/    then return (html5? ? :email : :string)
        when /phone/    then return (html5? ? :phone : :string)
        when /password/ then return :password
      end

      case infer_type(method)
        when :radio     then return :radio
        when :string    then return :string
        when :boolean   then return :boolean
        when :integer   then return :number
        when :float     then return :number
        when :decimal   then return :number
        when :timestamp then return :datetime
        when :datetime  then return :datetime
        when :date      then return :date
        when :time      then return :time
        when :text      then return :text
        else method.to_sym
      end

    end

    def infer_type(method)
      column = @object.column_for_attribute(method) if @object.respond_to?(:column_for_attribute)
      return column.type
    end

    def control_options(options, type = nil)
      if type == :label
        {label: options[:label]}
      elsif type
        options[type.to_sym] || {}
      else
        options
      end
    end

  end
end
