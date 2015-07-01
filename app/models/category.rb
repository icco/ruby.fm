class Category
  attr_accessor :name, :parent

  def self.all
    CATEGORIES
  end

  def self.children
    all.select { |c| c.child? }
  end

  def self.grouped
    hash = {}
    all.each do |category|
      if category.root?
        if category.children?
          hash[category.name] = []
        else
          hash[category.name] = [category.name]
        end
      else
        hash[category.parent.name] << category.name
      end
    end
    hash
  end

  def self.find(name)
    all.find { |c| c.name == name }
  end

  def initialize(name, parent=nil)
    @name = name
    @parent = parent
  end

  def root?
    @parent.nil?
  end

  def child?
    !root?
  end

  def children?
    CATEGORIES.any? { |c| c.parent == self }
  end

  def to_s
    if parent
      "#{parent.to_s}: #{name}"
    else
      name
    end
  end
end
