require 'rails_helper'

describe Posts::DateManipulationService do
  describe '.call' do
    it 'returns the day name with the `last` prefix if given post was created today' do
      date = Date.today
      time_with_zone = date.in_time_zone
      day_name = date.strftime("%A")

      expect(described_class.call(
        time_with_zone
      )).to eq("LAST #{day_name.upcase}")
    end

    it 'returns the day name with the `last` prefix if given post was created 3 days ago' do
      date = Date.today - 3.days
      time_with_zone = date.in_time_zone
      day_name = date.strftime("%A")

      expect(described_class.call(
        time_with_zone
      )).to eq("LAST #{day_name.upcase}")
    end

    it 'returns the day number with month and year if given post was created not in the past week' do
      time_with_zone = Date.parse('05.06.2018').in_time_zone

      expect(described_class.call(
        time_with_zone
      )).to eq("5 JUNE 2018")
    end
  end
end
