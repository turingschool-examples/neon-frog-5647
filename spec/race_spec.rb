require './spec/spec_helper'

RSpec.describe Race do
   describe '#initialize' do
    it 'exists with attributes' do
      race = Race.new("Texas Governor")

      expect(race).to be_a Race
      expect(race.office).to eq("Texas Governor")
      expect(race.candidates).to eq []
    end
  end

  describe '#register_candidate!' do
    it 'can register candidate' do
      race = Race.new("Texas Governor")
      candidate1 = race.register_candidate!({name: "Diana D", party: :democrat})

      expect(candidate1.class).to be Candidate
      expect(candidate1.name).to eq("Diana D")
      expect(candidate1.party).to eq(:democrat)
    end
  end

  describe '#candidates' do
    it 'can keep track of many registered candidates' do
      race = Race.new("Texas Governor")
      candidate1 = race.register_candidate!({name: "Diana D", party: :democrat})
      candidate2 = race.register_candidate!({name: "Roberto R", party: :republican})

      expect(race.candidates).to eq([candidate1, candidate2])
    end
  end

  describe "#open?" do
    it "can determine if race is open or closed" do
      race = Race.new("Texas Governor")

      expect(race.open?).to be true

      race.close!

      expect(race.open?).to be false
    end
  end

  describe "winner" do  
    it "can determine a winner when race is closed" do
      race = Race.new("Texas Governor")
      candidate1 = race.register_candidate!({name: "Diana D", party: :democrat})
      candidate2 = race.register_candidate!({name: "Roberto R", party: :republican})
      # @election.add_race(@race)

      expect(race.winner).to be false

      candidate1.vote_for!
      race.close!

      expect(race.winner).to eq({"Diana D" => 1}) 
    end
  end


end