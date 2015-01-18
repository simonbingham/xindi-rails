class Page < ActiveRecord::Base
  include Bootsy::Container
  include MetaData

  validates :title, :content, presence: true

  before_create :set_slug, :set_depth, :set_left_and_right_values_on_create
  before_destroy :set_left_and_right_values_on_destroy

  def can_add_page
    self.depth < 3
  end

  def can_delete_page
    !self.has_child && !self.is_root
  end

  def can_move_down
    has_next_sibling
  end

  def can_move_up
    has_previous_sibling
  end

  def get_ancestor
    Page.find(self.ancestor_id)
    rescue ActiveRecord::RecordNotFound
      Page.new
  end

  def get_next_sibling
    Page.where("left_value = :left_value", {left_value: self.right_value + 1}).first
  end

  def get_previous_sibling
    Page.where("right_value = :right_value", {right_value: self.left_value - 1}).first
  end

  def has_child
    get_first_child.present?
  end

  def has_next_sibling
    get_next_sibling.present?
  end

  def has_previous_sibling
    get_previous_sibling.present?
  end

  def is_root
    self.left_value == 1
  end

  def move(direction)
    ActiveRecord::Base.transaction do
      if direction == 'down' && can_move_down
        next_sibling = self.get_next_sibling

        # decrease left and right values of next node and it's children
        difference = self.right_value - self.left_value + 1
        pages1 = Page.where("left_value >= :left_value AND right_value <= :right_value", {:left_value => next_sibling.left_value, :right_value => next_sibling.right_value})
        pages1_ids = pages1.pluck(:id)
        pages1.update_all("left_value = left_value - #{difference}, right_value = right_value - #{difference}")

        # increase left and right values of this node and it's children
        difference = next_sibling.right_value - next_sibling.left_value + 1
        pages2 = Page.where("id NOT IN (:page_id_list) AND left_value >= :left_value AND right_value <= :right_value", {:page_id_list => pages1_ids, :left_value => self.left_value, :right_value => self.right_value})
        pages2.update_all("left_value = left_value + #{difference}, right_value = right_value + #{difference}")
      elsif direction == 'up' && can_move_up
        previous_sibling = self.get_previous_sibling

        # increase left and right values of previous node and it's children
        difference = self.right_value - self.left_value + 1
        pages1 = Page.where("left_value >= :left_value AND right_value <= :right_value", {:left_value => previous_sibling.left_value, :right_value => previous_sibling.right_value})
        pages1_ids = pages1.pluck(:id)
        pages1.update_all("left_value = left_value + #{difference}, right_value = right_value + #{difference}")

        # decrease left and right values of this node and it's children
        difference = previous_sibling.right_value - previous_sibling.left_value + 1
        pages2 = Page.where("id NOT IN (:page_id_list) AND left_value >= :left_value AND right_value <= :right_value", {:page_id_list => pages1_ids, :left_value => self.left_value, :right_value => self.right_value})
        pages2.update_all("left_value = left_value - #{difference}, right_value = right_value - #{difference}")
      end
    end
  end

  private
    def get_descendent_count
      (self.right_value - self.left_value - 1) / 2
    end

    def get_descendents
      Page.where("left_value > :left_value AND right_value < :right_value", {left_value: self.left_value, right_value: self.right_value})
    end

    def get_first_child
      Page.where("left_value = :left_value", {left_value: self.left_value + 1}).first
    end

    def get_last_child
      Page.where("right_value = :right_value", {right_value: self.right_value - 1}).first
    end

    def get_path
      Page.where("left_value < :left_value AND right_value > :right_value", {left_value: self.left_value, right_value: self.right_value})
    end

    def has_descendents
      get_descendents.present?
    end

    def is_child
      self.ancestor_id != 0
    end

    def is_leaf
      get_descendent_count == 0
    end

    def set_depth
      ancestor = self.get_ancestor
      self.depth = ancestor.depth.nil? ? 1 : ancestor.depth + 1
    end

    def set_left_and_right_values_on_create
      ActiveRecord::Base.transaction do
        ancestor = self.get_ancestor
        ancestor.right_value ||= 0
        self.left_value = ancestor.right_value == 0 ? 1 : ancestor.right_value
        self.right_value = ancestor.right_value == 0 ? 2 : ancestor.right_value + 1
        Page.where("left_value > :starting_value", {starting_value: ancestor.right_value - 1}).update_all('left_value = left_value + 2')
        Page.where("right_value > :starting_value", {starting_value: ancestor.right_value - 1}).update_all('right_value = right_value + 2')
      end
    end

    def set_left_and_right_values_on_destroy
      ActiveRecord::Base.transaction do
        Page.where("left_value > :starting_value", {starting_value: self.left_value}).update_all('left_value = left_value - 2')
        Page.where("right_value > :starting_value", {starting_value: self.left_value}).update_all('right_value = right_value - 2')
      end
    end

    def set_slug
      ancestor = self.get_ancestor
      slug = ''
      if ancestor.persisted?
        if !ancestor.is_root
          slug = ancestor.slug << '/'
        end
        slug << self.title.to_s.gsub(/[^0-9A-Za-z]/, '-').downcase
        while slug_exists(slug) do
          slug << '-'
        end
      end
      self.slug = slug
    end

    def slug_exists(slug)
      Page.where(slug: slug).count > 0
    end
end
