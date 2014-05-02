class AccountsController < ApplicationController
  load_and_authorize_resource

  def index
    @search = params[:search] || {}
    @accounts = Account.all #search(params[:search]).paginate(:page => params[:page])
  end

  def new
    @account = Account.new
  end

  def create
    @account = Account.new(permitted_params)

    if @account.save
      redirect_to account_path(@account)
    else
      render 'new'
    end
  end

  def edit
    @account = Account.find(params[:id])
  end

  def update
    @account = Account.find(params[:id])
    if @account.update(permitted_params)
      redirect_to account_path(@account)
    else
      render 'edit'
    end
  end

  def show
    @account = Account.find(params[:id])
  end

  def destroy
    @account = Account.find(params[:id])
    @account.destroy

    redirect_to accounts_path
  end

  private

  def permitted_params
    params[:account].permit(:id, :name)
  end
end
