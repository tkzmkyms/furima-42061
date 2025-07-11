# Pin npm packages by running ./bin/importmap

pin "application"
pin "@rails/ujs", to: "@rails--ujs.js" # @7.1.3
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "product_price", to: "custom/product_price.js"