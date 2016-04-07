require 'csv'
# require 'models/category'
# require 'models/subcategory'
class ReadCSV

  def read_file
    File.read("/home/amyalenkov/dev/eshop/db/csv_db/CSV.csv").gsub(/\"/, "").gsub(/;/, ",")
  end

  def get_rows
    # CSV.parse(read_file, :headers => true) do |row|
    #   puts row[1]
    #   break
    # end
    CSV.parse(read_file, :headers => true)
    # CSV.foreach(read_file, { encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all}) do |row|
    #   data << row.to_hash
    #   p date
    # end

  end

end
categories = Array['Авто','Хозтовары','Праздники']
read_xml = ReadCSV.new
count = 0
read_xml.get_rows
read_xml.get_rows.each do |row|
  count = count + 1
  hash = row.to_hash
  p hash["﻿name"]
  p hash["Артикул"]
  break if count == 6
end