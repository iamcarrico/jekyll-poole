# Title: Mr. Poole's Plugin
# Author: Ian Carrico http://iamcarrico.com
# Description: Output a list of metatags for your site.
#
# Syntax {% poole_tags  %}
#

require "liquid"
require 'date'

require 'poole/renderer'

module Jekyll
  module PoolePlugin
    class Tags < Liquid::Tag
      def initialize(tag_name, text, tokens)
        text = text.strip
        @text = text.empty? ? "all" : text
      end

      def render(context)
        Renderer.new(context, @markup).send :"render_#{@text}"\
      end
    end
  end
end

Liquid::Template.register_tag('poole_tags', Jekyll::PoolePlugin::Tags)
