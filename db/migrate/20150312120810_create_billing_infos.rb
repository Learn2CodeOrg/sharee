class CreateBillingInfos < ActiveRecord::Migration
  def change
    create_table :billing_infos do |t|
      t.belongs_to :user, index: true

      t.string :billing_contact
      t.string :address_line_1
      t.string :address_line_2
      t.string :zip_code
      t.string :city
      t.string :state

      t.string :company_identification_number
      t.string :tax_identification_number
      t.string :vat_identification_number

      t.timestamps null: false
    end
  end
end
