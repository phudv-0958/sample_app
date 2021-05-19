source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.5.0"

gem "rails", "~> 6.0.0"
gem "bcrypt", ">= 3.1.12"
gem "ffaker", ">=1.7.3"
gem "carrierwave", ">= 1.2.2"
gem "mini_magick", ">= 4.9.5"
gem "kaminari"
gem "bootstrap-kaminari-views"
gem "bootstrap-sass", ">= 3.3.7"
gem "puma", "~> 4.3"
gem "sass-rails", "~> 5"
gem "webpacker", "~> 4.0"
gem "turbolinks", "~> 5"
gem "jbuilder", "~> 2.7"
gem "bootsnap", ">= 1.4.2", require: false
gem "rails-i18n"
gem "i18n-js"
gem "config"

group :development, :test do
  gem "sqlite3", "1.4.1"
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem "web-console", ">= 3.3.0"
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
end

group :test do
  gem "capybara", ">= 2.15"
  gem "selenium-webdriver"
  gem "webdrivers"
end

group :production do
  gem "pg", "1.1.4"
end

