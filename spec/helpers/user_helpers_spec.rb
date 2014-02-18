require 'spec_helper'

module ExpenseTracker
  describe UserHelpers do
    include UserHelpers

    describe("logged_user") do
      it "should return nil if no user is logged" do
        logged_user.should be_nil
      end

      it "should return nil if session has incorrect user id" do
        session[:user_id] = 0
        logged_user.should be_nil
      end

      it "should return user if correct user id is in session" do
        session[:user_id] = create_user.id
        logged_user.should_not be_nil
      end
    end

    describe "#get_secure_password" do
      it "should return a secure password not containing the original string" do
        password = "some_password"
        secure_password = get_secure_password password
        secure_password.include?(password).should be_false
      end

      it "should return a secure password with atleast 20 characters" do
        password = "some_password"
        secure_password = get_secure_password password
        (secure_password.length >= 20).should be_true
      end
    end

    describe "#validate_new_user_username" do
      it "should return error message if username is less than 5 characters" do
        username = "user"
        validate_new_user_username(username).should_not be_nil
      end

      it "should return error message if username has invalid characters" do
        username = "Потребител"
        validate_new_user_username(username).should_not be_nil
      end

      it "should return error" do
        username = "Kristian"
        create_user(username: username)
        validate_new_user_username(username).should_not be_nil
      end

      it "should return nil if correct username is passed" do
        username = "Kri_sti_an17"
        validate_new_user_username(username).should be_nil
      end
    end

    describe "#validate_new_user_email" do
      it "should return error message if email is invalid" do
        email = "asd.com"
        validate_new_user_email(email).should_not be_nil
      end

      it "should return error message if email exists" do
        email = "abv@abv.bg"
        create_user(email: email)
        validate_new_user_email(email).should_not be_nil
      end

      it "should return nil if correct email is passed" do
        email = "kristian_17@google.com"
        validate_new_user_email(email).should be_nil
      end
    end

    describe "#validate_new_user_password" do
      it "should return error message if passwords don't match" do
        validate_new_user_password("123456789", "").should_not be_nil
      end

      it "should return error message if password is shorter than 6 symbols" do
        validate_new_user_password("12345", "12345").should_not be_nil
      end

      it "should return nil if correct password is passed" do
        validate_new_user_password("12345678", "12345678").should be_nil
      end
    end
  end
end