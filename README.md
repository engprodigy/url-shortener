Url shortner with php backend, react.js front end with dockerized containers and docker images. Also incoporating unit testing powered by phpUnit and Jest for the backend and frontend respectively.

How to use:

docker-compose.yml contains database credentials and other credentials which are picked up by the
application container 

-For the url shortner application using a custom domain is more appropriate for running the application.
Follow the below instructions to map a custom domain to an ip on your local computer:
Instruction to update file host name

Linux
Use the following instructions if you’re running Linux:

Open a Terminal window.
Enter the following command to open the hosts file in a text editor:

sudo nano /etc/hosts
Enter your domain user password.
add this to the host file: "127.0.1.2     urls.com  # source server" 

#urls.com is the specified YOURL_SITE in the docker-compose.yml, you can use ur own name but it should be
the same as the one specified in the docker-compose.yml#

This will allow to run the back end by typing urls.com and give the shortened url as example - urls.com/d84ndn -
Press Control-X.
When you are asked if you want to save your changes, enter y

-Disable CORS in browser by using a plugin. I've not fully resolved the CORS issue in the server backend. I'm 
still working on it.

-Docker should be installed

-running the targets on the makefile should work. If it dosen't (I couldn't test on my local
windows 10 operating system) use the following commands:
STEPS A : use the images of the backend services and front end client on docker hub at engprodigy 

1.Run the command: docker-compose up
2.run this command: curl -d "install=Install URL SHORTNER" -X POST http://urls.com/admin/install.php #this 
fires up the backend and create the backend database
3: navigate to localhost:3000 to load the front end

STEPS B : use the locally build docker images

1 clone or download the repo https://github.com/engprodigy/url-shortener
2.run the command: docker build --tag urlshortnerclient:2.0 . #this build the local image as urlshortner:2.0 
for the backend service
3.navigate into myurlshortnerclient folder and run the command:
docker build --tag urlshortnerclient:2.0 .  #this build the local image as urlshortnerclient:2.0 
for the front end client
4. Navigate back to the main folder, open the docker-compose.yml file and change the image name for the
urlshortner service from engprodigy/urlshortner:2.0 to urlshortner:2.0 and also the urlshortnerclient service
image name from engprodigy/urlshortnerclient:2.0 to urlshortnerclient:2.0 and save
5. run the command: docker-compose up
5.run this command: curl -d "install=Install URL SHORTNER" -X POST http://urls.com/admin/install.php #this 
fires up the backend and create the backend database
6: navigate to localhost:3000 to load the front end

STEPS C: Run the test
1. to run the test for the back end use this command: docker exec -it urlshortnerapibackend tests\vendor\bin\phpunit
2. to run the test for the react front end client:
docker exec -it urlshortnerclientapp yarn test

