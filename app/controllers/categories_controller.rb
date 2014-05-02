class CategoriesController < ApplicationController
  load_and_authorize_resource except: [:create]

  def index
    @search = params[:search] || {}
    @categories = Category.search(params[:search]).paginate(:page => params[:page])
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(permitted_params)

    if @category.save
      redirect_to category_path(@category)
    else
      render 'new'
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(permitted_params)
      redirect_to category_path(@category)
    else
      render 'edit'
    end
  end

  def show
    @category = Category.find(params[:id])
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy

    redirect_to categories_path
  end

  private


  def permitted_params
    params[:category].permit(:id, :name)
  end
end
