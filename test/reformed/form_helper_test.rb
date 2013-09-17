require File.join(File.dirname(__FILE__), '..', 'test_helper')

class Reformed::FormHelperTest < ActionView::TestCase

  setup do
    @user = User.new
  end

  test "yields the correct form builder instance" do
    output = reform_for :user, url: '/' do |f|
      assert f.instance_of?(Reformed::FormBuilder)
    end
  end

  test "yields the correct form fields for builder instance" do
    output = reform_for :user, url: '/' do |f|
      f.reform_fields_for :lala do |ff|
        assert ff.instance_of?(Reformed::FormBuilder)
      end
    end
  end

end
