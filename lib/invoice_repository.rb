require_relative './invoice'

class InvoiceRepository

  attr_accessor :invoices,
                :parent_engine

  def initialize(data, sales_engine)
    @parent_engine = sales_engine
    @invoices      = data.map { |element| (Invoice.new(self, element)) }
  end

  def inspect
    "#<#{self.class} #{merchants.size} rows>"
  end

  def create(data)
    invoice_id = invoices.last.id + 1
    create_invoice_items(data, invoice_id)
    create_invoice(data, invoice_id)
  end

  def create_invoice(data, invoice_id)
    new_invoice = add_invoice(data, invoice_id)
    invoices << new_invoice
    new_invoice
  end

  def create_invoice_items(data, invoice_id)
    invoice_item_repository.create(data, invoice_id)
  end

  def all
    invoices
  end

  def random
    invoices.sample
  end

  def find_by_id(id)
    invoices.find { |data| data.id == id }
  end

  def find_by_customer_id(id)
    invoices.find { |data| data.customer_id == id }
  end

  def find_by_merchant_id(id)
    invoices.find { |data| data.merchant_id == id }
  end

  def find_by_status(status)
    invoices.find { |data| data.status.downcase == status.downcase }
  end

  def find_by_created_at(date)
    invoices.find { |data| data.created_at.downcase == date.downcase }
  end

  def find_by_updated_at(date)
    invoices.find { |data| data.updated_at.downcase == date.downcase }
  end

  def find_all_by_id(id)
    invoices.find_all { |data| data.id == id }
  end

  def find_all_by_customer_id(id)
    invoices.find_all { |data| data.customer_id == id }
  end

  def find_all_by_merchant_id(id)
    invoices.find_all { |data| data.merchant_id == id }
  end

  def find_all_by_status(status)
    invoices.find_all { |data| data.status.downcase == status.downcase }
  end

  def find_all_by_created_at(date)
    invoices.find_all { |data| data.created_at.downcase == date.downcase }
  end

  def find_all_by_updated_at(date)
    invoices.find_all { |data| data.updated_at.downcase == date.downcase }
  end

  private

  def invoice_item_repository
    parent_engine.invoice_item_repository
  end

  def add_invoice(data, invoice_id)
    Invoice.new(self,
                id: invoice_id,
                customer_id: data[:customer].id,
                merchant_id: data[:merchant].id,
                status: "shipped",
                created_at: Time.now.strftime("%d/%m/%Y %H:%M"),
                updated_at: Time.now.strftime("%d/%m/%Y %H:%M")
                )
  end

end
