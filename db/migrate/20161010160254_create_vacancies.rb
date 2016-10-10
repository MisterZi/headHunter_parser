class CreateVacancies < ActiveRecord::Migration
  def change
    create_table :vacancies do |t|
      t.string :name
      t.text :short_description
      t.text :description
      t.integer :salary_from
      t.integer :salary_to
      t.string :currency
      t.string :link
      t.string :company_name
      t.string :company_link

      t.timestamps null: false
    end
  end
end
