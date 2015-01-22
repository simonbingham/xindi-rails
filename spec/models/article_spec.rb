require 'rails_helper'

describe Article do
  context 'when creating or updating' do
    it 'should pass validation when valid attributes' do
      expect(FactoryGirl.build(:article)).to be_valid
    end

    it 'should fail validation when title is blank' do
      expect(FactoryGirl.build(:article, title: '')).to_not be_valid
    end

    it 'should fail validation when title is not unique' do
      FactoryGirl.create(:article, title: 'the test title')
      expect(FactoryGirl.build(:article, title: 'the test title')).to_not be_valid
    end

    it 'should fail validation when content is blank' do
      expect(FactoryGirl.build(:article, content: '')).to_not be_valid
    end

    it 'should fail validation when author is blank' do
      expect(FactoryGirl.build(:article, author: '')).to_not be_valid
    end

    it 'should generate meta title when `meta_generated` is true' do
      expect(FactoryGirl.create(:article).meta_title).to eq('the title | ' + Rails.configuration.site[:name])
    end

    it 'should not generate meta title when `meta_generated` is false' do
      article = FactoryGirl.create(:article, meta_generated: false, meta_title: 'the meta title')
      expect(article.meta_title).to eq('the meta title')
    end

    it 'should generate meta description when `meta_generated` is true' do
      expect(FactoryGirl.create(:article).meta_description).to eq('the content')
    end

    it 'should not generate meta description when `meta_generated` is false' do
      article = FactoryGirl.create(:article, meta_generated: false, meta_description: 'the meta description')
      expect(article.meta_description).to eq('the meta description')
    end

    it 'should generate meta keywords when `meta_generated` is true' do
      expect(FactoryGirl.create(:article).meta_keywords).to eq('content')
    end

    it 'should not generate meta keywords when `meta_generated` is false' do
      article = FactoryGirl.create(:article, meta_generated: false, meta_keywords: 'the,meta,keywords')
      expect(article.meta_keywords).to eq('the,meta,keywords')
    end
  end

  context 'when creating' do
    it 'should set slug' do
      expect(FactoryGirl.create(:article).slug).to eq('the-title')
    end
  end

  context 'when updating' do
    it 'should not change slug' do
      article = FactoryGirl.create(:article)
      expect(article.slug).to eq('the-title')
      article.title = 'the new title'
      expect(article.slug).to eq('the-title')
    end
  end
end
