module ApplicationHelper
  def active_path(*paths)
    paths = [paths].flatten
    paths.inject(false) { |cond, path| cond || current_page?(send(path)) } ? 'active' : nil
  end

  def items_active
    active_path('items_path')
  end

  def item_new_active
    active_path('new_item_path')
  end

  def stores_active
    'active' if controller.controller_name == 'stores'
  end

  def categories_active
    'active' if controller.controller_name == 'categories'
  end
end
