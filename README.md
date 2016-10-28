# model_base_generators

`model_base_generators` extends generators to use your models effectively.
It uses twitter-bootstrap-rails, rspec, factory_girl and so on.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'model_base_generators'
```

And then execute:

    $ bundle

## Setup

    $ bin/rails g model_base:install

## Usage

### 1. Generate your model

```bash
$ bin/rails g model Issue project:references{required} title:string status:integer
```

### 2. Make up your generated migration

Add `:null` option.

```ruby
class CreateIssues < ActiveRecord::Migration[5.0]
  def change
    create_table :issues do |t|
      t.references :project, null: false, foreign_key: true
      t.string :title  , null: false
      t.integer :status, null: false

      t.timestamps
    end
  end
end
```

### 3. Run migration

```bash
$ bin/rails db:migrate
```

### 4. Generate controller and views

```bash
$ bin/rails g scaffold_controller issues
```

Run scaffold_controller **WITHOUT attributes**!

## Template for `rails new`

You can use `rails_template.rb` for `--template` option of `rails new`.


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/akm/model_base_generators. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

