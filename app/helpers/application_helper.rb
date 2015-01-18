module ApplicationHelper

  def format_date(the_date)
    the_date.strftime("%d %B %Y %H:%M")
  end

  def get_navigation
    current_level = previous_level = 0
    result = ''
    pages = Page.select("title, slug, left_value, depth").order('left_value')
    pages.each do |page|
      page_location = page.left_value == 1 ? root_path : '/' << page.slug
      link = link_to(page.title, page_location)
      current_level = page.depth == 1 ? 2 : page.depth
      if current_level > previous_level
        result << '<ul><li>' << link
      elsif current_level < previous_level
        tmp = previous_level
        while tmp > current_level do
          result << '</li></ul>'
          tmp-=1
        end
        result << '</li><li>' << link
      else
        result << '</li>' << '<li>' << link
      end
      previous_level = current_level
    end
    tmp = current_level
    while tmp > 1 do
      result << '</li></ul>'
      tmp-=1
    end
    return result
  end

  def get_search_result_link(the_class, title, slug)
    if the_class.downcase == 'page'
      if slug.length > 0
        url = slug
      else
        url = root_path
      end
    else
      url = "#{public_articles_path}/#{slug}"
    end
    link_to(title, url)
  end

end
