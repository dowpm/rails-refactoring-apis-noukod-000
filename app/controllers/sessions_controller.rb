class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create

  def create
    # response = Faraday.post "https://github.com/login/oauth/access_token", {client_id: ENV["GITHUB_CLIENT_ID"], client_secret: ENV["GITHUB_SECRET"],code: params[:code]}, {'Accept' => 'application/json'}
    # access_hash = JSON.parse(response.body)
    github = GithubService.new
    session[:token] = github.authenticate!(ENV["GITHUB_CLIENT_ID"],ENV["GITHUB_CLIENT_SECRET"], params[:code] )

    # user_response = Faraday.get "https://api.github.com/user", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    # user_json = JSON.parse(user_response.body)
    session[:username] = github.get_username
 
    redirect_to '/'
  end
end