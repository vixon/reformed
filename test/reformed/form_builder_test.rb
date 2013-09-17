require File.join(File.dirname(__FILE__), '..', 'test_helper')

class Reformed::FormBuilderTest < ActionView::TestCase

  def setup
    @user = User.new
    @user.name = 'Lalala'
  end

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

  test "responds to reform_for" do
    assert respond_to?(:reform_for)
  end

  test "yields the input" do
    reform_for(@user, url: '/') do |f|
      assert_match 'user_name', f.input(:name)
    end

    output = reform_for(@user, url: '/') do |f|
      f.input :name
    end

  end

  test "yields the input wrapper" do

    Reformed::FormBuilder.input_wrapper = lambda { |controls| 
      "<div class='mycustomdiv'>#{controls[:input]}</div>"
    }

    reform_for(@user, url: '/') do |f|
      assert_match "<div class='mycustomdiv'>", f.input(:name)
      assert_match "<input id=\"user_name\" name=\"user[name]\" type=\"text\" value=\"Lalala\" />", f.input(:name)
    end

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
