require 'sinatra/base'
require 'data_mapper'

env = ENV['RACK_ENV'] || 'development'

DataMapper.setup(:default, "postgres://localhost/chitter_#{env}")

require './lib/peep.rb'
require './lib/user.rb'

DataMapper.finalize
DataMapper.auto_upgrade!

class Chitter < Sinatra::Base
  
  set :views, Proc.new { File.join(root, "./views") }
  set :public_folder, Proc.new { File.join(root, ".././public") }

  get '/' do
    @peeps = Peep.all
    erb :index
  end

  get '/sign_up' do 
    erb :sign_up
  end

  post '/sign_up' do 
    user = User.create(:name => params[:name],
                       :email => params[:email],
                       :username => params[:username],
                       :password => params[:password])
    redirect '/'
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end