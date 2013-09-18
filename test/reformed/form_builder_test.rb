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

  test "yields an input field with an input wrapper" do
    Reformed::FormBuilder.input_wrapper = lambda { |controls, options| 
      "<div class='mycustomdiv'>#{controls[:input]}</div>"
    }

    reform_for(@user, url: '/') do |f|
      assert_match "<div class='mycustomdiv'>", f.input(:name)
      assert_match "<input id=\"user_name\" name=\"user[name]\" type=\"text\" value=\"Lalala\" />", f.input(:name)
    end
  end

  test "yields a label" do
    Reformed::FormBuilder.label_wrapper = lambda { |controls, options| 
      "<span class=\"label-wrapper\">#{controls[:label]}</span>"
    }

    reform_for(@user, url: '/') do |f|
      output = f.input(:name)
      assert_match "<span class=\"label-wrapper\">", output
      assert_match "<label for=\"user_name\">Name</label>", output
    end
  end

  test "yields a label with a custom label" do
    Reformed::FormBuilder.label_wrapper = lambda { |controls, options| 
      "<span class=\"label-wrapper\">#{controls[:label]}</span>"
    }

    reform_for(@user, url: '/') do |f|
      output = f.input(:name, label: 'Custom Label')
      assert_match "<span class=\"label-wrapper\">", output
      assert_match "<label for=\"user_name\">Custom Label</label>", output
    end
  end

  test "infer types from method" do 
    reform_for(@user, url: '/') do |f|
      assert :string, f.send(:as, :name)
      assert :text, f.send(:as, :body)

      assert :boolean, f.send(:as, :cute)

      assert :number, f.send(:as, :age)
      assert :number, f.send(:as, :price)
      assert :number, f.send(:as, :currency)

      assert :url, f.send(:as, :url)
      assert :email, f.send(:as, :email)
      assert :password, f.send(:as, :password)

      assert :datetime, f.send(:as, :birthdate)
      assert :datetime, f.send(:as, :datecolumn)
      assert :datetime, f.send(:as, :timecolumn)
      assert :datetime, f.send(:as, :timestampcolumn)
    end
  end

  test "yields a text field with an input wrapper" do
    @user.body = "your body is a wonderland"
    reform_for(@user, url: '/') do |f|
      assert_match "<textarea id=\"user_body\" name=\"user[body]\">\nyour body is a wonderland</textarea>", f.input(:body)
    end
  end

  test "yields a url field" do
    reform_for(@user, url: '/') do |f|
      assert_match '<input id="user_url" name="user[url]" type="url" />', f.input(:url)
    end
  end

  test "yields a phone field" do
    reform_for(@user, url: '/') do |f|
      assert_match '<input id="user_phone" name="user[phone]" type="tel" />', f.input(:phone)
    end
  end

  test "yields an email field" do
    reform_for(@user, url: '/') do |f|
      assert_match '<input id="user_email" name="user[email]" type="email" />', f.input(:email)
    end
  end

  test "yields a checkbox field" do
    reform_for(@user, url: '/') do |f|
      assert_match '<input id="user_cute" name="user[cute]" type="checkbox" value="1" />', f.input(:cute)
    end
  end

  test "yields a radio field" do
    reform_for(@user, url: '/') do |f|
      assert_match '<input checked="checked" id="user_cute" name="user[cute]" type="radio" />', f.input(:cute, as: :radio)
    end
  end

  test "yields a password field" do
    reform_for(@user, url: '/') do |f|
      assert_match '<input id="user_password" name="user[password]" type="password" />', f.input(:password)
    end
  end

  test "yields a date field" do 
    reform_for(@user, url: '/') do |f|
      assert_match 'user_birthdate_1i', f.input(:birthdate)
    end
  end

  test "yields a hidden field" do 
    reform_for(@user, url: '/') do |f|
      assert_match '<input id="user_name" name="user[name]" type="hidden" value="Lalala" />', f.input(:name, as: :hidden)
    end
  end

  test "yields a select field" do 
    reform_for(@user, url: '/') do |f|
      assert_match '<select id="user_gender" name="user[gender]"><option value="male">male</option>
<option value="female">female</option></select>', f.input(:gender, as: :select, choices: ['male', 'female'])
    end
  end

  test "yields an input with a hint" do 

    Reformed::FormBuilder.input_wrapper = lambda { |controls, options|
      "<div class='input-control'>#{controls[:input]} #{controls[:hint]}</div>" 
    }

    reform_for(@user, url: '/') do |f|
      assert '<div class="input-control"><input id="user_name" name="user[name]" type="text" value="Lalala" /> <span class="hint">Full Name</span></div>', f.input(:name, hint: 'Full Name')
    end
  end

  test "yields an input with an error" do 
    Reformed::FormBuilder.input_wrapper = lambda { |controls, options|
      "<div class='input-control'>#{controls[:input]} #{controls[:hint]}</div>" 
    }

    reform_for(@user, url: '/') do |f|
      assert '<div class="input-control"><input id="user_name" name="user[name]" type="text" value="Lalala" /> <span class="error">Full Name</span></div>', f.input(:name, error: 'Full Name')
    end
  end

  test "yields an input with the whole shebang" do 
    Reformed::FormBuilder.input_wrapper = lambda { |controls, options|
      "<div class=\"input-control\">#{controls[:label]} #{controls[:input]} #{controls[:error]} #{controls[:hint]}</div>" 
    }

    reform_for(@user, url: '/') do |f|
      #assert_match "", 
      assert_match '<div class="input-control"><span class="label-wrapper"><label for="user_name">Name</label></span> <input class="input" id="user_name" name="user[name]" placeholder="a placeholder" style="width:100px;" type="text" value="Lalala" /> <span class="error">I have an error!</span> <span class="hint">This is a hint</span></div', f.input(:name, hint: 'Full Name', hint: 'This is a hint', error: 'I have an error!', placeholder: 'a placeholder', style: "width:100px;", class: 'input')
    end
  end

end
