class AddPublicCommentToParents < ActiveRecord::Migration[6.1]
  def change
    add_column :parents, :public_comment, :text
  end
end
