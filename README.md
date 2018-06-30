# The rubyflow.com clone

[Rubyflow](http://rubyflow.com) is an online publishing platform where anyone can post a link to the article or any other useful resource related to the Ruby programming language.

This project was clonned in the name of the education and growth as a Ruby developer.

**Full course:** [http://gddev.org/courses/rubyflow-com-clone](http://gddev.org/courses/rubyflow-com-clone)

## Project configuration

1. Create configuration file:

```
cp config/rubyflow.yml.example config/rubyflow.yml
```

2. Create new Github app and replace placeholders with your app's `CLIENT_ID` and `CLIENT_SECRET` in order to be able to sign in via Github account.

3. Create database, run migrations and create the test data:

```
bundle exec rake rubyflow:reset
```

4. Enjoy:

```
bundle exec rails s
```

## Bugs and improvements

Please open a new issue if you will find something that needs to be fixed or improved. Thank you!

## Author

Paweł Dąbrowski ([@rubyhero](https://github.com/rubyhero)) - [http://pdabrowski.com](http://pdabrowski.com)
