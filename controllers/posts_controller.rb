class PostsController < Sinatra::Base

 # sets root as the parent-directory of the current file
 set :root, File.join(File.dirname(__FILE__), '..')
 
 # sets the view directory correctly
 set :views, Proc.new { File.join(root, "views") }

 configure :development do
     register Sinatra::Reloader
 end


 post '/' do

 	post = Post.new #makes a new instance of the class Post
 	post.title = params[:title]
 	post.body = params[:body]

 	
 	post.save
 	redirect '/'

 end

 get '/new' do
 	@post = Post.new
 	@post.id = ""
 	@post.title = ""
 	@post.body= ""

 	erb :'posts/new'
 end

 put '/:id' do

 	#data is gathered in the params object
 	id = params[:id].to_i

 	#load the object with the id
 	post = Post.find id

 	#update the values
 	post.title = params[:title]
 	post.body = params[:body]

 	#save the post
 	post.save


 	redirect "/";

 end

 delete '/:id' do
 	#get the ID
 	id = params[:id].to_i

 	#delete the post from the database
 	Post.destroy id

 	redirect "/"
 end

 get '/:id/edit' do
 	id = params[:id].to_i

 	#make a single post object available in the template
 	@post = Post.find id
 	erb :'posts/edit'

 end

 get '/:id' do

 	#get the ID and turn it into an integer
	id = params[:id].to_i

	#make a single post object available in the template

	@post = Post.find id
	erb :'posts/show'

	end

	get '/' do

	@posts = Post.all

	erb :'posts/index'

	end

end














