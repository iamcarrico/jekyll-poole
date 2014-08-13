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
      def render(context)
        Renderer.new(context, @markup).send :"render_all"
      end
    end
  end
end

Liquid::Template.register_tag('poole_tags', Jekyll::PoolePlugin::Tags)
