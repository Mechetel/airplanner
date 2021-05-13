// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

require('dotenv').config()
require("bootstrap")
import "../stylesheets/application";

document.addEventListener("turbolinks:load", () => {
    $(function () {
        $('[data-toggle="tooltip"]').tooltip()
        $('[data-toggle="popover"]').popover()
    })
})

Rails.start()
Turbolinks.start()
ActiveStorage.start()

var componentRequireContext = require.context("components", true);
var ReactRailsUJS = require("react_ujs");
ReactRailsUJS.useContext(componentRequireContext);

let rails_url = "";
let rails_env = process.env.RAILS_ENV;

if (rails_env == "development")
  rails_url = "http://localhost:3000";
else
  rails_url = ""; //TODO


window.config = {
  api_host: rails_url + "/api/v1",
  env: rails_env
}

console.log(window.config);

window.React = require("react")
window.ReactDOM = require("react-dom")
window.moment = require("moment")
window.ProjectRoot = require("../components/ProjectRoot.js").default
