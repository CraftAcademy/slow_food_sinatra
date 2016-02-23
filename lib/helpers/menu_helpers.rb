module MenuHelpers
  def get_category_name(id)
    Category.get(id).name
  end

  def get_categories
    @categories = []
    Category.each do |cat|
      @categories.push [cat.id, cat.name]
    end
    @categories
  end
end
