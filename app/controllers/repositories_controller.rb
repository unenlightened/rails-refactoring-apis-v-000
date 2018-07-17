class RepositoriesController < ApplicationController
  before_action :create_service
  
  def index
    @repos_array = service.get_repos
  end

  def create
    service.create_repo(params[:name])
    redirect_to '/'
  end

  private
  def create_service
    service = GithubService.new(access_token: session[:token])
  end
end
