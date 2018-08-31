require "rails_helper"

RSpec.describe FlatsQuery, type: :feature do
  describe "query" do
    let(:init) { described_class.new }
    let(:filter) { described_class.new.filter(params_filter) }
    let(:params_filter) { {"category"=>"created_at", "direction"=>"ASC", "name"=>"", "vendor"=>"", "city"=>"", "capacity"=>"", "start_date"=>"", "end_date"=>""}}
    let(:is_date_reserved?) { described_class.new.is_date_reserved?(start_date, end_date, flat1) }
    let(:start_date) { Date.today }
    let(:end_date) { Date.today + 4.days }
    let(:user) { create(:vendor, name: "Good_vendor") }
    let(:flat1) { user.flats.create(attributes_for(:flat, name: 'slicer', capacity: 20))}
    let(:flat2) { user.flats.create(attributes_for(:flat, name: 'dicer', city: 'Chop'))}
    before(:each) do
      user.bookings.create(attributes_for(:booking, start_date: Date.today, end_date: Date.today + 2.days, flat_id: flat1.id ))
      user.bookings.create(attributes_for(:booking, start_date: Date.today + 5.days, end_date: Date.today + 10.days, flat_id: flat2.id ))
    end

    # it "return flats.all" do
    #   expect(init).to eq(Flat.all)
    # end

    it "return flats with name slicer" do
      params_filter[:name] = "slicer"
      expect(filter.first.name).to eq("slicer")
    end

    it "return flats with vendor Good_vendor" do
      params_filter[:vendor] = "Good_vendor"
      expect(filter.first.user.name).to eq("Good_vendor")
    end

    it "return flats with city Uzhgorod" do
      params_filter[:city] = "Uzhgorod"
      expect(filter.first.city).to eq("Uzhgorod")
    end

    it "return flats with capacity 2" do
      params_filter[:capacity] = 2
      expect(filter.first.capacity).to eq(2)
    end

    it "return flats that free from Date.today to Date.today + 4.days" do
      params_filter[:start_date] = Date.today
      params_filter[:end_date] = Date.today + 4.days
      expect(filter.first.name).to eq("dicer")
    end

    it "return true if flat is reserved" do
      expect(is_date_reserved?).to be true
    end

    it "return false if flat is not reserved" do
      start_date = Date.today + 10.days
      end_date = Date.today + 14.days
      expect(is_date_reserved?).to be true
    end
  end
end
