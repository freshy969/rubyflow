module Posts
  class SlugGeneratorService

    def self.call(title:)
      uid = "#{DateTime.now.strftime("%Y%m%d%H%M%S%L")}".to_i.to_s(36)
      title_for_url = title.parameterize

      "#{uid}-#{title_for_url}"
    end

  end
end
