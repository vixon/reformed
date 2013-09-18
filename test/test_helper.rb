ENV["RAILS_ENV"] ||= "test"
#require File.expand_path('test/testapp/config/environment')

require 'minitest/autorun'

#require 'rails'
#require 'rails/test_help'

require 'active_record'
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

require 'mocha/setup'

ActionView::Base.send :include, Reformed::FormHelper
ActionView::TestCase.send :include, Reformed::FormHelper

class User
  include ActiveModel::Model

  cattr_accessor :columns
  self.columns = []

  def self.column(name, sql_type = nil, default = nil, null = true)
    columns << ActiveRecord::ConnectionAdapters::Column.new(name.to_s, default, sql_type.to_s, null)
    attr_accessor name
  end

  def all
    return []
  end

  column :name, :string
  column :url, :string
  column :email, :string
  column :age, :integer
  column :price, :float
  column :currency, :decimal
  column :birthdate, :datetime
  column :phone, :string

  column :gender, :string

  column :datecolumn, :date
  column :timecolumn, :time
  column :timestampcolumn, :timestamp
  column :body, :text
  column :cute, :boolean

  def column_for_attribute(attr)
    columns.select { |c| c.name.to_s == attr.to_s }.first
  end

end

#class User < FakeModel
  #column :name, :string
  #column :email, :string
#end
