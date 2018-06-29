#encoding: UTF-8

xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Rubyflow.com clone"
    xml.description "Rubyflow.com clone created for education goals"
    xml.link "localhost"

    @posts.each do |post|
      xml.item do
        xml.title post.title
        xml.pubDate post.created_at.to_s(:rfc822)
        xml.link url_for(action: 'show', controller: 'posts', id: post.id, only_path: false, protocol: 'http')
        xml.description post.content.truncate(100)
      end
    end
  end
end
