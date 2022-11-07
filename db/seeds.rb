# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require "rest-client"
require "json"
require "byebug"

# obtener la información de las paradas
# la información esta guardada así para cada parada, ejemplo:
# "features": [
#   {
#       "attributes": {
#           "ID_PARADERO": 50233,
#           "ID_PARADA": "90332008",
#           "ID_RUTA": 90332,
#           "NRO_PARADA": 8,
#           "NOMBRE": null,
#           "DIRECCION": "CL 62B x CR 143A  , Medellin",
#           "ORIENTACION": "S",
#           "MOBILIARIO": null,
#           "TIPO_PARADA": "Reglamentaria",
#           "RECORRIDO": "Origen-Destino",
#           "CODIGO_RUTA": "C23i",
#           "NOMBRE_RUTA": "Las Playas-estación San Javier",
#           "SISTEMA_RUTA": "8A",
#           "TIPO_RUTA": "Integrada",
#           "EMPRESA": "Tax Maya",
#           "ID_GFLOTA": 112112,
#           "FROM_DATE": 1533081600000,
#           "OBJECTID": 1,
#           "X_MAGNAMED": 826678.1049,
#           "Y_MAGNAMED": 1186125.6658,
#           "LONGITUD": -75.64349491,
#           "LATITUD": 6.277197
#       },
#       "geometry": {
#           "x": -75.643494908638232,
#           "y": 6.277197004473515
#       }
#   },
response_paradas = RestClient.get("https://services1.arcgis.com/FZVaYraI7sEGQ6rF/arcgis/rest/services/movilidad_gdb/FeatureServer/8/query?where=1%3D1&outFields=*&outSR=4326&f=json")

result_paradas = JSON.parse(response_paradas) # Es un hash

# Obtener la informacion de las rutas
# la información esta guardad así para cada ruta, ejemplo:
# "features": [
#   {
#       "attributes": {
#           "OBJECTID": 1,
#           "ID_RUTA": "90093",
#           "CODIGO": "255A",
#           "RECORRIDO": "Origen-Destino",
#           "FROM_DATE": 1583798400000,
#           "SISTEMA": "2A",
#           "TIPO": "Directa Centro",
#           "EMPRESA": "Rápido San Cristóbal",
#           "ID_GFLOTA": 110075,
#           "SHAPE__Length": 17963.429822595
#       },
#       "geometry": {
#                     "paths": [
#                                 [
#                                     [
#                                       -75.6196790996806, <- longitud
#                                         6.28014000004954 <- latitud
#                                     ],
#                                     [
#                                         ...,
#                                     ],
#                                     [....
#                                     ]
#                                 ],
#                                 [
#                                     [
#                                       -75.6196790996806,
#                                         6.28014000004954
#                                     ],
#                                     [
#                                       -75.6198135993222,
#                                         6.27955379920185
#                                     ]
#                                 ],
#
#                              ]
#                   }
#    },

response_rutas = RestClient.get("https://services1.arcgis.com/FZVaYraI7sEGQ6rF/arcgis/rest/services/movilidad_gdb/FeatureServer/10/query?where=1%3D1&outFields=*&outSR=4326&f=json")

result_rutas = JSON.parse(response_rutas) # Es un hash

# Se filtra y guarda la info que necesitamos
# De paradas, necesitamos ingresar al hash > features que es un array de hashes
info_paradas = result_paradas["features"]

# Se filtra y guarda la info que necesitamos
# De rutas, necesitamos ingresar al hash > features que es un array de hashes
info_rutas = result_rutas["features"]


Location.create(name: "Medellín", latitude: 6.217, longitude: -75.567, address: "Medellín")
# Se crea un array de precios para darle a cada ruta un precio aleatoriamente, simulando el precio de la ruta
prices = [2200, 2550, 1400, 2700, 2350, 2900, 3600, 3200, 8550]

# Array de Imagenes, para asignar aleatoriamente a la ruta
images = ["https://res.cloudinary.com/dqij49pio/image/upload/v1667016293/Viene%20el%20bus/pexels-will-mu-3802736_ybfw2r.jpg",
"https://res.cloudinary.com/dqij49pio/image/upload/v1667016292/Viene%20el%20bus/muchos-2_sqfdlj.jpg",
"https://res.cloudinary.com/dqij49pio/image/upload/v1667016291/Viene%20el%20bus/school_little_hsuf43.jpg",
"https://res.cloudinary.com/dqij49pio/image/upload/v1667016291/Viene%20el%20bus/chiva-little_fwlpjg.jpg",
"https://res.cloudinary.com/dqij49pio/image/upload/v1667016291/Viene%20el%20bus/school_little2_wzomr7.jpg",
"https://res.cloudinary.com/dqij49pio/image/upload/v1667016291/Viene%20el%20bus/metroplus-little_olelkq.jpg",
"https://res.cloudinary.com/dqij49pio/image/upload/v1667016291/Viene%20el%20bus/demtro-2_vmklu1.jpg",
"https://res.cloudinary.com/dqij49pio/image/upload/v1667016291/Viene%20el%20bus/principal-little_zesq2n.jpg",
"https://res.cloudinary.com/dqij49pio/image/upload/v1667016290/Viene%20el%20bus/muchos-little_pz9kju.jpg",
"https://res.cloudinary.com/dqij49pio/image/upload/v1667068563/Viene%20el%20bus/me-bus-3_f8xamj.jpg",
"https://res.cloudinary.com/dqij49pio/image/upload/v1667068563/Viene%20el%20bus/med-bus-6_mixjla.jpg",
"https://res.cloudinary.com/dqij49pio/image/upload/v1667068563/Viene%20el%20bus/mde-bus-1_ob8hww.jpg",
"https://res.cloudinary.com/dqij49pio/image/upload/v1667068563/Viene%20el%20bus/med-bus-5_mvots4.jpg",
"https://res.cloudinary.com/dqij49pio/image/upload/v1667068563/Viene%20el%20bus/med-bus-4_mvaf5b.jpg"]

# # se crean las horas en las que funciona la ruta en strings para mostrar
start_hour_str = "5:00"
end_hour_str = "22:00"

# # representa el paso del tiempo
# pas_time_30_min = 1800
# array de rutas mas cortas
shortes_routes = [372, 281, 221, 95, 415, 282, 280, 417, 223, 283, 257, 226, 43, 445, 446]
# 758.587338344525
# 372
# 90114
# 1388.98501603524
# 281
# 90314
# 1471.68457415101
# 221
# 90307
# 1487.49739828335
# 95
# 90114
# 1542.5423678363
# 415
# 90313
# 1631.49292822007
# 282
# 90307
# 1633.69259890145
# 280
# 90313
# 1638.10601432169
# 417
# 90314
# 1704.53618471817
# 223
# 90308
# 1820.41236624874
# 283
# 90308
# 1834.41675043825
# 257
# 90065
# 1854.87334770439
# 226
# 90316
# 1874.42230269796
# 43
# 90065
# 1969.35318185787
# 445
# 90309
# 1980.74096334048
# 446
# 90310


info_rutas.each do |route|
  data = route["attributes"] # hash
  if shortes_routes.include?(data["OBJECTID"])
    ruta = Route.create(name: data["EMPRESA"], id_route: data["ID_RUTA"], code: data["CODIGO"], price: prices.sample, image: images.sample, start_hour: start_hour_str, end_hour: end_hour_str)
  end
  # puts "ruta #{ruta.id} was created"
  # ref_point = route["geometry"]["paths"]
  # ref_point.each do |array|
  #   array.each do |point|
  #     Spot.create(longitude: point[0], latitude: point[1], route_id: ruta.id)
  #     # puts "the spot #{spot.id} was created"
  #   end
  # end


  # -----
  # start_h = DateTime.parse(start_hour.sample).strftime('%I:%M %p')
  # end_h = DateTime.parse(end_hour.sample).strftime('%I:%M %p')
  # end_time = end_h
  # time = start_h
  # pas_time = time_pass.sample
  # ------

  # variables que representan las horas de inicio y final en tipo time
  # start_h = start_hour_str.to_time # time
  # end_h = end_hour_str.to_time # time

  # # variable que se usara para crear las intancias de la clase hour
  # hour = start_h # time

  # # variables que sirven de contadores
  # end_hour = 34 # integers
  # count_hour = 0 # integers

  # until count_hour == end_hour

  #   Hour.create(hour: hour, route: ruta)
  #   hour += pas_time_30_min
  #   count_hour += 1

  # end
end

puts "routes were created"

info_paradas.each do |stop|
  id_route = stop["attributes"]["ID_RUTA"]
  if Route.exists?(:id_route => id_route)
    stop_st = StopStation.create(station_name: stop["attributes"]["NOMBRE_RUTA"], longitude: stop["geometry"]["x"], latitude: stop["geometry"]["y"], route_id: Route.find_by(id_route: id_route).id, route_code: stop["attributes"]["CODIGO_RUTA"], city: "Medellin", department: "Antioquia", country: "Colombia", address: stop["attributes"]["DIRECCION"])
    puts "stop #{stop_st.id} was created" # with latitude #{stop_st.latitude} and longitude #{stop_st.longitude}"
  end
end
