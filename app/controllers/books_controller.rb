class BooksController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    if current_user
      @books = Book.where(language: current_user.preferred_language )
    else
      @books = Book.all
    end
  end

  def show
    @book = Book.find(params[:id])
    @review = Review.new
  end

  # Do I need this function?
  # def search
  #   user_input =
  #   @books = Book.search_by_country("#{user_input}")
  # end

end
