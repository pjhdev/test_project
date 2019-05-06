module HttpHelper
  def self.make_post_req
    begin
      uri = URI('http://planet.oozoogames.com:9090/account/index')
      http = Net::HTTP.new(uri.host, uri.port)
      header = {'Content-Type' =>'application/json'}
      req = Net::HTTP::Post.new(uri.path, header)
      req.body = {"nick" => "zeze"}.to_json
      res = http.request(req)
      Rails.logger.info(res.body.as_json)
    rescue => e
      puts "failed #{e}"
    end
  end

  def get

  end
end