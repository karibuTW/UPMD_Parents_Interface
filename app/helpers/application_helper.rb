module ApplicationHelper
  def select_for_grades
    Child.grades.keys.to_a.map do |grade|
      [ I18n.t("grades.#{grade}"), grade ]
    end
  end

  def second_parent(parent)
    parent.secondary_parent ||= SecondaryParent.new
  end
end
