# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  admin                  :boolean          default(FALSE), not null
#  approved               :boolean          default(TRUE), not null
#  confirmation_sent_at   :datetime
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :string(255)
#  denied                 :boolean          default(FALSE), not null
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  failed_attempts        :integer          default(0), not null
#  first_name             :string(255)      not null
#  gender                 :string(255)      not null
#  last_name              :string(255)      not null
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :string(255)
#  locked_at              :datetime
#  orientation            :string(255)      not null
#  person_of_color        :boolean          not null
#  race                   :string(255)      not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string(255)
#  role                   :integer
#  sign_in_count          :integer          default(0), not null
#  unconfirmed_email      :string(255)
#  unlock_token           :string(255)
#  username               :string(255)      not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
FactoryBot.define do

  factory :user do
    first_name { Faker::Name.first_name }
    last_name  { Faker::Name.last_name }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    gender { Faker::Demographic.sex }
    orientation { Faker::Gender.type }
    person_of_color { [true, false].sample }
    race { Faker::Demographic.race }
    confirmed_at { DateTime.now }
  end

end
