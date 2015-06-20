class Presenter
  attr_accessor :model

  def initialize(model)
    @model = model
  end

  def method_missing(meth, *args, &block)
    if @model && @model.respond_to?(meth)
      @model.send(meth, *args, &block)
    else
      super
    end
  end
end
