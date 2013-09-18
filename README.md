Reformed
========

Better Rails 3+ and 4+ Form Builder which can easily support Bootstrap 2 and 3, Zurb 3 and 4 or any CSS frameworks by customizing the wrappers.

### Installation

    gem 'reformed'

### Instructions

It's very easy to use, just do this

    = reform_for do |f|
      f.input :name
      f.input :email
      f.input :password
    end

### Customization

The best feature ever. You can easily customize the wrappers to your own need by overriding the following values. Just follow the following examples:

    Reformed::FormBuilder.input_wrapper = lambda { |controls, options|
      "<div class=\"input-control\">#{controls[:label]} #{controls[:input]} #{controls[:error]} #{controls[:hint]}</div>" 
    }

    Reformed::FormBuilder.label_wrapper = lambda { |controls, options|
      "<span>#{controls[:label]}</span>"
    }

    Reformed::FormBuilder.hint_wrapper = lambda { |message, options|
      "<span class=\"hint\">#{message}</span>"
    }

    Reformed::FormBuilder.error_wrapper = lambda { |message, options|
      "<span class=\"error\">#{message}</span>"
    }


More examples to follow soon for Bootstrap 3 and more!

## HTML5 

By default, Reformed will render your controls as html5, you can turn it off by doing the following

    Reformed::FormBuilder.html5 = false

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Bugs

Please feel free to contact us or file a github issue.

## Contributors

Vixon - The Jason Torres and Victor Solis show.

## License

MIT License
