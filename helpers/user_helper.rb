require 'digest/sha1'

module UserHelpers
  def logged_user
    User.find(id: session[:user_id])
  end

  def logged?
    not logged_user.nil?
  end

  def get_secure_password(password)
    salt = [123, 32, 43, 53, 13, 54, 100, 11, 23, 68, 1, 88]
    salted_bytes = password.bytes.each_with_index.map { |byte, index| byte ^ salt[index % salt.length] }
    secure_password = salted_bytes.map { |byte| byte.chr }.join
    Digest::SHA1.hexdigest secure_password
  end

  def validate_new_user(username, email, password1, password2)
    error_message = validate_new_user_username(username) unless error_message
    error_message = validate_new_user_email(email) unless error_message
    error_message = validate_new_user_password(password1, password2) unless error_message
    error_message
  end

  def validate_new_user_username(username)
    return "Username should be atleast 5 symbols long!" if username.length < 5
    if /\w*/.match(username).to_s != username
      return "Username contains illegal characters. Only a-z,A-Z,0-9 and '_' are allowed!." 
    end

    return "A user with this username already exists!" if User.find(username: @username)
  end

  def validate_new_user_email(email)
    unless /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/.match(email)
      return "Not a valid email address!";
    end
  end

  def validate_new_user_password(password1, password2)
    return "Passwords don't match!" if password1 != password2
    return "Password should be alteast 6 characters" if password1.length < 6
  end
end