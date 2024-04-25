require './lib/election'
require './lib/race'
require './lib/candidate'

RSpec.describe "Election Day" do
  describe "iteration 1" do
    it '1. Candidate instantiation' do
      diana = Candidate.new({name: "Diana D", party: :democrat})
      expect(diana).to be_a(Candidate)
    end

    it '2. Candidate attributes' do
      diana = Candidate.new({name: "Diana D", party: :democrat})
      roberto = Candidate.new({name: "Roberto R", party: :republican})
      expect(diana.name).to eq("Diana D")
      expect(diana.party).to eq(:democrat)
      expect(roberto.name).to eq("Roberto R")
      expect(roberto.party).to eq(:republican)
    end

    it '3. #votes and #vote_for!' do
      diana = Candidate.new({name: "Diana D", party: :democrat})
      expect(diana.votes).to eq(0)
      diana.vote_for!
      diana.vote_for!
      diana.vote_for!
      expect(diana.votes).to eq(3)
      diana.vote_for!
      expect(diana.votes).to eq(4)
    end
  end

  describe "iteration 2" do
    it '4. Race instantiation and attributes' do
      race = Race.new("Texas Governor")
      expect(race).to be_a(Race)
      expect(race.office).to eq("Texas Governor")
    end

    it '5. #register_candidate' do
      race = Race.new("Texas Governor")
      expect(race.candidates).to eq([])
      candidate1 = race.register_candidate!({name: "Diana D", party: :democrat})
      candidate2 = race.register_candidate!({name: "Roberto R", party: :republican})
      expect(race.candidates).to eq([candidate1, candidate2])
      expect(candidate1).to be_a(Candidate)
      expect(candidate1.name).to eq("Diana D")
      expect(candidate1.party).to eq(:democrat)
    end
  end
  describe "iteration 3" do
    it '6. Election instantiation and attributes' do
      election = Election.new('2022')
      expect(election).to be_a(Election)
      expect(election.year).to eq('2022')
    end

    it '7. #add_race' do
      election = Election.new('2022')
      expect(election.races).to eq([])
      race1 = Race.new("Virginia District 4 Representative")
      race2 = Race.new("Texas Governor")
      election.add_race(race1)
      election.add_race(race2)
      expect(election.races).to eq([race1, race2])
    end

    it '8. #candidates' do
      election = Election.new('2022')
      race1 = Race.new("Virginia District 4 Representative")
      race2 = Race.new("Texas Governor")
      candidate1 = race1.register_candidate!({name: "Diana D", party: :democrat})
      candidate2 = race1.register_candidate!({name: "Roberto R", party: :republican})
      candidate3 = race2.register_candidate!({name: "Diego D", party: :democrat})
      candidate4 = race2.register_candidate!({name: "Rita R", party: :republican})
      candidate5 = race2.register_candidate!({name: "Ida I", party: :independent})
      election.add_race(race1)
      election.add_race(race2)
      expect(election.candidates).to eq([candidate1, candidate2, candidate3, candidate4, candidate5])
    end

    it '9. #vote_counts' do
      election = Election.new('2022')

      race1 = Race.new("Texas Governor")
      candidate1 = race1.register_candidate!({name: "Diana D", party: :democrat})
      candidate2 = race1.register_candidate!({name: "Roberto R", party: :republican})

      race2 = Race.new("Virginia District 4 Representative")
      candidate3 = race2.register_candidate!({name: "Diego D", party: :democrat})
      candidate4 = race2.register_candidate!({name: "Rita R", party: :republican})
      candidate5 = race2.register_candidate!({name: "Ida I", party: :independent})

      election.add_race(race1)
      election.add_race(race2)

      4.times {candidate1.vote_for!}
      1.times {candidate2.vote_for!}
      10.times {candidate3.vote_for!}
      6.times {candidate4.vote_for!}
      6.times {candidate5.vote_for!}

      expected = {
        "Diana D" => 4,
        "Roberto R" => 1,
        "Diego D" => 10,
        "Rita R" => 6,
        "Ida I" => 6
      }
      expect(election.vote_counts).to eq(expected)
    end
  end
  describe "iteration 4" do
    it '10. Race#open?' do
      race = Race.new("Texas Governor")

      expect(race.open?).to be(true)
      race.close!
      expect(race.open?).to be(false)
    end

    it '11. Race#winner' do
      race = Race.new("Texas Governor")
      candidate1 = race.register_candidate!({name: "Diana D", party: :democrat})
      candidate2 = race.register_candidate!({name: "Roberto R", party: :republican})

      4.times {candidate1.vote_for!}
      1.times {candidate2.vote_for!}

      expect(race.winner).to eq(false)
      race.close!
      expect(race.winner).to eq(candidate1)
    end

    it '12. Race#tie?' do
      race = Race.new("Texas Governor")
      candidate1 = race.register_candidate!({name: "Diana D", party: :democrat})
      candidate2 = race.register_candidate!({name: "Roberto R", party: :republican})

      3.times {candidate1.vote_for!}
      3.times {candidate2.vote_for!}

      race.close!
      expect(race.winner).to eq(candidate1)
      expect(race.tie?).to eq(true)
    end

    it '13. Election#winners' do
      election = Election.new('2022')

      race1 = Race.new("Texas Governor")
      candidate1 = race1.register_candidate!({name: "Diana D", party: :democrat})
      candidate2 = race1.register_candidate!({name: "Roberto R", party: :republican})

      race2 = Race.new("Virginia District 4 Representative")
      candidate3 = race2.register_candidate!({name: "Diego D", party: :democrat})
      candidate4 = race2.register_candidate!({name: "Rita R", party: :republican})
      candidate5 = race2.register_candidate!({name: "Ida I", party: :independent})

      race3 = Race.new("Colorado District 5 Representative")

      election.add_race(race1)
      election.add_race(race2)
      election.add_race(race3)

      4.times {candidate1.vote_for!}
      1.times {candidate2.vote_for!}
      6.times {candidate3.vote_for!}
      6.times {candidate4.vote_for!}
      6.times {candidate5.vote_for!}

      race1.close!
      race2.close!

      expect(election.winners).to eq([candidate1])
    end
  end
end
