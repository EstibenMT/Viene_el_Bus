import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="map-home"
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

    this.#fitMarkersToMap();
  }

  #fitMarkersToMap(){
    const bounds = new mapboxgl.LngLatBounds();
    this.markersValue.forEach(marker => bounds.extend([marker.longitude, marker.latitude]));
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 12, duration: 0 });
  }
}
