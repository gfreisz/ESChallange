# Eleven System Challange

This application is a simple contact viewer with the posibliity to add, edit and remove a contact. 

For this demo I'm using a local json with ten contacts that are loaded into the app and saved using CoreData. Every time that app opens, I check that the database has at least one contact, otherwise it loads the json again. 

Concerning project structure, the app has two views (one for contact list and another for the contact detail) and a custom view cell to show the contact list with more information (name and phone). The image showed into every cell it's randomly loaded from project assets. When the user clicks into a cell, the app navigates to a new view with the contact detail.

One comment for UI is when when the user wants to edit or add a new contact into the app, it validates if the "first name" field it's empty. In this case, it shows an alert stating: "Invalid Operation" and showing the field is necessary. 

The only another alert that's shown to the user it's when they try to remove a contact,  displaying an alert with and Yes/No validation for security reasons.

The technology used in these demos are:
- Xcode 10.1
- Swift 4.2
- CoreData
- Decodable for Json parse

JSON Notes
For the json part, I have used a local file called "contacts.json" which is located into" Assets" folder. 
The structure used this time was a vector with ten contacts. 

Concerning the parse of json and all reference to core data, I have created a class called "Contact" into folder "Models" that implements Decodable and NSManagmentObject which are responsible to decode the json and also to manage persistent data. This way it's possible to manage an easy relationship for the json object and a entity into the CoreData.
