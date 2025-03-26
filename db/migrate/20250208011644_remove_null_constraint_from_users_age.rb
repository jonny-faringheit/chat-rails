class RemoveNullConstraintFromUsersAge < ActiveRecord::Migration[8.0]
  def change
    change_column_null :users, :age, true
  end
end
