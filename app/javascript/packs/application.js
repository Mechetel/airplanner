// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

require("bootstrap")
import "../stylesheets/application";
import "@fortawesome/fontawesome-free/js/all";

document.addEventListener("turbolinks:load", () => {
    $(function () {
        $('[data-toggle="tooltip"]').tooltip()
        $('[data-toggle="popover"]').popover()
    })
})

var componentRequireContext = require.context("components", true);
var ReactRailsUJS = require("react_ujs");
ReactRailsUJS.useContext(componentRequireContext);

if (process.env.RAILS_ENV == 'development') {
  var rails_url = "http://localhost:3000";
  var rails_env = "development";
}
else if (process.env.RAILS_ENV == 'production'){
  var rails_url = window.location.origin;
  var rails_env = "production";
}

window.config = {
  api_host: rails_url + "/api/v1",
  env: rails_env
}

console.log(window.config);

window.React = require("react")
window.ReactDOM = require("react-dom")
window.moment = require("moment")
window.ProjectRoot = require("../components/ProjectRoot.js").default


Rails.start()
Turbolinks.start()
ActiveStorage.start()

