require "rest-client"
require "json"
require "byebug"

response_rutas = RestClient.get("https://services1.arcgis.com/FZVaYraI7sEGQ6rF/arcgis/rest/services/movilidad_gdb/FeatureServer/10/query?where=1%3D1&outFields=*&outSR=4326&f=json")

result_rutas = JSON.parse(response_rutas) # Es un hash

info_rutas = result_rutas["features"]

important_info = []

info_rutas.each do |ruta|
  length_id = []
  data = ruta["attributes"]
  length_id << data["SHAPE__Length"]
  length_id << data["OBJECTID"]
  length_id << data["ID_RUTA"]
  important_info << length_id
end

sorted_array = important_info.sort[0..14]

puts sorted_array

puts "-------------"

sorted_array.each {|array| puts "id:#{array[1]}, length: #{array[0]}"}
