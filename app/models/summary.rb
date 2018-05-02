class Summary
  attr_accessor :sum_of_balance, :sum_of_credit, :sum_of_debit

  def self.build_from_piggy_banks(piggy_banks)
    Summary.new.tap do |summary|
      summary.sum_of_balance = piggy_banks.inject(0){ |sum, pb| sum + pb.balance }
      summary.sum_of_credit = piggy_banks.inject(0){ |sum, pb| sum + pb.total_credit }
      summary.sum_of_debit = piggy_banks.inject(0){ |sum, pb| sum + pb.total_debit }
    end
  end
end
