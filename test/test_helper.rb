ENV["RAILS_ENV"] ||= "test"
#require File.expand_path('test/testapp/config/environment')

require 'minitest/autorun'

#require 'rails'
#require 'rails/test_help'

require 'active_support'
require 'active_support/test_case'
require 'active_model'
require 'action_controller'
require 'action_controller/test_case'
require 'action_view'
require 'action_view/template'
require 'action_view/test_case'

require 'reformed'
require 'reformed/form_helper'

ActionView::Base.send :include, Reformed::FormHelper
ActionView::TestCase.send :include, Reformed::FormHelper

class ActiveSupport::TestCase

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  # fixtures :all

  # Add more helper methods to be used by all tests here...
end

class User
  include ActiveModel::Model
  attr_accessor :name
end
