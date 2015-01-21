FactoryGirl.define do
  factory :page do
  	ancestor_id 0
    title 'the title'
    content 'the content'
    meta_generated true
    meta_title 'the meta title'
    meta_description 'the meta description'
    meta_keywords 'the meta keywords'
  end
end
