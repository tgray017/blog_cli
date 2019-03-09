require_relative '../config/environment.rb'

class BlogCli
  class Controller
    #attr_accessor :email, :password, :current_user, :input

    def call
      login
      menu
    end

    def login
      puts "Welcome to the blog CLI!"
      puts "Please enter your email to log in."
      print "Email: "
      @email = gets.strip
      puts "Please enter your password."
      print "Password: "
      @password = gets.strip
      @current_user = User.where(:email => @email, :password => @password).first
      if @current_user.nil?
        puts "Login unsuccessful. Try again."
        login
      else
        puts "Login successful!"
      end
    end

    def menu
      puts "What would you like to do?"
      puts <<-MENU
        1. View all posts.
        2. Create a new post.
        3. Comment on a post.
        4. Edit one of your existing posts.
        5. Exit.
      MENU
      @input = gets.strip.to_i
      unless @input.between?(1, 5)
        puts "Invalid input. Try again"
        menu
      end
      input_handling
    end

    def input_handling
      case @input
        when 1 then
          view_all_posts
        when 2 then
          create_post
        when 3 then
          comment_on_post
        when 4 then
          edit_post
        when 5 then
          exit
      end
    end

    def view_all_posts
      display_all_posts
      view_individual_post
      menu
    end

    def view_individual_post
      puts "Would you like to view an individual post? Enter Y/n."
      @input = gets.strip
      case @input.downcase
        when 'y' then
          display_individual_post
        when 'n' then
          #do nothing
        else
          puts "Invalid input. Try again."
          view_individual_post
      end
      menu
    end

    def display_individual_post
      puts "Which post would you like to view?"
      @input = gets.strip.to_i
      unless @input.between?(1, Post.all.size)
        puts "Invalid input. Try again."
        display_individual_post
      end
      @post = Post.all[input_to_index]
      display_post_and_comments
    end

    def create_post
      puts "Enter the title of your new post."
      print "Title: "
      @input = gets.strip
      new_post = @current_user.posts.build(:title => @input)
      puts "Enter the content of your post."
      print "Content: "
      @input = gets.strip
      new_post.content = @input
      @current_user.save
      puts "Post saved!"
      menu
    end

    def input_to_index
      @input - 1
    end

    def comment_on_post
      puts "Which post would you like to comment on?"
      display_all_posts
      @input = gets.strip.to_i

      unless @input.between?(1, Post.all.size)
        puts "Invalid input. Try again."
        comment_on_post
      end
      @post = Post.all[input_to_index]
      display_post_and_comments

      print "Enter your comment: "
      @input = gets.strip
      @post.comments.build(:content => @input, :commentor => @current_user)
      @post.save
      puts "Comment saved!"
      menu
    end

    def display_all_posts
      Post.all.each_with_index do |p, i|
        puts <<-POSTS
          #{i+1}. #{p.title}
            #{p.content[0..200]}...\n
        POSTS
      end
    end

    def display_current_user_posts
      Post.where(:author => @current_user).each_with_index do |p, i|
        puts <<-POSTS
          #{i+1}. #{p.title}
            #{p.content[0..200]}...\n
        POSTS
      end
    end

    def display_post_and_comments
      display_title
      display_content
      display_comments
    end

    def display_title
      puts "#{@post.title}"
    end

    def display_content
      puts "  #{@post.content}"
    end

    def display_comments
      @post.comments.each {|comment| puts "    #{comment.commentor.first_name} #{comment.commentor.last_name}: #{comment.content}"}
    end

    def edit_post
      puts "Which post would you like to edit?"
      display_current_user_posts
      @input = gets.strip.to_i
      unless @input.between?(1, Post.where(:author => @current_user).size)
        puts "Invalid input. Try again."
        edit_post
      end
      edited_post = Post.where(:author => @current_user)[input_to_index]
      puts "Please re-enter the content of your post:"
      print "Content: "
      @input = gets.strip
      edited_post.content = @input
      edited_post.save
      puts "Edits saved!"
      menu
    end

    # Only for testing purposes
    def set_user
      @current_user = User.where(:email => "tom@gmail.com", :password => "ilovewilson").first
    end
  end
end

blog = BlogCli::Controller.new
blog.set_user
blog.call
