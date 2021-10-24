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
    const id = 'reviews';
    const yOffset = -110;
    const element = document.getElementById(id);
    const y = element.getBoundingClientRect().top + window.pageYOffset + yOffset;
    window.scrollTo({top: y, behavior: 'smooth'});
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
