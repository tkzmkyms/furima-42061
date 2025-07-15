# Pin npm packages by running ./bin/importmap

pin "application"
pin "@rails/ujs", to: "https://ga.jspm.io/npm:@rails/ujs@7.1.0/lib/assets/compiled/rails-ujs.js"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "product_price", to: "custom/product_price.js"
pin "card", to: "custom/card.js"
