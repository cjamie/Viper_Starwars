//
//  Errors.swift
//  StarWars Viper
//
//  Created by Admin on 1/6/18.
//  Copyright © 2018 Jamie Chu. All rights reserved.
//

import Foundation

enum NetworkError:Error{
    case noResponse
    case responseError(Int)
    case noData
    case couldNotParseData
    case invalidImage
}

extension NetworkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noResponse:
            return "Error: no response"
        case .responseError(let errCode):
            return "Error: non-200 status code! It is \(errCode)"
        case .noData:
            return "Error: you have no data"
        case .couldNotParseData:
            return "Error: unable to parse your json!"
        case .invalidImage:
            return "Error: your data is not an image"

        }
    }
}

enum RetSingleType {
    case Person(Person)
    case Planet(Planet)
    case Starship(Starship)
    case Vehicle(Vehicle)
    case Film(Film)
    case Specie(Specie)
 
    //getting your url string for images for networking calls. 
    var typeURL: String{
        switch self {
        case .Person(let x):
            return "https://raw.githubusercontent.com/sbassett1/swImages/master/\(x.name.replacingOccurrences(of: "/", with: "")).png".replacingOccurrences(of: " ", with: "").folding(options: .diacriticInsensitive, locale: .current)
        case .Starship(let x):
            return "https://raw.githubusercontent.com/Zephzz/sada/master/temp/Starships/\(x.name.replacingOccurrences(of: "/", with: "")).png".replacingOccurrences(of: " ", with: "").folding(options: .diacriticInsensitive, locale: .current)
        case .Vehicle(let x):
            return "https://raw.githubusercontent.com/cjamie/starwarsapi_starships/master/Vehicles/\(x.name.replacingOccurrences(of: "/", with: "")).png".replacingOccurrences(of: " ", with: "").folding(options: .diacriticInsensitive, locale: .current)
        case .Film(let x):
            return "https://raw.githubusercontent.com/cjamie/starwarsapi_starships/master/FilmPosters/\(x.title.replacingOccurrences(of: "/", with: "")).png".replacingOccurrences(of: " ", with: "").folding(options: .diacriticInsensitive, locale: .current)
        case .Specie(let x):
            return "https://raw.githubusercontent.com/Zephzz/StarwarsSpeciesImages/master/Species/\(x.name.replacingOccurrences(of: "/", with: "")).png".replacingOccurrences(of: " ", with: "").folding(options: .diacriticInsensitive, locale: .current)
        default: //for the planets
            return ""
        }
    }
    
    
    //there should be a way to simplify this
    var name: String{
        switch self {
        case .Person(let x):
            return x.name
        case .Starship(let x):
            return x.name
        case .Vehicle(let x):
            return x.name
        case .Film(let x):
            return x.title
        case .Specie(let x):
            return x.name
        case .Planet(let x):
            return x.name
        }
    }
}


protocol retStructProtocol{
    var myArr: [RetSingleType] {get}
    var myNext: String? {get}
}

//TODO: put these functions in an extension (maybe also local variables
enum RetStructType: retStructProtocol{
    case People1(People)
    case Planets1(Planets)
    case Starships1(Starships)
    case Vehicles1(Vehicles)
    case Films1(Films)
    case Species1(Species)
    
    var myArr:[RetSingleType]{
        switch self{
        case .Films1(let x):
            return x.results.map{RetSingleType.Film($0)}
//            returnData.append(contentsOf: x.results.map{RetSingleType.Film($0)})
        case .People1(let x):
            return x.results.map{RetSingleType.Person($0)}
        case .Planets1(let x):
            return x.results.map{RetSingleType.Planet($0)}
        case .Starships1(let x):
            return x.results.map{RetSingleType.Starship($0)}
        case .Species1(let x):
            return x.results.map{RetSingleType.Specie($0)}
        case .Vehicles1(let x):
            return x.results.map{RetSingleType.Vehicle($0)}
        }
    }
    
    var myNext: String?{
        switch self{
        case .Films1(let x):
            return x.next
        case .People1(let x):
            return x.next
        case .Planets1(let x):
            return x.next
        case .Starships1(let x):
            return x.next
        case .Species1(let x):
            return x.next
        case .Vehicles1(let x):
            return x.next
        }
    }
}
