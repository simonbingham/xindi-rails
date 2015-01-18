class Article < ActiveRecord::Base
  include Bootsy::Container
  include MetaData

  validates :title, :content, :author, presence: true
  validates :title, uniqueness: true

  before_create :set_slug

  def get_url(url)
    url << "/" << self.slug
  end

  private

    def set_slug
      slug = self.title.to_s.gsub(/[^0-9A-Za-z]/, '-').downcase
      while Article.where(slug: slug).count > 0 do
        slug << '-'
      end
      self.slug = slug
    end

end
