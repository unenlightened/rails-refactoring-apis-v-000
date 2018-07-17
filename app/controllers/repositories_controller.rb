class RepositoriesController < ApplicationController
  before_action :get_service

  def index
    @username = @service.get_username
    @repos_array = @service.get_repos
  end

  def create
    @service.create_repo(params[:name])
    redirect_to '/'
  end

  private

  def get_service
    @service ||= GithubService.new("access_token" => session[:token])
  end

end
