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
    
    static func downloadImage(type: RetSingleType, completion: @escaping(UIImage?, Error?)->() ){
        let tempURL = type.Description
        print("downloading image                                                                                                                               with url \(tempURL)")
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




