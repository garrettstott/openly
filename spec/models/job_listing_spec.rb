# == Schema Information
#
# Table name: job_listings
#
#  id          :bigint           not null, primary key
#  description :text(65535)
#  job_title   :string(255)
#  job_type    :integer
#  salary      :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  company_id  :bigint           not null
#
# Indexes
#
#  index_job_listings_on_company_id  (company_id)
#
# Foreign Keys
#
#  fk_rails_...  (company_id => companies.id)
#
require 'rails_helper'

RSpec.describe JobListing, type: :model do

  context 'Validates correctly' do
    let :job_listing do
      build(:job_listing)
    end
    it 'is valid from factory' do
      expect(job_listing.valid?).to eq(true)
    end
    it 'returns no errors' do
      job_listing.valid?
      expect(job_listing.errors.full_messages).to eq([])
    end
  end

end
