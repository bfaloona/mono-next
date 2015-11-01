
class User < ActiveRecord::Base
  validates_uniqueness_of :email
  validates_presence_of :email
  validates_presence_of :name
  validates_presence_of :password


  def self.authenticate(email, password)
    user = self.find_by_email(email)
    if user
      if user.password != password
        APPLOG.warn "User #{email} entered a bad password"
        return false
      else
        APPLOG.info "User #{email} logged in"
        return user
      end
    else
      APPLOG.warn "User #{email} does not exist"
      return false
    end
  end
end
