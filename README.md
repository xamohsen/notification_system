### Swvl Notification APIs

#### To run the app
- ``git clone https://github.com/xamohsen/notification_system.git``
- ```cd notification_system```
- ``` docker-compose up```

#### To run specs
- ```docker exec -it notification_system_app_1 bash```
- ```rspec```

#### API Docs
-  https://documenter.getpostman.com/view/54956/SVYjUNaJ?version=latest

#### To test if the message sent to each user based on his language!
- ```docker exec -it notification_system_app_1 bash```
- ```rails db:seed```
- Use Postman to send notification to two users one with ID in range {1->10} and the other with ID
 from {11->20} and in the server log you will see that the first one will get the message in English 
 and the other one will get it in Arabic.