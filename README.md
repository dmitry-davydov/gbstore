GB Store


### Api Mock Server
Base URL: https://aqueous-sea-42119.herokuapp.com/

### Endpoints

#### User
##### Login
```
curl --request POST \
  --url https://aqueous-sea-42119.herokuapp.com/user/auth \
  --header 'Content-Type: application/json' \
  --data '{
	"username": "username",
	"password": "password",
	"cookies": "123"
}'
```

##### Logout
```
curl --request POST \
  --url https://aqueous-sea-42119.herokuapp.com/user/logout \
  --header 'Content-Type: application/json' \
  --data '{
	"id_user": 1
}'
```

##### Create 
```
curl --request POST \
  --url https://aqueous-sea-42119.herokuapp.com/user/create \
  --header 'Content-Type: application/json' \
  --data '{
	"gender": "m",
	"password": "mypassword",
	"credit_card": "9872389-2424-234224-234",
	"bio": "This is good! I think I will switch to another language",
	"username": "Somebody",
	"email": "some@some.ru",
	"id_user": 123
}'
```

##### Update
```
curl --request POST \
  --url https://aqueous-sea-42119.herokuapp.com/user/update \
  --header 'Content-Type: application/json' \
  --data '{
"id_user" : 123,
"username" : "Somebody",
"password" : "mypassword",
"email" : "some@some.ru",
"gender": "m",
"credit_card" : "9872389-2424-234224-234", 
"bio" : "This is good! I think I will switch to another language"
}'
```

#### Product
##### All Products
```
curl --request POST \
  --url https://aqueous-sea-42119.herokuapp.com/product/all \
  --header 'Content-Type: application/json' \
  --data '{
 "page_number": 1, 
 "id_category": 1
}'
```
##### One Product
```
curl --request POST \
  --url https://aqueous-sea-42119.herokuapp.com/product/one \
  --header 'Content-Type: application/json' \
  --data '{
  "id_product" : 123
}'
```