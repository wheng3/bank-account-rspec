require "rspec"

require_relative "account"

describe Account do
  let(:acct_number)   { '1234567890' }
  let(:starting_balanace) { 1000 }
  let(:account) { Account.new(acct_number, starting_balanace) }

  describe "#initialize" do
    context "with valid input" do
      it "creates a new Account" do
        expect(account.transactions).to eq([1000])
      end
    end

    context "with invalid input" do
      it "throws an type error when given wrong argument type" do
        expect { Account.new(1234567890) }.to raise_error(NoMethodError)
      end
      it "throws an argument error when account number is less or more than 10" do
        expect { Account.new('1234') }.to raise_error(InvalidAccountNumberError)
        expect { Account.new('12345678910') }.to raise_error(InvalidAccountNumberError)
      end
    end
  end

  describe "#transactions" do
    it "returns the transactions of the account" do
      expect(account.transactions).to eq([1000])
    end
  end

  describe "#balance" do
    it "returns the current balance of the account" do
      account.deposit!(1000)
      account.withdraw!(500)
      expect(account.balance).to eq(1500)
    end
  end

  describe "#acct_number" do
    it "returns the bank account with the last four digits and the others censored" do
      expect(account.acct_number).to eq('******7890')
    end
  end

  describe "deposit!" do
    context "with valid input" do
      it "should add money to the account and return the current balance" do
        expect(account.deposit!(1000)).to eq(2000)
      end
    end

    context "with invalid input" do
      it "throws negative deposit error when depositing negative value" do
        expect { account.deposit!(-1000) }.to raise_error(NegativeDepositError)
      end
    end
  end

  describe "#withdraw!" do
    context "withrawal less than or equal to account balance"
    it "should withdraw money from the account and return the current balance" do
      expect(account.withdraw!(500)).to eq(500)
    end

    context "withdrawal more than account balanace" do
      it "throws overdraft error when withdrawing more than the account balance" do
        expect { account.withdraw!(2000) }.to raise_error(OverdraftError)
      end
    end
  end
end