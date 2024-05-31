class Candidate
  attr_reader :name, :party, :votes
  
  attr_writer :votes

  def initialize(name_party_hash)
    @name = name_party_hash[:name]
    @party = name_party_hash[:party]
    @votes = 0
  end

  def vote_for!
    @votes += 1
  end
end
