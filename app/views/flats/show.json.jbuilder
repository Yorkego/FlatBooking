json.array! @reserved do |reserv|
  date_format = '%Y-%m-%d'
  json.title "reserved"
  json.start reserv.strftime(date_format)
end
