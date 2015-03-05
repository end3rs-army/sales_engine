require_relative './invoice_items_parser'
require_relative './invoice_items'

class InvoiceItemsRepository

  attr_accessor :invoice_items,
                :parent_engine,
                :data_storage

  def initialize(sales_engine = nil)
    @parent_engine = sales_engine
    @invoice_items = []
    @data_storage  = []
    @invoice_items_parser = InvoiceItemsParser.new
    @invoice_items_parser.read_invoice_items_data_from_csv_file
    create_invoice_items_objects
  end

  def create_invoice_items_objects
    @invoice_items_parser.invoice_items_data.each do |data|
      @invoice_items << InvoiceItems.new(self,data)
    end
  end

  def all
    invoice_items
  end

  def random
    invoice_items.sample
  end

  def find_by_id(match)
    invoice_items.find do |data|
      data.id == match
    end
  end

  def find_by_item_id(match)  ####
    invoice_items.find do |data|
      data.item_id == match
    end
  end

  def find_by_invoice_id(match)
    invoice_items.find do |data|
      data.invoice_id == match
    end
  end

  def find_by_quantity(match)
    invoice_items.find do |data|
      data.quantity == match 
    end
  end

  def find_by_unit_price(match)
    invoice_items.find do |data|
      data.unit_price == match
    end
  end

  def find_by_created_at(match)
    invoice_items.find do |data|
      data.created_at.downcase == match.downcase
    end
  end

  def find_by_updated_at(match)
    invoice_items.find do |data|
      data.updated_at.downcase == match.downcase
    end
  end

  def find_all_by_id(match)
    @data_storage = invoice_items.find_all do |data|
      data.id == match
    end
  end

  def find_all_by_item_id(match)
    @data_storage = invoice_items.find_all do |data|
      data.item_id == match
    end
  end

  def find_all_by_invoice_id(match)
    @data_storage = invoice_items.find_all do |data|
      data.invoice_id == match
    end
  end

  def find_all_by_quantity(match)
    @data_storage = invoice_items.find_all do |data|
      data.quantity == match
    end
  end

  def find_all_by_unit_price(match)  
    @data_storage = invoice_items.find_all do |data|
      data.unit_price == match
    end
  end

  def find_all_by_created_at(match)
    @data_storage = invoice_items.find_all do |data|
      data.created_at.downcase == match.downcase
    end
  end

  def find_all_by_updated_at(match)
    @data_storage = invoice_items.find_all do |data|
      data.updated_at.downcase == match.downcase
    end
  end

end

if __FILE__ == $0
  invoice_items_repository = InvoiceItemsRepository.new
  puts invoice_items_repository.find_by_id(21687)
  puts invoice_items_repository.find_all_by_unit_price(13635)
end