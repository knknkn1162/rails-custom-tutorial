module ApplicationHelper
  def full_title(page_title = '')
    base_title = 'Ruby on Rails Tutorial Sample App'
    page_title.empty? ? page_title : page_title + ' | ' + base_title
  end
end
