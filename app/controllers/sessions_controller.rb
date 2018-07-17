class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create

  def create
    @service = GithubService.new.authenticate!(ENV["GITHUB_CLIENT"], ENV["GITHUB_SECRET"], params[:code])
    session[:token] = @service.access_token

    redirect_to '/'
  end
end
