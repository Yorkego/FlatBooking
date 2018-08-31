describe BookingSerializer do
  let(:vendor) { create(:vendor) }
  let(:flat) { vendor.flats.create(attributes_for(:flat))}
  let(:book) { vendor.bookings.create(attributes_for(:booking, start_date: Date.today, end_date: Date.today + 2.days, flat_id: flat.id)) }

  it "deserializes the hash" do
    expect(JSON.parse(described_class.new(book).to_json)["title"]).to eq('reserved')
    expect(JSON.parse(described_class.new(book).to_json)["start"]).to eq((Date.today).to_s)
    expect(JSON.parse(described_class.new(book).to_json)["end"]).to eq((Date.today + 3.days).to_s)
  end
end
