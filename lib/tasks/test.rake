namespace :test do
  task :env do
    $LOAD_PATH.unshift('lib')
  end

  desc 'Runs only the units in this project'
  task :units => [:env] do
    Dir.glob('./test/**/*_test.rb') { |f| require f }
  end

  desc 'Runs only the specs in this project'
  task :specs => [:env] do
    Dir.glob('./spec/**/*_spec.rb') { |f| require f }
  end

  desc 'Runs all of the tests within this project'
  task :all => [:units, :specs]
end

task :test => ['test:units', 'test:specs']
