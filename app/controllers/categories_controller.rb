class CategoriesController < ApplicationController
  load_and_authorize_resource except: [:create]

  def index
    @search = params[:search] || {}
    @categories = Category.by_account(current_user)
                          .search(params[:search])
                          .paginate(:page => params[:page])
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(permitted_params)
    @category.account = current_user.account if current_user.account

    if @category.save
      redirect_to category_path(@category)
    else
      render 'new'
    end
  end

  def edit
    @category = find_record
  end

  def update
    @category = find_record
    if @category.update(permitted_params)
      redirect_to category_path(@category)
    else
      render 'edit'
    end
  end

  def show
    @category = find_record
  end

  def destroy
    @category = find_record
    @category.destroy

    redirect_to categories_path
  end

  private

  def permitted_params
    params[:category].permit(:id, :name)
  end

  def find_record
    Category.find_record(params[:id], current_user.account)
  end
end
