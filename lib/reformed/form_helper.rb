require 'reformed/form_builder'

module Reformed
  module FormHelper

    def reform_for(record, options = {}, &block) 
      options[:builder] ||= Reformed::FormBuilder
      form_for(record, options, &block)
    end

    def reform_fields_for(record, options = {}, &block) 
      options[:builder] ||= Reformed::FormBuilder
      fields_for(record, options, &block)
    end

  end
end
