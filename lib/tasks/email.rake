desc "Send email to admin"

task email_sender: :environment do
  puts "hello"
  @vendor = User.today.where(vendor: true)
  @visitor = User.today.where(vendor: false)
  @flat = Flat.today
  @booking = Booking.today
  AdminMailer.report(@vendor, @visitor, @flat, @booking).deliver
end
