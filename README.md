# Eleven System Challange

JSON Notes
for the json part, i have used a local file called "contacts.json" that is located into Assets folder. 
The structure used in this time was a vector whit ten contacts. 

For a faster test porpouse, the app remove and load this json every time that app open.

Concerning the parse of json and all reference to core data, i have created a class called "Contact" into the 
folder "Models" that implement Decodable and NSManagmentObject that is responsible to decode the json and also to 
managed persistent data.
