import 'bootstrap/dist/js/bootstrap.bundle'
import { Layout } from 'admin-lte/build/js/AdminLTE'
import './sidebar'

document.addEventListener("turbo:render", function () {
  Layout._jQueryInterface.call($('body'))
})
