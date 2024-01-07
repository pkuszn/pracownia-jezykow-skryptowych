return
  "GET /product": "product#index",
  "GET /product/:id": "product#show",
  "POST /product": "product#create",
  "PATCH /product/:id": "product#update",
  "DELETE /product/:id": "product#destroy",

  "GET /purchase": "purchase#index",
  "GET /purchase/:id": "purchase#show",
  "POST /purchase": "purchase#create",
  "PATCH /purchase/:id": "purchase#update",
  "DELETE /purchase/:id": "purchase#destroy

  "GET /user/:id": "user#show",
  "POST /user": "user#create",
  "PATCH /user/:id": "user#update",
  "DELETE /user/:id": "user#destroy

  "GET /category": "category#index",
  "GET /category/:id": "category#show",

  "GET /delivery-type": "delivery-type#index",
  "GET /delivery-type/:id": "delivery-type#show",

  "GET /payment-type": "payment-type#index",
  "GET /payment-type/:id": "payment-type#show",
