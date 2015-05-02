# Note that the following User authentication implementation is equivalent to:
# class User < ActiveRecord::Base
#	has_secure_password
##  ^^^^^^^^^^^^^^^^^^^ !
#
#	def self.confirm(email_param, password_param)
#    	user = User.find_by({email: email_param})
#    	user.authenticate(password_param)
#  	end
# end

class User < ActiveRecord::Base
	# Generates a random salt with a given computational cost; the num
	# 12 corresponds to some period of time, in milliseconds
	BCrypt::Engine.cost = 12

	# Ruby-provided helper method for creating a getter method for
	# the password instance variable
	attr_reader :password

	# This validation creates a virtual attribute whose name is the name 
	# of the field that has to be confirmed with "_confirmation" appended.
	validates_confirmation_of :password

	validates_presence_of :password_digest

	# Successful authentication returns the user instance, whereas a failed
	# authentication returns false

	# Example:
	# > user = User.create({email: "a@a.com", password: "a", 
	#          password_confirmation: "a"})
	# > friend.authenticate("b")
	# => false

	def authenticate(unencrypted_password)
		if BCrypt::Password.new(password_digest) == unencrypted_password
			self
    	else
    		false
    	end
  	end

  	# Note carefully the equals in the following method def ...
  	# This is a setter override, which is then called anytime that we
  	# assign something to user.password.  Rather than saving the password
  	# in plain text onto the user instance, this allows us to first
  	# hash it, and only then, once hashed, we save it to the db & the 
  	# private instance variable password_digest.

	# # Let's create our first password
	# 2.1.0 :001 > BCrypt::Password.create("foobar")
	#  => "aMQQCxBpfu16koDVs3zkbeSXn1z4fqKx9xLp4.UOBQBDkgFaukWM2"

	# # Let's save our password to a variable
	# 2.1.0 :002 > pswrd = BCrypt::Password.create("foobar")
	# => "a/2eORAUxpP925ZClCObaIuWdsk4b0lm2Hnt4c2e8G7qzyqcvu"

	# # Let's compare our password to another
	# 2.1.0 :003 > pswrd == "blah"
	# => false
	#    ^^^^^ !

	# # Let's compare our password to original
	# 2.1.0 :004 > pswrd == "foobar"
	# => true
	#    ^^^^ !

	def password=(unencrypted_password)
    	if unencrypted_password.nil?
      		self.password_digest = nil
    	else
    		# when not nil, update password just for temporary reference
    		@password = unencrypted_password

    		# update password_digest using hashing algorithm
    		self.password_digest = BCrypt::Password.create(@password)
    	end
	end

	# The use of self within the method name makes this a class method, and
	# that makes sense because this method operates outside of the context
	# of any particular user instance
	
	def self.confirm(email_param, password_param)
 		user = User.find_by({email: email_param})
    	user.authenticate(password_param)
	end
end
