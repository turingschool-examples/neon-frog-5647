class Race
  attr_reader :office, :candidates, :open
  
  def initialize(office)
    @office = office
    @candidates = []
    @open = true
  end

  def register_candidate!(name_party_hash)
    candidate = Candidate.new(name_party_hash)
    @candidates << candidate
    candidate
  end

  def open?
    @open
  end

  def close!
    @open = !@open
  end

  # IDEAS:
  # I realize i dont have access to the hash formed in Election
  # because election is not passed into race... race is passed into election.

  # Im thinking i need to form a similar hash in the race class
  # to then use the enumerable below. Is there an easier way?
  def winner
    hash = @election.vote_count
    if @open
      false
    else hash.max_by do |name_string, votes|
      votes.max
      end
    end
  end

end
