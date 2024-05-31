require './spec/spec_helper'

RSpec.describe Class do
  before(:each) do
    @election = Election.new("2024")
    @race = Race.new("Texas Governor")
  end

  describe '#initialize' do
    it 'exists with attributes' do
      expect(@election).to be_a Election
      expect(@election.year).to eq("2024")
      expect(@election.races).to eq []
    end
  end

  describe '#add_race' do
    it 'can keep track of many races' do
      @election.add_race(@race)

      expect(@election.races).to eq [@race]
    end
  end

  describe '#candidates' do
    it "can list all candidates in the election" do
      candidate1 = @race.register_candidate!({name: "Diana D", party: :democrat})
      candidate2 = @race.register_candidate!({name: "Roberto R", party: :republican})
      @election.add_race(@race)

      expect(@election.candidates).to eq [candidate1, candidate2]
    end
  end

  describe '#vote_count' do
    it 'can return hash with candidate => vote count' do
      candidate1 = @race.register_candidate!({name: "Diana D", party: :democrat})
      candidate2 = @race.register_candidate!({name: "Roberto R", party: :republican})
      @race.register_candidate!({name: "Roberto R", party: :republican})
      @election.add_race(@race)

      expect(@election.vote_count).to eq ({"Diana D" => 0, "Roberto R" => 0})

      candidate1.vote_for!

      expect(@election.vote_count).to eq ({"Diana D" => 1, "Roberto R" => 0})
    end
  end
end