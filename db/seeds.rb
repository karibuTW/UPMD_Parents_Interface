# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
if Rails.env.development?
  AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
  codes = [%w[COD-GI-1 Gilles],
           %w[COD-BR-1 Bruno],
           %w[COD-OL-1 Olivier],
           %w[COD-OL-2 Olivier],
           %w[COD-WA-1 Wandine],
           %w[COD-VI-1 Virginie],
           %w[COD-AL-1 Alain],
           ['COD-GI-V', 'Gilles - Virement'],
           %w[COD-CH-1 Christophe],
           %w[COD-CH-2 Christophe],
           %w[COD-CH-3 Christophe],
           %w[COD-CH-4 Christophe],
           %w[COD-CH-5 Christophe],
           %w[COD-CH-6 Christophe],
           %w[COD-CH-7 Christophe],
           %w[COD-CH-8 Christophe],
           %w[COD-CH-9 Christophe],
           %w[COD-CH10 Christophe]]

  codes.each { |c| DiscountCode.create! code: c[0], owner: c[1]  }
end
