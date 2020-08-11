NAME = urlshortner
DOMAIN= urls.com  #this should be the same as the one used in the host file and in docker compose
CONTAINERNAME= urlshortnerapibackend #as used in docker compose for urlshortner service container name variable
CONTAINERNAMECLIENT= urlshortnerclientapp #as used in docker compose for urlshortnerclient service container name variable
  build:
      
	  docker build --tag $(NAME):2.0 .
  
  up: 
      
	  docker-compose up

  .PHONY: install 
  install:
        #curl -d "install=Install URL SHORTNER" -X POST http://$(DOMAIN)/admin/install.php
		docker exec -it $(CONTAINERNAME) curl -d "install=Install URL SHORTNER" -X POST http://$(DOMAIN)/admin/install.php
       
  
  tests:
     
	 $(MAKE) -C tests
  
  .PHONY: tests
  tests: vendor
		#vendor/bin/phpunit 
		docker exec -it $(CONTAINERNAME) tests\vendor\bin\phpunit
		docker exec -it $(CONTAINERNAMECLIENT) yarn test

  vendor: composer.json composer.lock
		composer validate
		composer install
		composer normalize