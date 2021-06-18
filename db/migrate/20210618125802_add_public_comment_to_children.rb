class AddPublicCommentToChildren < ActiveRecord::Migration[6.1]
  def change
    add_column :children, :public_comment, :text
  end
end
