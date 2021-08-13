# frozen_string_literal: true

module ApplicationHelper
  def select_for_grades
    Child.grades.keys.to_a.map do |grade|
      [I18n.t("grades.#{grade}"), grade]
    end
  end

  def select_for_previous_grades
    Child.previous_grades.keys.to_a.map do |grade|
      [I18n.t("grades.#{grade}"), grade]
    end
  end

  def second_parent(parent)
    # parent.secondary_parent ||= SecondaryParent.new
    parent.secondary_parent.nil? ? parent.build_secondary_parent : parent.secondary_parent
  end

  def locale_map(keys)
    locales = {
      vi: 'Vietnamese',
      fr: 'French',
      en: 'English'
    }.freeze
    keys.map { |l| [locales[l.to_sym], l] }
  end

  def nations_map
    I18n.t(".")[:nations].keys.map { |n| [ I18n.t("nations.#{n}"), n ] }
  end
end
