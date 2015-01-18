require 'rails_helper'

describe Article do
  before(:each) do
    @article = FactoryGirl.create(:article)
  end

  context 'when creating or updating' do
    it 'should fail validation when title is blank' do
      expect(Article.new(:title => '', :content => 'test content', :author => 'test author')).to_not be_valid
    end

    it 'should fail validation when content is blank' do
      expect(Article.new(:title => 'test title', :content => '', :author => 'test author')).to_not be_valid
    end

    it 'should fail validation when author is blank' do
      expect(Article.new(:title => 'test title', :content => 'test content', :author => '')).to_not be_valid
    end

    it 'should pass validation title, content and author are not blank' do
      expect(Article.new(:title => 'test title', :content => 'test content', :author => 'the author')).to be_valid
    end

    it 'should generate meta title when `meta_generated` is true' do
      expect(@article.meta_title).to eq('the title | ' + Rails.configuration.site[:name])
    end

    it 'should not generate meta title when `meta_generated` is false' do
      article = FactoryGirl.create(:article, title: 'test title', meta_generated: false, meta_title: 'the meta title')
      expect(article.meta_title).to eq('the meta title')
    end

    it 'should generate meta description when `meta_generated` is true' do
      expect(@article.meta_description).to eq('the content')
    end

    it 'should not generate meta description when `meta_generated` is false' do
      article = FactoryGirl.create(:article, title: 'test title', meta_generated: false, meta_description: 'the meta description')
      expect(article.meta_description).to eq('the meta description')
    end

    it 'should generate meta keywords when `meta_generated` is true' do
      expect(@article.meta_keywords).to eq('content')
    end

    it 'should not generate meta keywords when `meta_generated` is false' do
      article = FactoryGirl.create(:article, title: 'test title', meta_generated: false, meta_keywords: 'the,meta,keywords')
      expect(article.meta_keywords).to eq('the,meta,keywords')
    end
  end

  context 'when creating' do
    it 'should set slug' do
      expect(@article.slug).to eq('the-title')
    end
  end

  context 'when updating' do
    it 'should not change slug' do
      expect(@article.slug).to eq('the-title')
      @article.title = 'the new title'
      expect(@article.slug).to eq('the-title')
    end
  end
end
