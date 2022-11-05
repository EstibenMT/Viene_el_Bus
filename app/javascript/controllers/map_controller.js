import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="map"
export default class extends Controller {

  static values = {
    apiKey: String,
    markers: Array
  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue;
    this.map = new mapboxgl.Map({
      container: this.element,
      style: 'mapbox://styles/mapbox/streets-v11',
    });

    this.#addMarkersToMap();
    this.#fitMarkersToMap();
    this.#lineToMap();
  }

  #addMarkersToMap() {
    this.markersValue.forEach(marker => {
      const popup = new mapboxgl.Popup().setHTML(marker.info_window);
      new mapboxgl.Marker()
        .setLngLat([marker.longitude, marker.latitude])
        .setPopup(popup)
        .addTo(this.map)
    });

  }

  #fitMarkersToMap(){
    const bounds = new mapboxgl.LngLatBounds();
    this.markersValue.forEach(marker => bounds.extend([marker.longitude, marker.latitude]));
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 });
  }

  #lineToMap(){

    this.map.on('load', () => {
      this.map.addSource('lines', {
        'type': 'geojson',
        'data': {
          'type': 'FeatureCollection',
          'features': [
            {
              'type': 'Feature',
              'properties': {
                'color': '#F7455D' // red
              },
              'geometry': {
                'type': 'LineString',
                'coordinates': [
                  [-122.4833858013153, 37.829607404976734],
                  [-122.4830961227417, 37.82932776098012],
                  [-122.4830746650696, 37.82932776098012],
                  [-122.48218417167662, 37.82889558180985],
                  [-122.48218417167662, 37.82890193740421],
                  [-122.48221099376678, 37.82868372835086],
                  [-122.4822163581848, 37.82868372835086],
                  [-122.48205006122589, 37.82801003030873]
                ]
              }
            },
            {
              'type': 'Feature',
              'properties': {
                'color': '#33C9EB' // blue
              },
              'geometry': {
                'type': 'LineString',
                'coordinates': [
                  [-122.48395174741744, 37.829412501697064],
                  [-122.48423874378203, 37.829357420242125],
                  [-122.48422533273697, 37.829361657278575],
                  [-122.48459815979002, 37.8293425906126],
                  [-122.48458743095398, 37.8293447091313],
                  [-122.4847564101219, 37.82932776098012],
                  [-122.48474299907684, 37.829331998018276],
                  [-122.4849334359169, 37.829298101706186],
                  [-122.48492807149889, 37.82930022022615],
                  [-122.48509705066681, 37.82920488676767],
                  [-122.48509168624878, 37.82920912381288],
                  [-122.48520433902739, 37.82905870855876],
                  [-122.48519897460936, 37.82905870855876],
                  [-122.4854403734207, 37.828594749716714],
                  [-122.48543500900269, 37.82860534241688],
                  [-122.48571664094925, 37.82808206121068],
                  [-122.48570591211319, 37.82809689109353],
                  [-122.4858346581459, 37.82797189627337],
                  [-122.48582661151886, 37.82797825194729],
                  [-122.4859634041786, 37.82788503534145],
                  [-122.48595803976059, 37.82788927246246],
                  [-122.48605459928514, 37.82786596829394]
                ]
              }
            }
          ]
        }
      });

      this.map.addLayer({
        'id': 'lines',
        'type': 'line',
        'source': 'lines',
        'paint': {
          'line-width': 3,
          // Use a get expression (https://docs.mapbox.com/mapbox-gl-js/style-spec/#expressions-get)
          // to set the line-color to a feature property value.
          'line-color': ['get', 'color']
        }
      });
    });
  }
}
