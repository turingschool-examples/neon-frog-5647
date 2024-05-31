class Election
  attr_reader :year, :races, :name_votes_hash
  
  def initialize(year)
    @year = year
    @races = []
  end

  def add_race(race)
    @races << race
  end

  def candidates 
    @races[0].candidates
  end

  def vote_count
    hash = {}
    candidates.each do |candidate|
      hash[candidate.name] = candidate.votes
    end 
    hash
  end
end
