class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create

  def create
    @service = GithubService.new.authenticate!(client_id: ENV["GITHUB_CLIENT"], client_secret: ENV["GITHUB_SECRET"], code: params[:code])
    session[:token] = @service.access_token

    redirect_to '/'
  end
end
