import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="lines-map"
export default class extends Controller {
  static values = {
    lines: Array,
  };
  connect() {
    mapboxgl.accessToken = this.apiKeyValue;
    // A GeoJSON object with a LineString route from the White House to Capitol Hill
    const geojson = {
      type: "FeatureCollection",
      features: [
        {
          type: "Feature",
          geometry: {
            type: "LineString",
            properties: {},
            coordinates: [
            ],
          },
        },
      ],
    };

    this.linesValue.forEach((element) => {
       geojson.features[0].geometry.coordinates.push(element);
    });


    const map = new mapboxgl.Map({
      container: "map",
      // Choose from Mapbox's core styles, or make your own style with Mapbox Studio
      style: "mapbox://styles/mapbox/light-v10",
      center: [this.linesValue[0][0], this.linesValue[0][1]],
      zoom: 12,
    });


     map.on("load", () => {
      map.addSource("LineString", {
        type: "geojson",
        data: geojson,
      });

      map.addLayer({
        id: "LineString",
        type: "line",
        source: "LineString",
        layout: {
          "line-join": "round",
          "line-cap": "round",
        },
        paint: {
          "line-color": "#BF93E4",
          "line-width": 5,
        },
      });



      const coordinates = geojson.features[0].geometry.coordinates;

      const bounds = new mapboxgl.LngLatBounds(coordinates[0], coordinates.last);

      // Extend the 'LngLatBounds' to include every coordinate in the bounds result.
      for (const coord of coordinates) {
        bounds.extend(coord);
      }

      map.fitBounds(bounds, {
        padding: 20,
        // });
      });
    });

  }
}
