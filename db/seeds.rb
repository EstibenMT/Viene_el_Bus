# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require "rest-client"
require "json"
# require "byebug"

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


# Se filtra y guarda la info que necesitamos (ID_RUTA, )
# De paradas, necesitamos ingresar al hash > features que es un array de hashes
info_paradas = result_paradas["features"]


# Se filtra y guarda la info que necesitamos
# De rutas, necesitamos ingresar al hash > features que es un array de hashes
info_rutas = result_rutas["features"]


Location.create(name: "Medellín", latitude: 6.217, longitude: -75.567)

info_rutas.each do |route|
  data = route["attributes"] # hash
  ruta = Route.create(name: data["EMPRESA"], id_route: data["ID_RUTA"], code: data["CODIGO"])
  puts "ruta #{ruta.id} was created"
  ref_point = route["geometry"]["paths"]
  ref_point.each do |array|
    array.each do |point|
      spot = Spot.create(longitude: point[0], latitude: point[1], route_id: ruta.id)
      puts "the spot #{spot.id} was created"
    end
  end
end

info_paradas.each do |stop|
  id_route = stop["attributes"]["ID_RUTA"]
  stop_st = StopStation.create(station_name: stop["attributes"]["NOMBRE_RUTA"], longitude: stop["geometry"]["x"], latitude: stop["geometry"]["y"], route_id: Route.find_by(id_route: id_route).id, route_code: stop["attributes"]["CODIGO_RUTA"], city: "Medellin", department: "Antioquia", country: "Colombia", address: stop["attributes"]["DIRECCION"])
  puts "stop #{stop_st.id} was created" # with latitude #{stop_st.latitude} and longitude #{stop_st.longitude}"
end
