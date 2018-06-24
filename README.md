# The Rails boilerplate by Growth Driven Development

This boilerplate was created to speed up the process of learning how to create a Ruby on Rails apps during the courses posted on the [http://gddev.org](http://gddev.org) education platform.

## Project configuration

The only thing you have to do before start working with this boilerplate is to change the application name. In order to do this, you can use the `./configure.sh` shell script which accepts the new application name as the argument. So, if your application should be named `Guestbook` then call the shell script this way:

```
./configure.sh Guestbook
```

it will update the `config/application.rb` file and the application layout.

## Stack

The project comes with the newest stable version of the Ruby language and the Ruby on Rails framework.

* Ruby `2.5.0`
* Rails `5.2.0`

Following gems are already bundled in the project:

* **Pry** - [https://github.com/pry/pry](https://github.com/pry/pry) - alternative development console and great debugging tool
* **HAML** - [https://github.com/indirect/haml-rails](https://github.com/indirect/haml-rails) - templating engine for HTML to make it easier to write the code
* **Letter opener** - [https://github.com/ryanb/letter_opener](https://github.com/ryanb/letter_opener) - preview mail in the browser instead of sending
* **RSpec** - [https://github.com/rspec/rspec-rails](https://github.com/rspec/rspec-rails) - testing framework
* **Factory Bot** - [https://github.com/thoughtbot/factory_bot_rails](https://github.com/thoughtbot/factory_bot_rails) - a library for setting test objects with Ruby
* **Database Cleaner** - [https://github.com/DatabaseCleaner/database_cleaner](https://github.com/DatabaseCleaner/database_cleaner) - strategies for cleaning databases
* **Rails controller testing** - [https://github.com/rails/rails-controller-testing](https://github.com/rails/rails-controller-testing) - brings back `assigns` to the tests
* **Bootstrap** - [https://github.com/twbs/bootstrap-rubygem](https://github.com/twbs/bootstrap-rubygem) - Bootstrap 4 for RAils
* **jQuery rails** - [https://github.com/rails/jquery-rails](https://github.com/rails/jquery-rails) - jQuery with Rails
* **Meta tags** - [https://github.com/kpumuk/meta-tags](https://github.com/kpumuk/meta-tags) - SEO for Ruby on Rails applications
* **Will paginate** - [https://github.com/mislav/will_paginate](https://github.com/mislav/will_paginate) - pagination library for Rails
* **Will paginate Bootstrap 4** - [https://github.com/delef/will_paginate-bootstrap4](https://github.com/delef/will_paginate-bootstrap4) - hooks for `will_paginate` gem to match Bootstrap 4 styles

## Author

Paweł Dąbrowski ([@rubyhero](https://github.com/rubyhero)) - [http://pdabrowski.com](http://pdabrowski.com)
