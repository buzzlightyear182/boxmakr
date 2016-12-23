class AddCompanyToBrand < ActiveRecord::Migration[5.0]
  def change
    add_column :brands, :company_id, :integer
  end
end
