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
class User < ApplicationRecord

  extend Queueable

  # Include default devise modules. Others available are:
  # :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable,
         :lockable, :timeoutable

  validates_presence_of :first_name, :last_name, :gender, :orientation, :race,
                        :email
  validates_inclusion_of :denied, :approved, :person_of_color, :admin, in: [true, false]

  before_create :set_username

  has_many :reviews
  has_many :employment_companies
  has_many :companies, through: :employment_companies

  enum role: {uber: 0, super: 1, mod: 2}

  def admin?
    admin
  end

  def mod?
    role == 'mod' || role == 'uber'
  end

  def timeout_in
    if self.uber? || self.mod?
      1.year
    else
      30.minutes
    end
  end

  def uber?
    role == 'uber'
  end

  def set_username
    require 'securerandom'
    self.username = SecureRandom.hex
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def current_company
    self.employment_companies.where(current: true).last&.company
  end

  def list_employment
    self.employment_companies.order(current: :asc, start_date: :desc)
  end

  def add_employment(company, start_date, current, job_title, salary = nil)
    self.employment_companies.create(
      company: company,
      start_date: start_date,
      current: current,
      job_title: job_title,
      salary: salary
    )
  end

end
