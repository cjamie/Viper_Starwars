//
//  Networking.swift
//  StarWars Viper
//
//  Created by Admin on 1/6/18.
//  Copyright © 2018 Jamie Chu. All rights reserved.
//

import Foundation
import Alamofire

enum NetworkError:Error{
    case noResponse
    case responseError(Int)
    case noData
    case couldNotParseData
}


class Networking {
    //iterates through your people and returns array of Person (sub)
    static func getPeople(byPage page: String, completion: @escaping (People?, Error?)->()){
        
        guard let peopleURL = URL(string: page) else {return}
        
        Alamofire.request(peopleURL).responseJSON {
            (dataResponse) in
            print("in Alamofire getPeople completionHandler")
            guard let data = dataResponse.data else{ return }
            
            do{
                let temp = try JSONDecoder().decode(People.self, from: data)
                //                print(temp.results)
                completion(temp, nil)
            }catch let error{
                print("Serialziation Error")
                print(error)
            }
        }
    }
    
    //this will return a Person and an image of the person (or an error)
    //    static func getPerson( completion: @escaping(Person?, Error? )->Void) {
    //        guard let peopleURL = URL(string: "https://swapi.co/api/people/1/") else {return}
    //        Alamofire.request(peopleURL).responseJSON {
    //            (dataResponse) in
    //            print("in Alamofire completionHandler")
    //            guard let data = dataResponse.data else{ return }
    //            do{
    //                let temp = try JSONDecoder().decode(Person.self, from: data)
    ////                let toReturn = NetworkReturn.person(temp)
    //                completion(temp, nil)
    //            }catch let error{
    //                print("Serialziation Error")
    //                print(error)
    //            }
    //        }
    //    }
    
    //takes a personName and returns Image via completionhandler
    static func downloadPersonImage(byName url:String,completion:@escaping(UIImage?,Error?)->()){
        let myUrl = "https://raw.githubusercontent.com/sbassett1/swImages/master/\(url.replacingOccurrences(of: "/", with: "")).png"
        print(myUrl)
        
        guard let uurl = URL(string:myUrl) else {return}
        
        Alamofire.request(uurl).response { (dataResponse) in
            guard dataResponse.error == nil else {
                completion(nil, dataResponse.error)
                print(dataResponse.error!.localizedDescription)
                return
            }
            guard let data = dataResponse.data else {
                completion(nil, NetworkError.noData)
                return
            }
            guard let image = UIImage(data:data) else {return}
            print("returning img")
            completion(image, nil)
        }
    }
    
    static func downloadVehicleImage(byName url:String,completion:@escaping(UIImage?,Error?)->()){
        let myUrl = "https://raw.githubusercontent.com/cjamie/starwarsapi_starships/master/Vehicles/\(url.replacingOccurrences(of: "/", with: "")).png"
        print(myUrl)
        
        guard let uurl = URL(string:myUrl) else {return}
        
        Alamofire.request(uurl).response { (dataResponse) in
            guard dataResponse.error == nil else {
                completion(nil, dataResponse.error)
                print(dataResponse.error!.localizedDescription)
                return
            }
            guard let data = dataResponse.data else {
                completion(nil, NetworkError.noData)
                return
            }
            guard let image = UIImage(data:data) else {return}
            print("returning img")
            completion(image, nil)
        }
    }
    
    
    
    static func downloadStarshipImage(byName url:String,completion:@escaping(UIImage?,Error?)->()){
        let myUrl = "https://raw.githubusercontent.com/Zephzz/sada/master/temp/Starships/\(url.replacingOccurrences(of: "/", with: "")).png"
        print(myUrl)
        guard let uurl = URL(string:myUrl) else {return}
        
        Alamofire.request(uurl).response { (dataResponse) in
            guard dataResponse.error == nil else {
                completion(nil, dataResponse.error)
                print(dataResponse.error!.localizedDescription)
                return
            }
            guard let data = dataResponse.data else {
                completion(nil, NetworkError.noData)
                return
            }
            guard let image = UIImage(data:data) else {return}
            print("returning img")
            completion(image, nil)
        }
    }
    
    
    static func downloadSpecieImage(byName url:String,completion:@escaping(UIImage?,Error?)->()){
        let myUrl =
        "https://raw.githubusercontent.com/Zephzz/StarwarsSpeciesImages/master/Species/\(url.replacingOccurrences(of: "/", with: "")).png"
        print(myUrl)
        guard let uurl = URL(string:myUrl) else {return}
        
        Alamofire.request(uurl).response { (dataResponse) in
            guard dataResponse.error == nil else {
                completion(nil, dataResponse.error)
                print(dataResponse.error!.localizedDescription)
                return
            }
            guard let data = dataResponse.data else {
                completion(nil, NetworkError.noData)
                return
            }
            guard let image = UIImage(data:data) else {return}
            print("returning img")
            completion(image, nil)
        }
    }
    
    //TODO: update for change link
    static func downloadFilmImage(byName filmTitle:String,completion:@escaping(UIImage?,Error?)->()){
        let myUrl =
        "https://raw.githubusercontent.com/cjamie/starwarsapi_starships/master/FilmPosters/\(filmTitle.replacingOccurrences(of: "/", with: "")).png"
        print(myUrl)
        guard let uurl = URL(string:myUrl) else {return}
        
        Alamofire.request(uurl).response { (dataResponse) in
            guard dataResponse.error == nil else {
                completion(nil, dataResponse.error)
                print(dataResponse.error!.localizedDescription)
                return
            }
            guard let data = dataResponse.data else {
                completion(nil, NetworkError.noData)
                return
            }
            guard let image = UIImage(data:data) else {return}
            completion(image, nil)
        }
    }
    
    
    static func getPlanets(byPage: String, completion: @escaping (Planets?, Error?)->()) {
        guard let tempURL = URL(string: byPage) else {return}
        Alamofire.request(tempURL).responseJSON {
            (dataResponse) in
            guard let data = dataResponse.data else{ return }
            do{
                let temp = try JSONDecoder().decode(Planets.self, from: data)
                completion(temp,nil)
            }catch let error{
                print("Serialziation Error")
                completion(nil, error)
            }
        }
    }
    
    //returns 10 at a time
    static func getStarships(byPage:String, completion: @escaping (Starships?, Error?)->()) {
        guard let tempURL = URL(string: byPage) else {return}
        Alamofire.request(tempURL).responseJSON {
            (dataResponse) in
            print("in completionHandler")
            guard let data = dataResponse.data else{ return }
            do{
                let temp = try JSONDecoder().decode(Starships.self, from: data)
                completion(temp,nil)
            }catch let error{
                print("Serialziation Error")
                completion(nil,error)
            }
        }
    }
    static func getVehicle(byPage:String, completion: @escaping (Vehicles?, Error?)->()) {
        guard let tempURL = URL(string: byPage) else {return}
        Alamofire.request(tempURL).responseJSON {
            (dataResponse) in
            print("in alamofire completionHandler")
            guard let data = dataResponse.data else{ return }
            do{
                let temp = try JSONDecoder().decode(Vehicles.self, from: data)
                completion(temp,nil)
            }catch let error{
                //                print("Serialziation Error")
                completion(nil,error)
            }
        }
    }
    
    
    static func getFilm(byPage:String, completion: @escaping (Films?, Error?)->()) {
        guard let tempURL = URL(string: byPage) else {return}
        Alamofire.request(tempURL).responseJSON {
            (dataResponse) in
            print("in alamofire completionHandler")
            guard let data = dataResponse.data else{ return }
            do{
                let temp = try JSONDecoder().decode(Films.self, from: data)
                completion(temp,nil)
            }catch let error{
                //                print("Serialziation Error")
                completion(nil,error)
            }
        }
    }
    
    
}
