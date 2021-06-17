module ApplicationHelper


  def select_for_grades
    Child.grades.keys.to_a.map do |grade|
      [I18n.t("grades.#{grade}"), grade]
    end
  end

  def second_parent(parent)
    # parent.secondary_parent ||= SecondaryParent.new
    parent.secondary_parent.nil? ? parent.build_secondary_parent : parent.secondary_parent
  end

  def locale_map(keys)
    locales = {
      en: "English",
      fr: "French",
      vi: "Vietnamese"
    }.freeze
    keys.map { |l| [locales[l.to_sym], l] }
  end
end
