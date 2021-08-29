import { Controller } from "stimulus"

export default class extends Controller {

  sortData(event) {
    console.log(event.target.attributes.data.nodeValue)
    this.loadSortData(event.target.attributes.data.nodeValue);
  }

  // Added to data-action in initializers/pagy.rb
  pageClick(event) {
    event.preventDefault()
    this.loadSortData(event.target.href)
    document.getElementById("reviews").scrollIntoView({behavior: "smooth", block: "start", inline: "nearest"});
  }

  loadSortData(uri) {
    if (!uri) {
      console.log('sort#loadSortData passed no uri')
      return
    }
    fetch(uri, {
      headers: {
        Accept: "text/vnd.turbo-stream",
      },
    })
      .then(response => response.text())
      .then(html => Turbo.renderStreamMessage(html))
      .then(_ => history.replaceState(history.state, "", location.pathname))
  }
}
