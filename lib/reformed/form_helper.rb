require 'reformed/form_builder'

module Reformed
  module FormHelper

    def reform_for(record_or_name_or_array, *args, &proc)
      options = args.extract_options!
      options[:builder] ||= Reformed::FormBuilder
      form_for(record_or_name_or_array, *(args << options), &proc)
    end

    def reform_fields_for(record_or_name_or_array, *args, &block)
      options = args.extract_options!
      options[:builder] ||= Reformed::FormBuilder
      fields_for(record_or_name_or_array, *(args << options), &block)
    end

  end
end
