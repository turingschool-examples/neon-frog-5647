require './spec/spec_helper'

RSpec.describe Candidate do
  before(:each) do
    @diana = Candidate.new({name: "Diana D", party: :democrat})
  end

  describe '#initialize' do
    it 'exists with attributes' do
      expect(@diana).to be_a Candidate
      expect(@diana.name).to eq("Diana D")
      expect(@diana.party).to eq (:democrat)
      expect(@diana.votes).to be 0
    end
  end

  describe '#vote_for!' do
    it 'can tally a vote' do
      @diana.vote_for!
      @diana.vote_for!
      @diana.vote_for!

      expect(@diana.votes).to be 3
      
      @diana.vote_for!

      expect(@diana.votes).to be 4
    end
  end

end