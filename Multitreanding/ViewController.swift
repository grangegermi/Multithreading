//
//  ViewController.swift
//  Multitreanding
//
//  Created by Даша Волошина on 12.11.22.
//

//ДЗ: Закидываем в проект файлы (1) https://jsonplaceholder.typicode.com/posts, (2) https://jsonplaceholder.typicode.com/comments,  (3) https://jsonplaceholder.typicode.com/photos, (4) https://jsonplaceholder.typicode.com/albums в виде json. Их надо взять на concurrent очереди и при окончании загрузки на главном потоке выполнить print(Номер ресурса который был загружен). Когда закончиться загрузка 4-х ресурсов на главном потоке выполнить print(Все ресурсы загружены)

struct User:Decodable {
    let userId:Int
    let id:Int
    let title:String
    let body:String
}

struct User2:Decodable{
    let postId:Int
    let id:Int
    let name:String
    let email:String
    let body:String
}

struct User3:Decodable{
    let albumId:Int
    let id:Int
    let title:String
    let url:String
    let thumbnailUrl:String
}

struct User4:Decodable{
    let userId:Int
    let id:Int
    let title:String
}




import UIKit

class ViewController: UIViewController {
    
    let mainUrl = Bundle.main.url(forResource: "first", withExtension: "json")!
    let mainUrl2 = Bundle.main.url(forResource: "second", withExtension: "json")!
    let mainUrl3 = Bundle.main.url(forResource: "third", withExtension: "json")!
    let mainUrl4 = Bundle.main.url(forResource: "forth", withExtension: "json")!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var group = DispatchGroup()
        let queueConcurrent = DispatchQueue(label: "1234", attributes: .concurrent)
        let arrayUrl = [mainUrl,mainUrl2,mainUrl3,mainUrl4]
     
        
        for i in arrayUrl {
            group.enter()
            queueConcurrent.async {
                var data = try! Data(contentsOf: i)
                print(i)
                group.leave()
         
            }
            group.wait()
        }
     
          group.notify(queue: .main){
              print("All uploaded")
          }
  
    }
}

