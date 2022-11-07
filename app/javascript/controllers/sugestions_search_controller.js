import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="sugestions-search"
export default class extends Controller {
  connect() {
  }
}


const searchContainer = document.querySelector('.search-input-box');
const inputSearch = document.querySelector('input');
const boxSuggestions = document.querySelector(
	'.container-suggestions'
);
const suggestions = document.querySelector('suggestions')

const searchLink = document.querySelector('a');

inputSearch.onkeyup = (e) => {
	let userData = e.target.value;
  let emptyArray = [];

	if (userData) {
		emptyArray = suggestions.filter(data => {
			return data.name
				.toLocaleLowerCase()
				.startsWith(userData.toLocaleLowerCase());
		});

    console.log(emptyArray)
	}
};
