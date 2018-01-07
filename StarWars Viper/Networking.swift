//
//  Networking.swift
//  StarWars Viper
//
//  Created by Admin on 1/6/18.
//  Copyright © 2018 Jamie Chu. All rights reserved.
//

import Foundation
import Alamofire


protocol NetworkProtocol{
    func downloadType(completion: @escaping(RetStructType?, Error?)->())
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

//protocol hasArr{
//    var myArr: [RetSingleType]{
//        get
//        set
//    }
//
//    var myNext:String?{
//        get set
//    }
//}

enum RetSingleType{
    case Person(Person)
    case Planet(Planet)
    case Starship(Starship)
    case Vehicle(Vehicle)
    case Film(Film)
    case Specie(Specie)
}

enum RetStructType{
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


class Networking {
    //NOTE: this does not deserialize the incoming data.-- returns the "plural" structs
    static func downloadObjects(byPage:String, completion: @escaping(RetStructType?, Error?)->() ){
        guard let tempURL = URL(string: byPage) else {return}
        Alamofire.request(tempURL).responseJSON {
            (dataResponse) in
            guard dataResponse.error == nil else {
                completion(nil, dataResponse.error)
                print(dataResponse.error!.localizedDescription)
                return
            }
            guard let tempResp = dataResponse.response else {
                completion(nil, NetworkError.noResponse)
                return
            }
            guard tempResp.statusCode == 200 else{
                completion(nil, NetworkError.responseError(tempResp.statusCode))
                return
            }
            guard let data = dataResponse.data else{
                completion(nil, NetworkError.noData)
                return
            }
            
            if let tempDecode = try? JSONDecoder().decode(People.self, from: data){
                completion(RetStructType.People1(tempDecode),nil)
            }else if let tempDecode = try? JSONDecoder().decode(Planets.self, from: data){
                completion(RetStructType.Planets1(tempDecode),nil)
            }else if let tempDecode = try? JSONDecoder().decode(Starships.self, from: data){
                completion(RetStructType.Starships1(tempDecode),nil)
            }else if let tempDecode = try? JSONDecoder().decode(Vehicles.self, from: data){
                completion(RetStructType.Vehicles1(tempDecode),nil)
            }else if let tempDecode = try? JSONDecoder().decode(Films.self, from: data){
                completion(RetStructType.Films1(tempDecode),nil)
            }else if let tempDecode = try? JSONDecoder().decode(Species.self, from: data){
                completion(RetStructType.Species1(tempDecode),nil)
            }else{
                completion(nil, NetworkError.couldNotParseData)
            }
        }
    }
    
    //this version will take in an enum parameter
    static func downloadObjects2(byPage:String, completion: @escaping(RetStructType?, Error?)->() ){
        guard let tempURL = URL(string: byPage) else {return}
        Alamofire.request(tempURL).responseJSON {
            (dataResponse) in
            guard dataResponse.error == nil else {
                completion(nil, dataResponse.error)
                print(dataResponse.error!.localizedDescription)
                return
            }
            guard let tempResp = dataResponse.response else {
                completion(nil, NetworkError.noResponse)
                return
            }
            guard tempResp.statusCode == 200 else{
                completion(nil, NetworkError.responseError(tempResp.statusCode))
                return
            }
            guard let data = dataResponse.data else{
                completion(nil, NetworkError.noData)
                return
            }
            guard let tempRet = RetStructType.getMyself(data: data) else{
                completion(nil, NetworkError.couldNotParseData)
                return
            }
            completion(tempRet, nil)
        }
    }
    
    static func downloadObjects3(byPage:String, type:StructType, completion: @escaping(RetStructType?, Error?)->() ){
        guard let tempURL = URL(string: byPage) else {return}
        Alamofire.request(tempURL).responseJSON {
            (dataResponse) in
            guard dataResponse.error == nil else {
                completion(nil, dataResponse.error)
                print(dataResponse.error!.localizedDescription)
                return
            }
            guard let tempResp = dataResponse.response else {
                completion(nil, NetworkError.noResponse)
                return
            }
            guard tempResp.statusCode == 200 else{
                completion(nil, NetworkError.responseError(tempResp.statusCode))
                return
            }
            guard let data = dataResponse.data else{
                completion(nil, NetworkError.noData)
                return
            }
            
            let decoder = JSONDecoder()
            switch type{
            case .Films:
                if let tempDecode = try? decoder.decode(Films.self, from: data){
                    completion(RetStructType.Films1(tempDecode),nil)}
            case .People:
                if let tempDecode = try? decoder.decode(People.self, from: data){
                    completion(RetStructType.People1(tempDecode),nil)}
            case .Planets:
                if let tempDecode = try? decoder.decode(Planets.self, from: data){
                    completion(RetStructType.Planets1(tempDecode),nil)}
            case .Species:
                if let tempDecode = try? decoder.decode(Species.self, from: data){
                    completion(RetStructType.Species1(tempDecode),nil)}
            case .Starships:
                if let tempDecode = try? decoder.decode(Starships.self, from: data){
                    completion(RetStructType.Starships1(tempDecode),nil)}
            case .Vehicles:
                if let tempDecode = try? decoder.decode(Vehicles.self, from: data){
                    completion(RetStructType.Vehicles1(tempDecode),nil)}
            default:
                break
            }
            completion(nil, NetworkError.couldNotParseData)
        }
    }
    
    
    
    static func downloadImage(type:StructType, completion: @escaping(UIImage?, Error?)->() ){
        var tempURL = String()
        switch type{
        case .Film(title: let x):
            tempURL = "https://raw.githubusercontent.com/cjamie/starwarsapi_starships/master/FilmPosters/\(x.replacingOccurrences(of: "/", with: "")).png"
        case .Person(name: let x):
            tempURL = "https://raw.githubusercontent.com/sbassett1/swImages/master/\(x.replacingOccurrences(of: "/", with: "")).png"
        case .Specie(name: let x):
            tempURL = "https://raw.githubusercontent.com/Zephzz/StarwarsSpeciesImages/master/Species/\(x.replacingOccurrences(of: "/", with: "")).png"
        case .Starship(name: let x):
            tempURL = "https://raw.githubusercontent.com/Zephzz/sada/master/temp/Starships/\(x.replacingOccurrences(of: "/", with: "")).png"
        case .Vehicle(name: let x):
            tempURL = "https://raw.githubusercontent.com/cjamie/starwarsapi_starships/master/Vehicles/\(x.replacingOccurrences(of: "/", with: "")).png"
        default:
            return
        }
        print(tempURL)
        
        guard let uurl = URL(string: tempURL) else {return}
        let imageSession = URLSession.shared
        imageSession.invalidateAndCancel()
        imageSession.dataTask(with: uurl) {
            (data, response, error) in
            guard error == nil else{
                completion(nil, error)
                return
            }
            guard let responseTemp = response as? HTTPURLResponse else{return}
            guard responseTemp.statusCode == 200 else{
                completion(nil, NetworkError.responseError(responseTemp.statusCode))
                return
            }
            guard let data = data else{
                completion(nil, NetworkError.noData)
                return
            }
            guard let image = UIImage(data:data) else{
                completion(nil, NetworkError.invalidImage)// or no image
                return
            }
            completion(image, nil)
            }.resume()
    }
}




