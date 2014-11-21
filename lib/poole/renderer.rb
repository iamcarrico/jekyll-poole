

module Jekyll
  module PoolePlugin
    class Renderer
      META_TAG = '<meta property="%{property}" content="%{content}">'
      LINK_TAG = '<link rel="%{rel}" href="%{href}" />'

      def initialize(context, markup)
        @site   = context.registers[:site]
        @page   = context.registers[:page]

        @site_name = @site.config['title']
      end

      def render_all
        tags = Array.new
        tags << render_site_name
        tags << render_title
        tags << render_type
        tags << render_description
        tags << render_published_time
        tags << render_author
        tags << render_url
        tags << render_canonical
        tags << render_image
        tags.push(*render_categoies)

        tags.delete_if {|v| v == nil or v == "" }.join("\n")
      end

      def render_site_name
        format META_TAG, :property => "og:site_name", :content => @site_name if @site_name
      end

      def render_title
        title = @page['title'] || @site_name
        format META_TAG, :property => "og:title", :content => title if title
      end

      def render_type
        type = @page['title'] ? "article" : "website"
        format META_TAG, :property => "og:type", :content => type
      end

      def render_description
        description = @page['description'] || nil

        format META_TAG, :property => "og:description", :content => description if description
      end

      def render_published_time
        format META_TAG, :property => "article:published_time", :content => @page['date'].iso8601 if @page['date']
      end

      def render_author
        author = @page['author'] || @site.config['author']
        format META_TAG, :property => "article:author", :content => author if author
      end

      def render_url
        url = remove_index(@site.config['url'] + @page['url'])
        format META_TAG, :property => "og:url", :content => url
      end

      def render_canonical
        format LINK_TAG, :rel => "canonical", :href => remove_index(@page['url']) if @page['url']
      end

      def render_image
          image = @page['image'] || @site.config['og_image']
          format META_TAG, :property => "og:image", :content => @site.config['url'] + "/" + image if image

      end

      def render_categoies
        Array(@page['categories']).map do |category|
          format META_TAG, :property => "article:tag", :content => category
        end
      end

      private

      def remove_index(string)
        string.slice!("index.html")
        string
      end
    end
  end
end
