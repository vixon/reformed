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
      controls[:label] = label_wrap(method, control_options(options.merge(method: method), :label))
      controls[:hint] = hint_wrap(method, control_options(options, :hint))
      controls[:error] = error_wrap(method, control_options(options, :error))
      raw @@input_wrapper.call(controls)
    end

    def input_wrap(method, options, &block)

      whatami = options[:as] || as(method)

      case whatami
        when :string   then text_field      method, options
        when :text     then text_area       method, options
        when :file     then file_field      method, options
        when :string   then text_field      method, options
        when :password then password_field  method, options
        when :boolean  then check_box       method, options
        when :url      then url_field       method, options
        when :email    then email_field     method, options
        when :phone    then phone_field     method, options
        when :number   then number_field    method, options
        when :country  then country_select  method, options
        when :date     then date_select     method, options, options[:input].delete(:html) || {}
        when :time     then time_select     method, options, options[:input].delete(:html) || {}
        when :datetime then datetime_select method, options, options[:input].delete(:html) || {}
        when :select   then select          method, options[:choices], options, options[:input].delete(:html) || {}
        when :hidden   then hidden_field    method, options
      end
    end

    def label_wrap(method, options = {}, &block)
      label_text = options.delete(:label) if options[:label]
      if label_text
        @@label_wrapper.call(label: label(method, label_text, options, &block))
      else
        @@label_wrapper.call(label: label(method, options[:label], &block))
      end
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

    def as(method)
      
      # determine the field type
      case "#{method}"
        when /url/      then return :url
        when /email/    then return :email
        when /phone/    then return :phone
        when /password/ then return :password
      end

      case infer_type(method)
        when :string    then return :string
        when :integer   then return :number
        when :float     then return :number
        when :decimal   then return :number
        when :timestamp then return :datetime
        when :datetime  then return :datetime
        when :date      then return :date
        when :time      then return :time
        when :text      then return :text
      end

    end

    def infer_type(method)
      column = @object.column_for_attribute(method) if @object.respond_to?(:column_for_attribute)
      return column.type
    end

    def control_options(options, type = nil)
      if type == :label
        {label: options[:label]}
      else
        options[type.to_sym] || {}
      end
    end

  end
end
