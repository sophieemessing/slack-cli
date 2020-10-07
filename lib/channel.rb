class Channel < Recipient

  def self.list_all
    response = HTTParty.get('https://slack.com/api/channels.list', query: {
        token: ENV['SLACK_API_TOKEN']
    })

    pp response

    users = response["members"]

    users.each do |user|
      p user["name"]
    end
  end
end
