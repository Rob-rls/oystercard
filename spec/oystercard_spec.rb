require 'oystercard'
describe Oystercard do

  context "initialize" do

    it "initializes the Oystercard with a default balance of 0" do
      expect(subject.balance).to eq 0
    end
  end

  context "#top_up" do

    it "adds a value to the balance" do
      expect { subject.top_up(50) }.to change{ subject.balance }.by 50
    end

    it "not allowed to go over the maximum balance" do
      maximum_balance = Oystercard::MAXIMUM_BALANCE
      subject.top_up(maximum_balance)
      expect {subject.top_up(1)}.to raise_error "Maximum balance of #{maximum_balance} exceeded"
    end
  end

  context "#deduct" do

    it "reduces the balance" do
      subject.top_up(10)
      expect { subject.deduct(2) }.to change{ subject.balance }.by -2
    end

  end


end
