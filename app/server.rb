require 'sinatra/base'
require 'data_mapper'
require 'rack-flash'

env = ENV['RACK_ENV'] || 'development'

DataMapper.setup(:default, "postgres://localhost/chitter_#{env}")

require './lib/peep.rb'
require './lib/user.rb'

DataMapper.finalize
DataMapper.auto_upgrade!

class Chitter < Sinatra::Base
  
  set :views, Proc.new { File.join(root, "./views") }
  set :public_folder, Proc.new { File.join(root, ".././public") }
  enable :sessions
  set :session_secret, 'super secret'

  use Rack::Flash
  use Rack::MethodOverride

  get '/' do
    @peeps = Peep.all
    erb :index
  end

  get '/sign_up' do 
    erb :sign_up
  end

  post '/sign_up' do 
    @user = User.create(:name => params[:name],
                       :email => params[:email],
                       :username => params[:username],
                       :password => params[:password])
    if @user.save
      flash[:notice] = "Welcome to Chitter. May all you peeps be inspirational"
      redirect '/'
    else 
      if User.all.map {|user| user.username }.include? (params[:username])
        flash.now[:error] = "Username has already been taken."
      elsif User.all.map {|user| user.email }.include? (params[:email])
        flash.now[:error] = "Email address has already been taken."
      else
        flash.now[:error] = "Please try again."
      end
      erb :sign_up
    end
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end