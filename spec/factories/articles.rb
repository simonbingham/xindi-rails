FactoryGirl.define do
  factory :article do
    title 'the title'
    content 'the content'
    meta_generated true
    meta_title 'the meta title'
    meta_description 'the meta description'
    meta_keywords 'the meta keywords'
    author 'the author'
  end
end
