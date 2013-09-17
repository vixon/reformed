require 'reformed'
require "reformed/form_helper"
require 'rails/railtie'

module Reformed
  class Railtie < Rails::Railtie
    initializer 'reformed.initialize' do
      ActionView::Base.send :include, Reformed::FormHelper
    end
  end
end
