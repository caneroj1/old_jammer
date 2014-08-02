class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
  			 :registerable,
         :recoverable, 
         :rememberable, 
         :trackable, 
         :validatable

  # a user has many messages. these are NOT messages that they send
  # they are messages sent to THEM
  has_and_belongs_to_many :messages
  has_many :songs

  attr_accessible :first_name, 
                  :last_name, 
                  :email, 
                  :password, 
                  :instrument,
                  :state,
                  :city,
                  :street,
                  :lessons,
                  :genres,
                  :statement,
                  :reset_password_token,
                  :password_confirmation,
                  :g1, :g2, :g3, :g4, :g5,
                  :uploaded_songs         # right now, a user can have up to 5 songs

  validates :first_name,  presence: true
  validates :last_name,   presence: true
  validates :instrument,  presence: true

  mount_uploader :avatar, AvatarUploader

  # this will return an output string that will be used
  # to indicate if the musician gives lessons
  def lessons?
    lessons ? 
    ["#{first_name} is interested in giving lessons.", "yes-lessons", true] : 
    ["#{first_name} is not interested in giving lessons at this time.", "no-lessons", false]
  end

  # this function will take the genres associated with this user
  # and return a neat, comma-delimited list with capitalized words
  def neat_genres
    genres.split(',').delete_if { |word| word.eql?("") || word.eql?(" ") }.join(', ')
  end

  # returns the right url to be used as the user's avatar
  # it will either be their uploaded profile picture of the default
  def avatar_url
    uploaded ? avatar.url : "/assets/no_avatar.png"
  end

  # this will return the song according to the specified number in the user's songs array
  def get_song_by_number(number)
    songs.find_by_song_number(number)
  end

  # this will decrement the song numbers of the user's songs when they remove one
  def remove_song(number, urls)
    songs.each do |song|
      if song.song_number.eql?(number.to_i)
        song.delete
      elsif song.song_number > number.to_i
        song.song_number -= 1
        song.url = urls.shift.to_s
        song.save
      end
    end
  end
end
