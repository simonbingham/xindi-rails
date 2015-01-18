module MetaData
  extend ActiveSupport::Concern

  included do
    before_save :set_meta_tags
  end

  def set_meta_tags()
    if self.meta_generated
      set_meta_title
      set_meta_description
      set_meta_keywords
    end
  end

  def set_meta_title
    meta_title = Sanitize.clean(self.title)[0...100].squish
    self.meta_title = meta_title << ' | ' << Rails.configuration.site[:name]
  end

  def set_meta_description
    meta_description = Sanitize.clean(self.content)[0...200].squish
    self.meta_description = meta_description
  end

  def set_meta_keywords
    meta_keywords = Sanitize.clean(self.content)
      .gsub(/\W*\b\w{1,3}\b|[^a-zA-Z\s]/, '') # remove small words and non-letters
      .split(/\W+/).uniq.join(',') # remove duplicates
      .downcase[0...200]
      .squish
      .gsub(/^,|,$/, '') # remove commas from ends of string
    self.meta_keywords = meta_keywords
  end
end
