require_relative "../../app/helpers/date_helper"
require "date"

describe "date helper" do
  include DateHelper

  let(:today) { Date.new(2000, 12, 25) }

  context "when the date is greater than today's date, but within the same year" do
    before do
      @date = today.next_day
    end

    it "returns 'month/day:'" do
      formatted_date = date(@date, today: today)

      expect(formatted_date).to eq("12/26:")
    end
  end

  context "when the date is eq to today's date" do
    before do
      @date = today
    end

    it "returns nothing" do
      formatted_date = date(@date, today: today)

      expect(formatted_date).to be_empty
    end
  end

  context "when the date is less than today's date, but in the same year" do
    before do
      @date = today.prev_day
    end

    it "returns 'month/day:'" do
      formatted_date = date(@date, today: today)

      expect(formatted_date).to eq("12/24:")
    end
  end

  context "when the date is in a different year from now" do
    before do
      @date = today.prev_year
    end

    it "returns 'month/day/year:'" do
      formatted_date = date(@date, today: today)

      expect(formatted_date).to eq("12/25/1999:")
    end
  end
end
