class ChangeIdentityFields < ActiveRecord::Migration
  def change
    change_table :identities do |t|
      t.remove :name
      t.rename :email, :uid
    end
  end
end
