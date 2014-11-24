Mr. Poole's Jekyll Tools
------------------------

[![Gem version][gem-image]][gem-url] [![Build Status][travis-image]][travis-url] [![License MIT][license-image]][license-url] [![Downloads][downloads-image]][gem-url] [![Coverage Status][coverage-image]][coverage-url]

```
.___  ___. .______                    _-----_
|   \/   | |   _  \                   | - - |
|  \  /  | |  |_)  |                  |  ω  |
|  |\/|  | |      /                   | ___ |
|  |  |  | |  |\  \     __          __'.___.'__
|__|  |__| | _| `._\   (__)        ´    >-<    `

.______     ______     ______    __       _______
|   _  \   /  __  \   /  __  \  |  |     |   ____|
|  |_)  | |  |  |  | |  |  |  | |  |     |  |__
|   ___/  |  |  |  | |  |  |  | |  |     |   __|
|  |      |  `--'  | |  `--'  | |  `----.|  |____
| _|       \______/   \______/  |_______||_______|
```

For the Yeoman generator that set's up a Jekyll site for you, check out [Mr. Poole, the Jekyll Site Generator](https://github.com/iamcarrico/generator-poole/).

This set of tools are some extensions to Jekyll to help make your site a little better.

## Installation

Add this line to your application's Gemfile:

```
gem 'jekyll-poole'
```

And then execute:

```
$ bundle
```

Or install it yourself as:

```
$ gem install jekyll-poole
```

## Use

You must first ensure Jekyll is pulling in this extension. Common practices are to copy the following code into ```_plugins/ext.rb```:

```ruby
require 'jekyll-poole'
```

### Adding in Open Graph tags

The primary use of the Mr. Poole's Jekyll extension is to add in the proper meta tags for Open Graph, and other meta-information. You can add in all tags available by adding the following code within your <head> tag.

```liquid
{% poole_tags %}
```

Optionally, you may choose any of the following tags to insert them in one-by-one.

```liquid
{% poole_tags site_name %}
```
Adds in the og:site_name tag. This will pull from the ```tite``` in ```_config.yml```.

```liquid
{% poole_tags title %}
```

Puts in the og:title tag. This will be either the page title, or the site_name if a page title is not present.


```liquid
{% poole_tags type %}
```

The og:type tag. This will be 'article' unless a page title is not set, in which it will be 'website'.


```liquid
{% poole_tags description %}
```

The og:description tag. This will be pulled from an option "description" from the post's frontmatter. Working on having this pull from the post's excerpt if this does not exist.


```liquid
{% poole_tags published_time %}
```

The article:published_time tag, which pulls from page's date. Will be properly formatted in the iso8601 format.

```liquid
{% poole_tags author %}
```

The article:author tag, which will pull from the page's 'author' frontmatter if it is set. If not, it will be set to the site's author set in ```_config.yml```.

```liquid
{% poole_tags url %}
{% poole_tags canonical %}
```

The url tag will add in the og:url tag, and the canonical will add in the canonical <link> tag. Both will pull from the page's permalink.

```liquid
{% poole_tags image %}
```

This will add in a og:image tag. If there is an 'image' setting on the post or page, then it will use that. If not, it will pull from the og_image from the ```_config.yml```. If neither are set, then it will be ignored.


## Thanks, Praise, Etc.

Big thanks to [@ixti](https://github.com/ixti), whose code for [jekyll-assets](https://github.com/ixti/jekyll-assets) was great inspiration for this extension. Also to [@parkr](https://github.com/parkr) who helped me with the tests, and wrote Jekyll.

## License

MIT


[travis-url]: https://travis-ci.org/iamcarrico/jekyll-poole
[travis-image]: http://img.shields.io/travis/iamcarrico/jekyll-poole.svg

[downloads-image]: http://img.shields.io/gem/dt/jekyll-poole.svg
[gem-url]: https://rubygems.org/gems/jekyll-poole
[gem-image]: http://img.shields.io/gem/v/jekyll-poole.svg

[license-image]: http://img.shields.io/badge/license-MIT-blue.svg
[license-url]: https://github.com/iamcarrico/jekyll-poole/blob/master/LICENSE

[coverage-image]: https://img.shields.io/coveralls/iamcarrico/jekyll-poole.svg
[coverage-url]: https://coveralls.io/r/iamcarrico/jekyll-poole
