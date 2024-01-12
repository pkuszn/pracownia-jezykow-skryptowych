# Queries

## Product

POST
```
http://172.24.164.140:8085/products?name=tea&category=2&price=31&description=tea&available=1
``` 

PUT 
```
http://172.24.164.140:8085/product?id=26&name=PURPLETEA&category=2&price=24&description=xas&available=1
```

DELETE
```
http://172.24.164.140:8085/product/25
```

# Purchase

POST
```
http://172.24.164.140:8085/purchases?id_product=2&id_user=1&price=23&quantity=2&delivery_type=1&payment_type=1
```

PUT
```
http://172.24.164.140:8085/purchase?id=2&id_product=2&id_user=1&price=25&quantity=2&delivery_type=1&payment_type=1
```

DELETE

```
http://172.24.164.140:8085/purchase/3
```

# User

POST
```
http://172.24.164.140:8085/users?name=x&surname=y&password=z&address=ww
```

PUT

```
http://172.24.164.140:8085/user?id=2&name=x&surname=y&password=z&address=Warszawa
```