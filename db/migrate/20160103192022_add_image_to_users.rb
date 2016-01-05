class AddImageToUsers < ActiveRecord::Migration
    def change
        add_column :users, :image, :string, default: "http://riskid.nl/assets/testimonials/user-3995d1ed5f9b6ea6ef9c7bc9ead47415.jpg"
    end
end
