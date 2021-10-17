module Darwinable

  def self.calculate_company(company)
    Rails.cache.fetch("#{company.id}_reviews_user_ids") do
      self.calculate_graph_data(company.reviews.pluck(:user_id), company.id)
    end
  end

  def self.calculate_companies
    Rails.cache.fetch("all_companies_reviews_user_ids") do
      self.calculate_graph_data(User.all.pluck(:id), 'all')
    end
  end

  private

  def self.calculate_graph_data(users, company_id)
    Rails.cache.fetch("company_#{company_id}_user_data") do
      data = {
        gender: {},
        race: {},
        orientation: {},
        poc: {
          yes: {count: 0},
          no: {count: 0},
        }
      }
      user_count = users.count
      users.each do |user_id|
        user = User.find(user_id)
        # SET GENDERS
        if data[:gender][user.gender.to_sym].present?
          data[:gender][user.gender.to_sym][:count] += 1
        else
          data[:gender][user.gender.to_sym] = {count: 1}
        end

        # SET RACES
        if data[:race][user.race.to_sym].present?
          data[:race][user.race.to_sym][:count] += 1
        else
          data[:race][user.race.to_sym] = {count: 1}
        end

        # SET ORIENTATIONS
        if data[:orientation][user.orientation.to_sym].present?
          data[:orientation][user.orientation.to_sym][:count] += 1
        else
          data[:orientation][user.orientation.to_sym] = {count: 1}
        end

        # SET POCS
        if user.person_of_color
          data[:poc][:yes][:count] += 1
        else
          data[:poc][:no][:count] += 1
        end
      end
      data.each do |k,v|
        v.map do |vv|
          vv.last[:percentage] = ((vv.last[:count].to_f/user_count.to_f) * 100).round(2)
        end
        data[k] = v.sort_by { |kk, vv| -vv[:count] }.to_h
      end
    end
  end

end
