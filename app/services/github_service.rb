class GithubService

  def self.contributors
    users = Hash.new
    content = conn.get("/repos/yosoynatebrown/little-esty-shop/contributors?page=2?access_token=fff")
    body = parse_response(content)
    body.each do |user|
      users[user[:login]] = user[:contributions]
    end
    users
  end

  def self.merged_pr_count
    parse_response("/search/issues?q=repo:yosoynatebrown/little-esty-shop%20type:pr%20is:merged")[:total_count]
  end

  def self.repo_name
    parse_response("/repos/yosoynatebrown/little-esty-shop")[:name]
  end

  def self.parse_response(response)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new(url: "https://api.github.com")
  end
end
