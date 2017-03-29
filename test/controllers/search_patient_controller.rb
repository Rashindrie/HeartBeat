require File.dirname(__FILE__) + '/../test_helper'
require 'book_controller'

# Re-raise errors caught by the controller.
class BookController
   def rescue_action(e) 
      raise e 
   end
end

class BookControllerTest < Test::Unit::TestCase
   fixtures :books
   def setup
      @controller = BookController.new
      @request    = ActionController::TestRequest.new
      @response   = ActionController::TestResponse.new
   end

   def test_search_book
      get :search, :title => 'Ruby Tutorial'
      assert_not_nil assigns(:book)
      assert_equal books(:perl_cb).title, assigns(:book).title
      assert_valid assigns(:book)
      assert_redirected_to :action => 'show'
   end

   def test_search_not_found
      get :search, :title => 'HTML Tutorial'
      assert_redirected_to :action => 'list'
      assert_equal 'No such book available', flash[:error]
   end
end
