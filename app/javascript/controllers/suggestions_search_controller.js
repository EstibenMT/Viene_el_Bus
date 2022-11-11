import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="sugestions-search"
export default class extends Controller {

  static targets = [ "input", "results", "content" ]
  static values = {
    suggestions: Array,
  }

  connect() {
    this.#queryInput();
    console.log(this.contentTarget)
    console.log(this.resultsTarget)
    console.log(this.inputTarget)

  }

  #queryInput() {
    this.inputTarget.onkeyup = (e) => {
      let userData = e.target.value;
      console.log(userData)
      let emptyArray = [];

      if (userData) {
        emptyArray = this.suggestionsValue.filter(data => {
          return data
            .toLocaleLowerCase()
            .includes(userData.toLocaleLowerCase());
        });

        emptyArray = emptyArray.map(data => {
          return (data = `<li>${data}</li>`);
        });

        this.contentTarget.classList.add("active");
        this.showSuggestions(emptyArray);
        console.log(emptyArray)

        let allList = this.resultsTarget.querySelectorAll('li');
        console.log(allList)
        allList.forEach(li => {
          // li.setAttribute('onclick', console.log(this));
          li.addEventListener("click", e => this.select(e.target))
        });

      } else {
        this.contentTarget.classList.remove('active');
      }
    };
  }

  select(element) {
    this.inputTarget.value = element.textContent;
    this.contentTarget.classList.remove('active');
  }

  showSuggestions(list) {
    console.log(list)
    let listData;
    let userValue;

    if (!list.length) {
      userValue = this.inputTarget.value;
      listData = `<li>${userValue}</li>`;
    } else {
      listData = list.join(' ');
    }
    this.resultsTarget.innerHTML = listData;
  };

}
