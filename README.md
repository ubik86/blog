# Blog APP 

## Summary

**Blog app** is a simple Rails 4 project that users can write posts and add comment it.
Posts and comments can be added only by signed users. 
Loging process needs to give email and password.


### Features

- home view for unlogged users
- signup and logging into app with devise
- signup with facebook via Devise oAuth2
- after login redirect to blog with posts and comments
- search in the posts and comments by title and content
- create post assigned to users
- create comments to post with parent_id, feature REPLY
- pagination for posts and comments

##### Waiting in progress
- stats: users, posts, comments per day, week, month, year
- admin listning, manage post, users and comments

### Requirements


[HOMEBREW](http://brew.sh)

[RUBY 2.1](https://www.ruby-lang.org)

[RVM](https://rvm.io)

[RAILS 4](https://github.com/rails/rails)

[BUNDLER](http://bundler.io)


## Getting started


First **clone github** repository.
Change directory into _blog_.
Install **bundler** gem if needed, and then run the bundle command to install required gems.

 
```console
$ git clone git@github.com:ubik86/blog.git
$ cd blog
$ gem install bundler
$ bundle install
```

Copy database from example and setup config.

```console
$ cd config
$ cp database.example.yml database.yml
$ vi database.yml
$ vi secrets.yml

```

Database should be like this

```ruby
default: &default
  adapter: postgresql
  pool: 5
  encoding: unicode

development:
  <<: *default
  database: blog_development

test:
  <<: *default
  database: blog_test

production:
  <<: *default
  database: blog_production

```


Create database and run migrations

```console
$ rake db:create
$ rake db:migrate
$ rake db:seed
```


## Production and testing


### Start server

Default server for Blog app is Thin. Launch server from main directory.

```console
$ thin start

or

$ bundle exec rails s
```

Logs are in log/*.log

```console
$ tail -f log/development.log
```


### Testing and debugging


Blog is tested by RSpec and many other tools.
In your Gemfile you should have following gems.

```ruby
group :development, :test do
  gem 'pry'
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'capybara'
  gem 'database_cleaner'
  gem 'byebug'
  gem 'guard-rspec'
end
```

Run all tests in main app directory
```console
$ rspec .
```

Autotest with guard. Guard will run spec on every file save.
```console
$ guard
```



## Additional informations


### Devise

Blog app using Devise gem flexible authentication solution for Rails based on Warden.

https://github.com/plataformatec/devise/



### Twitter Bootstrap

Bootstrap 4 ruby gem for Ruby on Rails (Sprockets) and Compass.

https://github.com/twbs/bootstrap-rubygem



### Faker

This gem is a port of Perl's Data::Faker library that generates fake data.

https://github.com/stympy/faker


## License

MIT License. Copyright 2016

You are not granted rights or licenses to the trademarks.