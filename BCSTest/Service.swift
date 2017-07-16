//
//  Service.swift
//  BCSTest
//
//  Created by Andrey Ildyakov on 16.07.17.
//  Copyright © 2017 Andrey Ildyakov. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class loadData {
    func getList (completion:@escaping ([News])->()){
        var newsArray : [News] = []
        Alamofire.request("https://fapi.rtvi.com/api/v1/newslist").responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                for (_,subJson):(String, JSON) in json {
                    let imageLink = subJson["ImagePreview"].stringValue
                    let text = subJson["Title"].stringValue
                    let news = News(imageLink:imageLink, text: text)
//                    print(news)
                    newsArray.append(news)
                }
               completion(newsArray)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func search(text:String, completion:@escaping ([News])->()) {
        var newsArray : [News] = []
        let parameters: Parameters = ["searchString": text]

 //stop previous request
        let sessionManager = Alamofire.SessionManager.default
        sessionManager.session.getTasksWithCompletionHandler { dataTasks, uploadTasks, downloadTasks in
            dataTasks.forEach { $0.cancel() }
            uploadTasks.forEach { $0.cancel() }
            downloadTasks.forEach { $0.cancel() }
        }
  //delay 1.5
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            Alamofire.request("https://fapi.rtvi.com/api/v1/newslist", parameters: parameters).responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    for (_,subJson):(String, JSON) in json {
                        let imageLink = subJson["ImagePreview"].stringValue
                        let text = subJson["Title"].stringValue
                        let news = News(imageLink:imageLink, text: text)
                        newsArray.append(news)
                    }
                    completion(newsArray)
                case .failure(let error):
                    print(error)
                }
            }
        }

    }
}
