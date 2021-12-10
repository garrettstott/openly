# == Schema Information
#
# Table name: companies
#
#  id             :bigint           not null, primary key
#  about          :text(65535)
#  approved       :boolean          default(FALSE), not null
#  denied         :boolean          default(FALSE), not null
#  employee_count :integer
#  founded        :integer
#  industry       :string(255)
#  name           :string(255)      not null
#  website        :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  created_by_id  :integer          not null
#
# Indexes
#
#  index_companies_on_created_by_id  (created_by_id)
#
require 'rails_helper'

RSpec.describe Company, type: :model do

  context 'Validates correctly' do
    let :company do
      build(:company)
    end
    it 'is valid from factory' do
      expect(company.valid?).to eq(true)
    end
    it 'returns no errors' do
      company.valid?
      expect(company.errors.full_messages).to eq([])
    end
  end

end
