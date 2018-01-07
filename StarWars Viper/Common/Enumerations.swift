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

//associative type enum for plural
enum StructType{
    case People
    case Planets
    case Starships
    case Vehicles
    case Films
    case Species
    
    case Person(name:String)
    case Planet(name:String)
    case Starship(name:String)
    case Vehicle(name:String)
    case Film(title:String)
    case Specie(name:String)
}

//enum RetSingleType:Printable{
enum RetSingleType {
    case Person(Person)
    case Planet(Planet)
    case Starship(Starship)
    case Vehicle(Vehicle)
    case Film(Film)
    case Specie(Specie)
 
    //getting your url string for images
    var Description: String{
        switch self {
        case .Person(let x):
            return "https://raw.githubusercontent.com/sbassett1/swImages/master/\(x.name.replacingOccurrences(of: "/", with: "")).png"
        case .Starship(let x):
            return "https://raw.githubusercontent.com/Zephzz/sada/master/temp/Starships/\(x.name.replacingOccurrences(of: "/", with: "")).png"
        case .Vehicle(let x):
            return "https://raw.githubusercontent.com/cjamie/starwarsapi_starships/master/Vehicles/\(x.name.replacingOccurrences(of: "/", with: "")).png"
        case .Film(let x):
            return "https://raw.githubusercontent.com/cjamie/starwarsapi_starships/master/FilmPosters/\(x.title.replacingOccurrences(of: "/", with: "")).png"
        case .Specie(let x):
            return "https://raw.githubusercontent.com/Zephzz/StarwarsSpeciesImages/master/Species/\(x.name.replacingOccurrences(of: "/", with: "")).png"
        default: //for the planets
            return ""
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
        var returnData = [RetSingleType]()
        switch self{
        case .Films1(let x):
            returnData.append(contentsOf: x.results.map{RetSingleType.Film($0)})
        case .People1(let x):
            returnData.append(contentsOf: x.results.map{RetSingleType.Person($0)})
        case .Planets1(let x):
            returnData.append(contentsOf: x.results.map{RetSingleType.Planet($0)})
        case .Starships1(let x):
            returnData.append(contentsOf: x.results.map{RetSingleType.Starship($0)})
        case .Species1(let x):
            returnData.append(contentsOf: x.results.map{RetSingleType.Specie($0)})
        case .Vehicles1(let x):
            returnData.append(contentsOf: x.results.map{RetSingleType.Vehicle($0)})
        }
        return returnData
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
    
    //this simplifies the downloadOwnjects2 function
    static func getMyself(data:Data)->RetStructType?{
        if let tempDecode = try? JSONDecoder().decode(People.self, from: data){
            return RetStructType.People1(tempDecode)
        }else if let tempDecode = try? JSONDecoder().decode(Planets.self, from: data){
            return RetStructType.Planets1(tempDecode)
        }else if let tempDecode = try? JSONDecoder().decode(Starships.self, from: data){
            return RetStructType.Starships1(tempDecode)
        }else if let tempDecode = try? JSONDecoder().decode(Vehicles.self, from: data){
            return RetStructType.Vehicles1(tempDecode)
        }else if let tempDecode = try? JSONDecoder().decode(Films.self, from: data){
            return RetStructType.Films1(tempDecode)
        }else if let tempDecode = try? JSONDecoder().decode(Species.self, from: data){
            return RetStructType.Species1(tempDecode)
        }else{
            return nil
        }
    }
}
