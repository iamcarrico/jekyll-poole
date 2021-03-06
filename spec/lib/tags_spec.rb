require 'spec_helper'

RSpec.describe Jekyll::PoolePlugin::Tags do
  let(:index) { { registers: { site: @site, page: @index_page } } }
  let(:default) { { registers: { site: @site, page: @default_post } } }
  let(:custom) { { registers: { site: @site, page: @custom_post } } }
  let(:page) { { registers: { site: @site, page: @about_page } } }

  def render(content, page)
    ::Liquid::Template.parse(content).render({}, page)
  end

  def render_meta(property, content)
    template  = Jekyll::PoolePlugin::Renderer.const_get :META_TAG

    format template, property: property, content: content
  end

  def render_link(rel, href)
    template  = Jekyll::PoolePlugin::Renderer.const_get :LINK_TAG

    format template, rel: rel, href: href
  end

  context '{% poole_tags <tag> %}' do

    # What values will the index page give?
    context 'Index page' do
      context 'site name' do
        subject { render('{% poole_tags site_name %}', index) }
        it { is_expected.to eql render_meta('og:site_name', 'Site Name') }
      end

      context 'page title' do
        subject { render('{% poole_tags title %}', index) }
        it { is_expected.to eql render_meta('og:title', 'Site Name') }
      end

      context 'type' do
        subject { render('{% poole_tags type %}', index) }
        it { is_expected.to eql render_meta('og:type', 'website') }
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
        it do
          is_expected.to eql render_meta(
          'article:author',
          'https://google.com')
        end
      end

      context 'url' do
        subject { render('{% poole_tags url %}', index) }
        it do
          is_expected.to eql render_meta(
          'og:url', 'https://iamcarrico.com/')
        end
      end

      context 'canonical' do
        subject { render('{% poole_tags canonical %}', index) }
        it do
          is_expected.to eql render_link(
          'canonical',
          'https://iamcarrico.com/')
        end
      end

      context 'image' do
        subject { render('{% poole_tags image %}', index) }
        it do
          is_expected.to eql render_meta(
          'og:image',
          'https://iamcarrico.com/img/logo.png')
        end
      end
    end

    # The values that a default post, without customization will give.
    context 'Default post' do
      context 'site name' do
        subject { render('{% poole_tags site_name %}', default) }
        it { is_expected.to eql render_meta('og:site_name', 'Site Name') }
      end

      context 'page title' do
        subject { render('{% poole_tags title %}', default) }
        it { is_expected.to eql render_meta('og:title', 'Default Tags') }
      end

      context 'type' do
        subject { render('{% poole_tags type %}', default) }
        it { is_expected.to eql render_meta('og:type', 'article') }
      end

      context 'description' do
        subject { render('{% poole_tags description %}', default) }
        it { is_expected.to be_empty }
      end

      context 'published_time' do
        subject { render('{% poole_tags published_time %}', default) }
        it do
          is_expected.to eql render_meta(
          'article:published_time',
          '2014-11-21T06:00:00-06:00')
        end
      end

      context 'author' do
        subject { render('{% poole_tags author %}', default) }
        it do
          is_expected.to eql render_meta(
          'article:author',
          'https://google.com')
        end
      end

      context 'url' do
        subject { render('{% poole_tags url %}', default) }
        it do
          is_expected.to eql render_meta(
          'og:url',
          'https://iamcarrico.com/2014/11/21/default-tags.html')
        end
      end

      context 'canonical' do
        subject { render('{% poole_tags canonical %}', default) }
        it do
          is_expected.to eql render_link(
          'canonical',
          'https://iamcarrico.com/2014/11/21/default-tags.html')
        end
      end

      context 'image' do
        subject { render('{% poole_tags image %}', default) }
        it do
          is_expected.to eql render_meta(
          'og:image', 'https://iamcarrico.com/img/logo.png')
        end
      end
    end

    # A custom post, with specific values for each field.
    context 'Custom post' do
      context 'site name' do
        subject { render('{% poole_tags site_name %}', custom) }
        it { is_expected.to eql render_meta('og:site_name', 'Site Name') }
      end

      context 'page title' do
        subject { render('{% poole_tags title %}', custom) }
        it { is_expected.to eql render_meta('og:title', 'Custom Tags') }
      end

      context 'type' do
        subject { render('{% poole_tags type %}', custom) }
        it { is_expected.to eql render_meta('og:type', 'article') }
      end

      context 'description' do
        subject { render('{% poole_tags description %}', custom) }
        it do
          is_expected.to eql render_meta(
          'og:description',
          'What can Mr. Poole do for you')
        end
      end

      context 'published_time' do
        subject { render('{% poole_tags published_time %}', custom) }
        it do
          is_expected.to eql render_meta(
          'article:published_time',
          '2014-11-22T06:00:00-06:00')
        end
      end

      context 'author' do
        subject { render('{% poole_tags author %}', custom) }
        it do
          is_expected.to eql render_meta(
          'article:author',
          'https://google.com')
        end
      end

      context 'url' do
        subject { render('{% poole_tags url %}', custom) }
        it do
          is_expected.to eql render_meta(
          'og:url',
          'https://iamcarrico.com/2014/11/22/what-can-poole-do-for-you.html')
        end
      end

      context 'canonical' do
        subject { render('{% poole_tags canonical %}', custom) }
        it do
          is_expected.to eql render_link(
          'canonical',
          'https://iamcarrico.com/2014/11/22/what-can-poole-do-for-you.html')
        end
      end

      context 'image' do
        subject { render('{% poole_tags image %}', custom) }
        it do
          is_expected.to eql render_meta(
          'og:image',
          'https://iamcarrico.com/img/custom-image.png')
        end
      end
    end

    # A page being rendered.
    context 'About page' do
      context 'site name' do
        subject { render('{% poole_tags site_name %}', page) }
        it { is_expected.to eql render_meta('og:site_name', 'Site Name') }
      end

      context 'page title' do
        subject { render('{% poole_tags title %}', page) }
        it { is_expected.to eql render_meta('og:title', 'About Us') }
      end

      context 'type' do
        subject { render('{% poole_tags type %}', page) }
        it { is_expected.to eql render_meta('og:type', 'article') }
      end

      context 'description' do
        subject { render('{% poole_tags description %}', page) }
        it { is_expected.to be_empty }
      end

      context 'published_time' do
        subject { render('{% poole_tags published_time %}', page) }
        it { is_expected.to be_empty }
      end

      context 'author' do
        subject { render('{% poole_tags author %}', page) }
        it do
          is_expected.to eql render_meta(
          'article:author',
          'https://google.com')
        end
      end

      context 'url' do
        subject { render('{% poole_tags url %}', page) }
        it do
          is_expected.to eql render_meta(
          'og:url',
          'https://iamcarrico.com/about.html')
        end
      end

      context 'canonical' do
        subject { render('{% poole_tags canonical %}', page) }
        it do
          is_expected.to eql render_link(
          'canonical',
          'https://iamcarrico.com/about.html')
        end
      end

      context 'image' do
        subject { render('{% poole_tags image %}', page) }
        it do
          is_expected.to eql render_meta(
          'og:image',
          'https://iamcarrico.com/img/logo.png')
        end
      end
    end
  end
end
