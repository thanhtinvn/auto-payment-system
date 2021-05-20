# auto-payment-system
Use for automatic payment

# start docker-compose
```
$ docker-compose -f docker-compose.yml up
```

## auto_backend
```
$ docker exec -it auto_frontend bash
$ bundle install
$ rails s -b 0.0.0.0
```
## auto_frontend
```
$ docker exec -it auto_frontend bash
$ npm install
$ npm run dev:start
```

## mysql
```
$ docker exec -it ss_db bash
$ mysql -uroot -p(password trong dockerfile db)
$ CREATE USER 'root'@'%' IDENTIFIED BY '<your_password>';
$ ALTER USER 'root'@'%' IDENTIFIED WITH mysql_native_password BY '<your_password>';
$ GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;
$ FLUSH PRIVILEGES;
```