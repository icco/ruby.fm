class Presenter
  def initialize(model)
    @model = model
  end

  def method_missing(meth, *args, &block)
    if @model.respond_to?(meth)
      @model.send(meth, *args, &block)
    else
      super
    end
  end
end
