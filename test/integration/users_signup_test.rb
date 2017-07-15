require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
   test "invalid singup information" do
     assert_no_difference 'User.count' do
       post users_path, params: { users: { name: "",
                                            email: "user@invalid",
                                            password: "foo",
                                            password_confirmation: "bar" }}
     end
     assert_template 'users/new'
   end
end
