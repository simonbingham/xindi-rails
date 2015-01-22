require 'rails_helper'

describe Page do
  def generate_siblings_helper
    root_page = FactoryGirl.create(:page)
    first_sibling_page = FactoryGirl.create(:page, ancestor_id: root_page.id)
    second_sibling_page = FactoryGirl.create(:page, ancestor_id: root_page.id)
    {first_sibling_page: first_sibling_page, second_sibling_page: second_sibling_page}
  end

  def generate_two_tier_helper
    root_page = FactoryGirl.create(:page)
    child_page = FactoryGirl.create(:page, ancestor_id: root_page.id)
    {root_page: root_page, child_page: child_page}
  end

  def generate_three_tier_helper
    root_page = FactoryGirl.create(:page)
    parent_page = FactoryGirl.create(:page, ancestor_id: root_page.id)
    child_page = FactoryGirl.create(:page, ancestor_id: parent_page.id)
    {root_page: root_page, parent_page: parent_page, child_page: child_page}
  end

  it 'should return ancestor' do
    pages = generate_two_tier_helper
    expect(pages[:child_page].get_ancestor()[:id]).to eq(pages[:root_page][:id])
  end

  it 'should return next sibling' do
    pages = generate_siblings_helper
    expect(pages[:first_sibling_page].get_next_sibling()[:id]).to eq(pages[:second_sibling_page][:id])
  end

  it 'should return previous sibling' do
    pages = generate_siblings_helper
    expect(pages[:second_sibling_page].get_previous_sibling()[:id]).to eq(pages[:first_sibling_page][:id])
  end

  it 'should return true when root' do
    pages = generate_three_tier_helper
    expect(pages[:root_page].is_root?()).to be true
  end

  it 'should return false when not root' do
    pages = generate_three_tier_helper
    expect(pages[:parent_page].is_root?()).to be false
    expect(pages[:child_page].is_root?()).to be false
  end

  context 'when creating or updating' do
    it 'should pass validation when valid attributes' do
      expect(FactoryGirl.build(:page)).to be_valid
    end

    it 'should fail validation when title is blank' do
      expect(FactoryGirl.build(:page, title: '')).to_not be_valid
    end

    it 'should fail validation when content is blank' do
      expect(FactoryGirl.build(:page, content: '')).to_not be_valid
    end
  end

  context 'when creating' do
    it 'should allow when page has a depth less than 3' do
      root_page = FactoryGirl.create(:page)
      parent_page = FactoryGirl.create(:page, ancestor_id: root_page.id)
      expect(parent_page.can_add_page?()).to be true
    end

    it 'should not allow when page has a depth more than or equal to 3' do
      root_page = FactoryGirl.create(:page)
      parent_page = FactoryGirl.create(:page, ancestor_id: root_page.id)
      child_page = FactoryGirl.create(:page, ancestor_id: parent_page.id)
      expect(child_page.can_add_page?()).to be false
    end
  end

  context 'when moving' do
    it 'should allow move down when page has next sibling' do
      first_sibling_page = generate_siblings_helper[:first_sibling_page]
      expect(first_sibling_page.can_move_down?()).to be true
    end

    it 'should not allow move down when page does not have next sibling' do
      second_sibling_page = generate_siblings_helper[:second_sibling_page]
      expect(second_sibling_page.can_move_down?()).to be false
    end

    it 'should allow move up when page has previous sibling' do
      second_sibling_page = generate_siblings_helper[:second_sibling_page]
      expect(second_sibling_page.can_move_up?()).to be true
    end

    it 'should not allow move up when page does not have previous sibling' do
      first_sibling_page = generate_siblings_helper[:first_sibling_page]
      expect(first_sibling_page.can_move_up?()).to be false
    end
  end

  context 'when deleting' do
    it 'should allow when page is not root and does not have child' do
      child_page = generate_two_tier_helper[:child_page]
      expect(child_page.can_delete_page?()).to be true
    end

    it 'should not allow when page is root' do
      page = FactoryGirl.create(:page)
      expect(page.can_delete_page?()).to be false
    end

    it 'should not allow when page has child' do
      parent_page = generate_three_tier_helper[:parent_page]
      expect(parent_page.can_delete_page?()).to be false
    end
  end
end
