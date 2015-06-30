categories = YAML.load(File.read(File.join(Rails.root, 'config', 'categories.yml')))

CATEGORIES = Set.new

categories.each do |k, v|
  parent = Category.new(k)

  CATEGORIES.add(parent)

  next if v.blank?

  Array(v).each do |n|
    CATEGORIES.add(Category.new(n, parent))
  end
end
