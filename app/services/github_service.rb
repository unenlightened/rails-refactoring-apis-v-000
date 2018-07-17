class GithubService
  attr_reader :access_token, :repos

  def initialize(access_hash = {})
    @access_token = access_hash["access_token"]
    @repos = []
  end

  def authenticate!(client_id, client_secret, code)
    response = Faraday.post "https://github.com/login/oauth/access_token",
      {client_id: client_id, client_secret: client_secret, code: code},
      {'Accept' => 'application/json'}
    json = JSON.parse(response.body)
    @access_token = json["access_token"]
    json
  end

  def get_username
    response = Faraday.get "https://api.github.com/user", {},
      {'Authorization' => "token #{access_token}", 'Accept' => 'application/json'}
    json = JSON.parse(response.body)
    json["login"]
  end

  def get_repos
    response = Faraday.get "https://api.github.com/user/repos", {},
      {'Authorization' => "token #{access_token}", 'Accept' => 'application/json'}
    json = JSON.parse(response.body)
    build_repos(json)
  end

  def build_repos(json)
    json.each do |repo_hash|
      @repos << GithubRepo.new(repo_hash)
    end
    @repos
  end

  def create_repo(name)
    response = Faraday.post "https://api.github.com/user/repos",
    {name: name}.to_json,
    {'Authorization' => "token #{access_token}", 'Accept' => 'application/json'}
  end
end
