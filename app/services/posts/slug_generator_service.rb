module Posts
  class SlugGeneratorService

    def self.call(title:)
      uid = SecureRandom.urlsafe_base64
      title_for_url = title.parameterize

      "#{uid}-#{title_for_url}"
    end

  end
end
