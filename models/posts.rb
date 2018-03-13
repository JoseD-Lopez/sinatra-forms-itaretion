class Post

	attr_accessor :id, :title, :body

	def self.open_connection #self means that this method is a part of the class
		conn = PG.connect(dbname: "blog") #connection with the database

	end 

	def self.all
		conn = self.open_connection

		sql = 'SELECT id, title, body FROM post ORDER BY id'

		result = conn.exec(sql)

		posts = result.map do |tuple|

			self.hydrate tuple

		end

		posts
	end

	def self.hydrate post_data

		post = Post.new 

		post.id = post_data['id']
		post.title = post_data['title']
		post.body = post_data['body']

		post

	end

	def self.find id

		conn = self.open_connection

		sql = "SELECT id, title, body FROM post WHERE id = #{id}"

		result = conn.exec(sql)
		
		posts =	self.hydrate result[0]
		
	end

	def save

		conn = Post.open_connection

		sql = "INSERT INTO post (title , body) VALUES ('#{self.title}', '#{self.body}')"

		

		result = conn.exec(sql)

	end

	def self.edit id

		conn = Post.open_connection

		sql = "UPDATE WHERE id = #{id} VALUES ('#{self.title}' , '#{self.body}')"

		result = conn.exec(sql)

		posts =	self.hydrate result[0]
	end

	def self.destroy id

     conn = Post.open_connection

     sql = "DELETE FROM post where id = #{id}"

     # handle delete here
     conn.exec(sql)

end

end