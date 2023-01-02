
get '/plays/:id' do
  redirect "/plays/#{params[:id]}?g=#{params[:g]}"
end

# Redirects for men plays
get '/plays/:id' do
  if params[:g] == '3'
    redirect "/men/plays/#{params[:id]}"
  end
end

# Redirects for women plays
get '/plays/:id' do
  if params[:g] == '2'
    redirect "/women/plays/#{params[:id]}"
  end
end