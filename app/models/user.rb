class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  	devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable
	has_and_belongs_to_many :groups
	has_many :orders

	has_many :friendships
	has_many :friends, :through => :friendships
	has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
	has_many :inverse_friends, :through => :inverse_friendships, :source => :user



  	has_attached_file :image, styles: { small: "64x64", med: "100x100", large: "200x200" },
  					:url  => "/assets/users/:id/:style/:basename.:extension",
                  	:path => ":rails_root/public/assets/users/:id/:style/:basename.:extension"
  	validates_attachment :image, :presence => true,:content_type => { :content_type => /\Aimage/ },
  						:size => { :in => 0..1000.kilobytes }
	# has_and_belongs_to_many(:users,
 #    :join_table => "user_friends",
 #    :foreign_key => "user_id",
 #    :association_foreign_key => "friend_id")

	# validates :name,  presence: true


	#fb --> shrouk 
	TEMP_EMAIL_PREFIX = 'change@me'
  	TEMP_EMAIL_REGEX = /\Achange@me/

  	validates_format_of :email, :without => TEMP_EMAIL_REGEX, on: :update

	  def self.find_for_oauth(auth, signed_in_resource = nil)

	    # Get the identity and user if they exist
	    identity = Identity.find_for_oauth(auth)

	    # If a signed_in_resource is provided it always overrides the existing user
	    # to prevent the identity being locked with accidentally created accounts.
	    # Note that this may leave zombie accounts (with no associated identity) which
	    # can be cleaned up at a later date.
	    user = signed_in_resource ? signed_in_resource : identity.user

	    # Create the user if needed
	    if user.nil?

	      # Get the existing user by email if the provider gives us a verified email.
	      # If no verified email was provided we assign a temporary email and ask the
	      # user to verify it on the next step via UsersController.finish_signup
	      email_is_verified = auth.info.email && (auth.info.verified || auth.info.verified_email)
	      email = auth.info.email if email_is_verified
	      user = User.where(:email => email).first if email

	      # Create the user if it's a new registration
	      if user.nil?
	        user = User.new(
	          name: auth.extra.raw_info.name,
	          #username: auth.info.nickname || auth.uid,
	          email: email ? email : "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com",
	          password: Devise.friendly_token[0,20]
	        )
	        user.skip_confirmation!
	        user.save!
	      end
	    end

	    # Associate the identity with the user if needed
	    if identity.user != user
	      identity.user = user
	      identity.save!
	    end
	    user
	  end

	  def email_verified?
	    self.email && self.email !~ TEMP_EMAIL_REGEX
	  end
	def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    if user
      return user
    else
      registered_user = User.where(:email => auth.info.email).first
      if registered_user
        return registered_user
      else
        user = User.create(name:auth.extra.raw_info.name,
                            provider:auth.provider,
                            uid:auth.uid,
                            email:auth.info.email,
                            password:Devise.friendly_token[0,20]
                          )
      end
       
    end
  end

  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token.info
    user = User.where(:provider => access_token.provider, :uid => access_token.uid ).first
    if user
      return user
    else
      registered_user = User.where(:email => access_token.info.email).first
      if registered_user
        return registered_user
      else
        user = User.create(name: data["name"],
          provider:access_token.provider,
          email: data["email"],
          uid: access_token.uid ,
          password: Devise.friendly_token[0,20]
        )
      end
   end
end

end


