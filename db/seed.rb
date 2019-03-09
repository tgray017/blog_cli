require_relative '../config/environment.rb'

class Seed
  def self.seed_database
    ActiveRecord::Base.logger = Logger.new(STDOUT)
    tom = User.new(:first_name => "Tom", :last_name => "Gray", :email => "tom@gmail.com", :password => "ilovewilson")
    tom.posts.build(:title => "How to code", :content => "Lorem ipsum dolor amet schlitz umami sustainable hexagon typewriter shabby chic. Stumptown synth seitan VHS drinking vinegar readymade. Vaporware letterpress selvage, brunch kombucha kale chips mlkshk master cleanse kitsch glossier deep v sartorial cornhole farm-to-table cray. Kickstarter art party succulents, pop-up disrupt vaporware brunch banjo roof party literally. Umami iPhone tote bag marfa blue bottle brunch typewriter viral la croix. Plaid hot chicken man braid air plant iPhone 90's occupy meggings small batch readymade pok pok hell of pop-up hexagon.")
    tom.posts.build(:title => "Wilson is the best dog in the whole world", :content => "Air plant bitters hot chicken, edison bulb XOXO iceland polaroid bushwick retro try-hard. Ennui you probably haven't heard of them tattooed austin bespoke retro, pinterest tacos narwhal actually deep v stumptown knausgaard swag. 90's biodiesel chicharrones edison bulb flannel. Gochujang ramps cornhole meh aesthetic, dreamcatcher church-key kombucha celiac cardigan tumblr lomo. Selvage street art organic 3 wolf moon, paleo lumbersexual neutra vice humblebrag disrupt cornhole kitsch church-key.")
    tom.save

    victoria = User.new(:first_name => "Victoria", :last_name => "Gray", :email => "victoria@gmail.com", :password => "ilovewilsonmore")
    commented_post = Post.where(:title => "Wilson is the best dog in the whole world").first
    wilson_comment = victoria.comments.build(:content => "Yes he is!")
    wilson_comment.post = commented_post
    victoria.posts.build(:title => "Sleeping is awesome", :content => "Cloud bread fingerstache offal unicorn drinking vinegar ennui. Four dollar toast pinterest irony kinfolk iPhone celiac, listicle photo booth unicorn authentic. Asymmetrical beard waistcoat shabby chic deep v unicorn air plant tilde cornhole +1 tattooed PBR&B. Vape shoreditch lomo before they sold out trust fund pinterest typewriter aesthetic. Pickled pug pok pok artisan neutra activated charcoal pabst you probably haven't heard of them man braid subway tile. Hot chicken sriracha street art, offal chia try-hard cornhole organic.")
    victoria.save

    other_commented_post = Post.where(:title => "Sleeping is awesome").first
    sleep_comment = tom.comments.build(:content => "I do so humbly agree.")
    sleep_comment.post = other_commented_post
    tom.save
  end
end
