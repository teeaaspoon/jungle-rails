class User < ActiveRecord::Base
    has_secure_password

    has_many :reviews

    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :email, presence: true, uniqueness: { case_sensitive: false }
    validates :password, length: { minimum: 3 }
    validates :password_confirmation, length: { minimum: 3 }
    validates :password_digest, presence: true

    #force lower case of email before save
    before_save { |user| user.email = user.email.downcase }

    def self.authenticate_with_credentials(email, password)
        # remove leading and trailing whitespace from email
        email = email.strip
        # force lower case of email
        email = email.downcase
        @user = User.find_by_email(email)
        if @user && @user.authenticate(password)
            return @user
        else
            nil
        end
    end

end
