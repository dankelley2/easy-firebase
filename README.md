![Social Preview](./Assets/Social%20Preview%20(640).png)

<h2 align="center">Firebase for iOS and macOS made easy.</h2>

<p align="center">🍏 Third-party authentication done in a single line of code</p>
<p align="center">✉️ Send and receive Firestore documents in a snap</p>
<p align="center">😀 Predefined user protocols with built-in features</p>
<p align="center">🔥 Firebase solutions in one native Swift package</p>

## What is EasyFirebase?

EasyFirebase is a Swift wrapper for all things Firebase. Save hours from implementing the Firebase code in your projects repeatedly. EasyFirebase makes document storage and retrieval easier by providing **intuitive protocols** for Firestore. EasyFirebase makes **authentication easier** with the EasyUser protocol and simple one-line sign-in with Google and Apple. EasyFirebase is cross-platform and works with both iOS and macOS.

## Completed Features

- Firestore Support
  - Built-in Document protocol
  - Document storage
  - Document removal
  - Document retrieval
  - Update listeners
  - Built-in cacheing
  - Easy linking
- Authentication Support
  - EasyUser protocol
  - Email auth
  - Sign In with Google
  - Sign In with Apple

All the above features are **cross-platform** and are supported on both iOS and macOS.

⭐️ This means EasyFirebase is the quickest way to implement Sign In with Google on macOS! ⭐️

## Get Started

Add **EasyFirebase** to your project using Swift Package Manager:

```
https://github.com/Flowductive/easy-firebase
```

Import **EasyFirebase**:

```swift
import EasyFirebase
```

Configure at app launch:

```swift
// You don't need to call FirebaseApp.configure() when this is called!
EasyFirebase.configure()
```

## Firestore Feature Showcase

### Built-in Document protocol

Save time writing model classes with the built-in `Document` protocol:

```swift
class Car: Document {
  
  // These properties are inherited from Document
  var id: String = UUID().uuidString
  var dateCreated: Date = Date()
  
  // Define your own custom properties
  var make: String
  var model: String
  var year: Int
  
  init(make: String, model: String, year: Int) {
    // ...
  }
}
```

### Document Storage

Store documents anywhere in your code:

```swift
var myCar = Car(make: "Toyota", model: "Corolla", year: 2017)

// Store the car instance in the 'car' collection in Firestore
myCar.set()

// Static method that does the same as above
EasyFirestore.Storage.set(myCar)
```

### Document Retrieval

Grab documents easily without needing to specify a collection name:

```swift
EasyFirestore.Retrieval.get(id: myCarID, ofType: Car.self) { car in
  guard let car = car else { return }
  self.myOtherCar = car
}
```

### Update Listeners

Grab documents and update the local instance when changed in Firestore:

```swift
EasyFirestore.Listening.listen(to: otherCarID, ofType: Car.self, key: "myCarListenerKey") { car in
  // Updates when changed in Firestore
  guard let car = car else { return }
  self.myOtherCar = car
}
```

### Built-In Cacheing

EasyFirestore will automatically cache fetched documents locally and will use the cached doucments when retrieving to reduce your Firestore read count.

```swift
// EasyFirebase will automatically cache fetched objects for you, here is a manual example
EasyFirestore.Cacheing.register(myCar)

// Get locally cached objects instantly. Retrieving objects using EasyFirestore.Retrieval will grab cached objects if they exist
var cachedCar = EasyFirestore.Cacheing.grab(myCarID, fromType: Car.self)
```

### Easy Linking

Link child documents to an array of IDs in a parent document:

```swift
var car1 = Car(make: "Toyota", model: "Corolla", year: 2017)
var car2 = Car(make: "Honda", model: "Civic", year: 2019)

var dealership = Dealership(name: "Los Angeles Dealership")

// Set and assign the Toyota Corolla to the Los Angeles Dealership
car1.setAssign(to: \.cars, in: dealership)

// Set and assign the Honda Civid to the Los Angeles Dealership
car2.set()
car2.assign(to: \.cars, in: dealership)
```

## Authentication Feature Showcase

### Easy User Protocol

Save time writing user classes with the built-in `EasyUser` procotol:

```swift
class MyUser: EasyUser {
  
  // EasyUser comes pre-built with these automatically updated properties
  var lastSignon: Date
  var displayName: String
  var username: String
  var email: String
  var appVersion: String
  var deviceToken: String?
  var notifications: [MessagingNotification]
  var disabledMessageCategories: [MessageCategory]
  var progress: Int
  var id: String
  var dateCreated: Date
  
  // Define your own custom properties
  var cars: [DocumentID]

  // ...
}
```

### Email Auth

Authenticate with an email and password easily:

```swift
EasyAuth.createAccount(email: "easy.firebase@example.com", password: "76dp2[&y4;JLyu:F") { error in
  if let error = error {
    print(error.localizedDescription)
  } else {
    // Account created!
  }
}

EasyAuth.signIn(email: "easy.firebase@example.com", password: "76dp2[&y4;JLyu:F") { error in
  // ...
}
```

### Sign In with Google

Authenticate with Google:

```swift
// iOS
EasyAuth.signInWithGoogle(clientID: "xxxxxxxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx") { error in
  // ...
}

// macOS
EasyAuth.signInWithGoogle(clientID: "xxxxxxxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
                          secret: "GOCSPX-xxxxxxxxxxxxxxxxxxx-xxxxxxxx") { error in
  // ...
}
```

### Sign In with Apple

Authenticate with Apple:

```swift
// iOS + macOS
EasyAuth.signInWithApple()
```
