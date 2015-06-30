class Category
  attr_accessor :name, :parent

  def self.all
    CATEGORIES
  end

  def self.children
    all.select { |c| c.child? }
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

  def to_s
    if parent
      "#{parent.to_s}: #{name}"
    else
      name
    end
  end
end
