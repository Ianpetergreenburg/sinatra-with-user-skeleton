enable :sessions

get '/login' do
  @user = User.new
  erb :'login'
end

post '/login' do
  @user = User.find_by(username: params[:user][:username]).try(:authenticate, params[:user][:password])
  if @user
    session_login(@user.id)
    redirect '/'
  else
    erb :'login'
  end
end

get '/logout' do
  session_logout
  redirect '/'
end
