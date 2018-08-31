describe FlatPolicy do
  subject { described_class }
  let(:user) { create(:user) }
  let(:vendor) { create(:vendor) }
  let(:admin) { create(:admin) }

  permissions :new?, :create? do
    it "denies access if user is visitor" do
      expect(subject).not_to permit(user, Flat.new)
    end

    it "grants access if user is vendor" do
      expect(subject).to permit(vendor, Flat.new)
    end
  end

  permissions :update?, :edit? do
    it "denies access if user is not owner of flat" do
      expect(subject).not_to permit(vendor, Flat.new)
    end

    it "grants access if user is owner of flat" do
      expect(subject).to permit(vendor, Flat.new(user_id: vendor.id))
    end
  end

  permissions :destroy? do
    it "denies access if user is not owner of flat" do
      expect(subject).not_to permit(vendor, Flat.new)
    end

    it "grants access if user is owner of flat" do
      expect(subject).to permit(vendor, Flat.new(user_id: vendor.id))
    end
  end

  permissions :secret? do
    it "denies access if user is visitor" do
      expect(subject).not_to permit(user, Flat.new)
    end

    it "denies access if user is vendor" do
      expect(subject).not_to permit(vendor, Flat.new)
    end

    it "grants access if user is admin" do
      expect(subject).to permit(admin, Flat.new)
    end
  end
end
