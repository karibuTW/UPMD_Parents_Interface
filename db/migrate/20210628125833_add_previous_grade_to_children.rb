class AddPreviousGradeToChildren < ActiveRecord::Migration[6.1]
  def change
    add_column :children, :previous_grade, :integer, default: -1
  end
end
