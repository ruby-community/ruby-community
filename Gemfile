source "https://rubygems.org"

gem "rails", "6.1.3.2"
gem "jquery-rails"
gem "slim-rails"
gem "sass-rails", "~> 6.0"
gem "bootstrap-sass"
gem "uglifier", ">= 1.3.0"
gem "bcrypt", "~> 3.1.7"
gem "markdown"
gem "pg"

# For iDea theme
gem "font-awesome-rails"

gem "redcarpet"

# For authentication
gem "devise", github: "heartcombo/devise" # master branch until Omniauth 2.0 support is released
gem "omniauth-github", "~> 2.0"
gem 'omniauth-rails_csrf_protection'

group :production, optional: true do
  gem "puma"
end

group :development, :test do
  # gem "byebug"
  gem "pry-rails"
  gem "pry-doc"
end
