# == Schema Information
#
# Table name: chiefs
#
#  id            :bigint           not null, primary key
#  approved      :boolean          default(FALSE), not null
#  current       :boolean          default(TRUE), not null
#  denied        :boolean          default(FALSE), not null
#  first_name    :string(255)      not null
#  last_name     :string(255)      not null
#  title         :integer          not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  company_id    :bigint           not null
#  created_by_id :integer          not null
#
# Indexes
#
#  index_chiefs_on_company_id     (company_id)
#  index_chiefs_on_created_by_id  (created_by_id)
#
# Foreign Keys
#
#  fk_rails_...  (company_id => companies.id)
#
require 'rails_helper'

RSpec.describe Chief, type: :model do

  context 'Validates correctly' do
    let :chief do
      build(:chief)
    end
    it 'is valid from factory' do
      expect(chief.valid?).to eq(true)
    end
    it 'returns no errors' do
      chief.valid?
      expect(chief.errors.full_messages).to eq([])
    end
  end

end
