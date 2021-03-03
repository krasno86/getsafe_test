# frozen_string_literal: true

source 'https://rubygems.org'

ruby '2.6.3'

gem 'down', '~> 5.0'
%w[rspec-core rspec-expectations rspec-mocks rspec-support].each do |lib|
  gem lib, git: "https://github.com/rspec/#{lib}.git", branch: 'main'
end
