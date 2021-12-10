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
FactoryBot.define do

  factory :note do
    noteable { create(:user) }
    message { Faker::Lorem.paragraph(sentence_count: Faker::Number.between(from: 1, to: 10)) }
    style { Note.styles.keys.sample }
    created_by { create(:user) }
  end

end
