# marvel-heroes

![marvelCharacters](https://user-images.githubusercontent.com/32545306/113625884-19763400-9627-11eb-99f8-55460faaa109.gif)

## Description

Simple application made using Marvel API, for explain the use of Clean Architecture in Swift.

## Architecture

![Architecture Diagram](https://user-images.githubusercontent.com/32545306/113739799-c0a9a880-96c5-11eb-8a4c-fe0e0b327aea.jpeg)

### Pros
- Nothing in an inner circle can know anything at all about something in an outer circle. In particular, the name of something declared in an outer circle must not be mentioned by the code in the an inner circle. this generates systems that are independent, for instance we can chage the current UI framework(UIKit) for a new one (SwiftUI) without affect the business logic.
- favor dependency injection and POP (Protocol oriented programming)
- It increases testability, the business rules can be tested without any external element, for Instance we can test easily the presenter due this one doesn't know anything about the view, the same happens for the other layers, a provider can be tested because it doesn't have a direct reference to the network layer or server.

## How To Run

To run the application you just need to have an account in [Marvel API](https://developer.marvel.com), get your public and private keys and add them to the object 
***MarvelEndpoint***
```
private let privateKey = ""
private let publicKey = ""
```

## Third-party library
The dependencies are managed with Swift package Manager
- Alamofire: it is an HTTP networking library written in Swift. [Alamofire](https://github.com/Alamofire/Alamofire)
- AlamofireImage: it is an image component library for Alamofire. [AlamofireImage](https://github.com/Alamofire/AlamofireImage)
