require 'pry'
require 'pg'
require 'sinatra'
require 'sinatra/contrib/all' if development?

# root to /videos
get '/' do
  redirect to '/videos'
  erb :index
end

# show the videos
get '/videos' do
  sql = 'SELECT * FROM videos;'
  @videos = run_sql(sql)
  # checking if its a ajax request?
  if request.xhr?
    # Convert the pg object into an array
    json @videos.to_a
  else
    erb :index
  end
end

delete '/videos/:id/delete' do
  sql = "delete from videos where id = #{params[:id]}"
  run_sql(sql)
  if request.xhr?
    json [{status: :ok}]
  else
    redirect to '/videos'
  end
end

post '/videos' do 
  title = params[:title]
  description = params[:description]
  url = params[:url]
  genre = params[:genre]
  sql = "update videos set title = '#{params[:title]}', description = '#{params[:description]}', url = '#{params[:url]}', genre = '#{params[:genre]}' where id = #{params[:id]}"
    @video = run_sql(sql).first
  if request.xhr?
    json @video
  else
    redirect_to '/videos'
  end
end

put '/videos/:id' do
  title = params[:title]
  description = params[:description]
  url = params[:url]
  genre = params[:genre]
  # look up the item in the datatbase using its id and then update the done column
  sqp = "update videos set title = '#{params[:title]}', description = '#{params[:description]}', url = '#{params[:url]}', genre = '#{params[:genre]}' where id = #{params[:id]}"
  run_sql(sql)
  if request.xhr?
    json [{status: :ok}]
  else 
    redirect_to '/videos'
  end
end

private

def run_sql(sql)
  conn = PG.connect(dbname: 'video_app', host: 'localhost')
  begin
    result = conn.exec(sql)
  ensure
    conn.close
  end
  result
end