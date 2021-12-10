# == Schema Information
#
# Table name: notes
#
#  id            :bigint           not null, primary key
#  message       :text(65535)
#  noteable_type :string(255)
#  style         :integer          not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  created_by_id :integer          not null
#  noteable_id   :integer
#
# Indexes
#
#  index_notes_on_created_by_id  (created_by_id)
#  index_notes_on_noteable_id    (noteable_id)
#  index_notes_on_noteable_type  (noteable_type)
#
require 'rails_helper'

RSpec.describe Note, type: :model do

  context 'Validates correctly' do
    let :note do
      build(:note)
    end
    it 'is valid from factory' do
      expect(note.valid?).to eq(true)
    end
    it 'returns no errors' do
      note.valid?
      expect(note.errors.full_messages).to eq([])
    end
  end

end
