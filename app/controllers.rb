RubyFm::App.controllers  do
  layout :main

  get :index do
    render :index
  end

  get :about do
    render :about
  end

  get :login do
    "todo"
  end

  get '/listen/:showname' do
    "todo - #{params.inspect}"
  end

  get '/listen/:showname/:title' do
    "todo - #{params.inspect}"
  end
end
