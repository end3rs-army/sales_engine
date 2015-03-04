require_relative './merchant_parser'
require_relative './merchant'

class MerchantRepository

	attr_accessor :merchants

	def initialize
		@merchants = []
		@merchant_parser = MerchantParser.new
		@merchant_parser.read_merchant_data_from_csv_file
	end

	def create_merchant_objects
		@merchant_parser.merchant_data.each {|data| @merchants << Merchant.new(self,data[:id],data[:name],data[:created_at],data[:updated_at])}
	end

end


if __FILE__ == $0
	merchant_repository = MerchantRepository.new
	merchant_repository.create_merchant_objects
	puts merchant_repository.merchants
end