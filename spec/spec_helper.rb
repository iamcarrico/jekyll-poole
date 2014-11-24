require 'rubygems'

require 'simplecov'
require 'coveralls'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  SimpleCov::Formatter::HTMLFormatter, Coveralls::SimpleCov::Formatter
]

SimpleCov.start

require 'jekyll'
require 'liquid'
require 'sprockets'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[File.expand_path('../support', __FILE__) + '/**/*.rb']
  .each { |f| require f }

RSpec.configure do |config|
  config.include FixturesHelpers
  config.extend FixturesHelpers

  config.disable_monkey_patching!

  config.before(:all) do
    if Gem::Version.new('2') <= Gem::Version.new(Jekyll::VERSION)
      Jekyll.logger.log_level = :warn
    else
      Jekyll.logger.log_level = Jekyll::Stevenson::WARN
    end

    @dest = fixtures_path.join('_site')
    @dest_empty = fixtures_path.join('_site_empty')
    @site = Jekyll::Site.new(Jekyll.configuration(
      'source'  => fixtures_path.to_s,
      'destination' => @dest.to_s
      ))

    @index_page = Jekyll::Page.new(
      @site,
      fixtures_path.to_s,
      '',
      'index.html'
      )

    @about_page = Jekyll::Page.new(
      @site,
      fixtures_path.to_s,
      '',
      'about.md'
      )

    @default_post = Jekyll::Post.new(
      @site,
      fixtures_path.to_s,
      '',
      '2014-11-21-default-tags.md'
      )

    @custom_post = Jekyll::Post.new(
      @site,
      fixtures_path.to_s,
      '',
      '2014-11-22-what-can-poole-do-for-you.md'
      )

    @empty_site = Jekyll::Site.new(Jekyll.configuration(
      'source'  => fixtures_path.to_s,
      'destination' => @dest_empty.to_s,
      'config' => fixtures_path.join('_config.empty.yml')
      ))

    @empty_index = @index_page = Jekyll::Page.new(
      @empty_site,
      fixtures_path.to_s,
      '',
      'index.html'
      )

    @dest.rmtree if @dest.exist?
    @dest_empty.rmtree if @dest_empty.exist?
    @site.process
    # @empty_site.process
  end

  config.after(:all) do
    @dest.rmtree if @dest.exist?
  end
end
