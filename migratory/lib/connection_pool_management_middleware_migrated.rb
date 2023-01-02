 # This file was originally written for Padrino 0.13 by
 # Brandon Faloona, then migrated to Sinatra 3.0.5 by
 # GPT-3's text-davinci-003 engine, with prompts from Steven Shults. 
 # December 2022.
 #

# ConnectionPoolManagement class is responsible for managing the connection pool in Sinatra 3.0.5
class ConnectionPoolManagement
  def initialize(app)
    @app = app
  end

  # call method is responsible for establishing a connection to the pool and passing the connection to the app
  def call(env)
    ActiveRecord::Base.connection_pool.with_connection { @app.call(env) }
  end
end