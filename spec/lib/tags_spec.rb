require 'spec_helper'

RSpec.describe Jekyll::PoolePlugin::Tags do
  let(:index) { { registers: { site: @site, page: @index_page } } }
  let(:default) { { registers: { site: @site, page: @default_post } } }
  let(:custom) { { registers: { site: @site, page: @custom_post } } }

  def render(content, page)
    ::Liquid::Template.parse(content).render({}, page)
  end

  def render_tag(template, property, content)
    template  = Jekyll::PoolePlugin::Renderer.const_get template

    format template, property: property, content: content
  end

  context '{% poole_tags <meta tags> %}' do
    def tag_re(property, content)
      Regexp.new "^#{render_tag :META_TAG, property, content}$"
    end

    # What values will the index page give?
    context 'Index page' do
      context 'site name' do
        subject { render('{% poole_tags site_name %}', index) }
        it { is_expected.to match tag_re('og:site_name', 'Site Name') }
      end

      context 'page title' do
        subject { render('{% poole_tags title %}', index) }
        it { is_expected.to match tag_re('og:title', 'Site Name') }
      end

      context 'type' do
        subject { render('{% poole_tags type %}', index) }
        it { is_expected.to match tag_re('og:type', 'website') }
      end

      context 'description' do
        subject { render('{% poole_tags description %}', index) }
        it { is_expected.to be_empty }
      end

      context 'published_time' do
        subject { render('{% poole_tags published_time %}', index) }
        it { is_expected.to be_empty }
      end

      context 'author' do
        subject { render('{% poole_tags author %}', index) }
        it { is_expected.to match tag_re('article:author', 'https://google.com') }
      end

      context 'image' do
        subject { render('{% poole_tags image %}', index) }
        it { is_expected.to match tag_re('og:image', 'https://iamcarrico.com/img/logo.png') }
      end
    end

    # The values that a default post, without customization will give.
    context 'Default post' do
      context 'site name' do
        subject { render('{% poole_tags site_name %}', default) }
        it { is_expected.to match tag_re('og:site_name', 'Site Name') }
      end

      context 'page title' do
        subject { render('{% poole_tags title %}', default) }
        it { is_expected.to match tag_re('og:title', 'Default Tags') }
      end
    end

    # A custom post, with specific values for each field.
    context 'Custom post' do
      context 'site name' do
        subject { render('{% poole_tags site_name %}', custom) }
        it { is_expected.to match tag_re('og:site_name', 'Site Name') }
      end

      context 'page title' do
        subject { render('{% poole_tags title %}', custom) }
        it { is_expected.to match tag_re('og:title', 'Custom Tags') }
      end

      context 'type' do
        subject { render('{% poole_tags type %}', custom) }
        it { is_expected.to match tag_re('og:type', 'article') }
      end

      context 'description' do
        subject { render('{% poole_tags description %}', custom) }
        it { is_expected.to match tag_re('og:description', 'What can Mr. Poole do for you') }
      end

      context 'published_time' do
        subject { render('{% poole_tags published_time %}', custom) }
        it { is_expected.to match tag_re('article:published_time', '2014-11-22T06:00:00-06:00') }
      end
    end
  end
end
