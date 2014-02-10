require 'test_helper'

class CustomRoutesTest < ActionDispatch::IntegrationTest
   test "route /login directs to seesion#new" do
     get '/login'
     assert_response :success
   end
   test "route /logout directs to seesion#destroy" do
     get '/logout'
     assert_response :redirect
     assert_redirected_to '/'
   end
   test "route /sign_up directs to registrations#new" do
     get '/sign_up'
     assert_response :success
   end
   test "get user profile" do
     get '/cyberstrike'
     assert_response :success
   end
end
