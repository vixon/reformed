require File.join(File.dirname(__FILE__), '..', 'test_helper')

class Reformed::FormBuilderTest < ActionView::TestCase

  test "yields the correct instance" do
    form_for :user, url: '/', builder: Reformed::FormBuilder do |f|
      assert f.instance_of?(Reformed::FormBuilder)
    end
  end


  test "responds to the input method" do
    form_for :user, url: '/', builder: Reformed::FormBuilder do |f|
      assert f.respond_to?(:input)
    end
  end


  test "#wrap" do
    reform_for @user, url: '/' do |f|
      assert_match 'user_name', f.input(:name)
    end
  end

  test "input_wrap" do
    skip
  end

  test "#label_wrap" do
    skip
  end

  test "extract options" do
    skip
  end

  test "hint" do 
    skip
  end

  test "error" do 
    skip
  end

end
