
class Recipient

  attr_reader :name, slack_id

  def initialize(name, slack_id)
    @name = name
    @slack_id = slack_id
  end

end