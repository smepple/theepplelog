xml.instruct! :xml, version: "1.0" 
xml.rss version: "2.0" do
  xml.channel do
    xml.title "the Epplelog"
    xml.description "a blog by Scott Epple"
    xml.link posts_url
    xml.atom_link "", href: posts_url(format: "rss"), rel: "self"

    @posts.each do |post|
      xml.item do
        xml.title post.title
        xml.description post.content
        xml.pubDate post.published_at.to_s(:rfc822)
        xml.link post_url(post.slug)
        xml.guid post_url(post.slug)
      end
    end
  end
end