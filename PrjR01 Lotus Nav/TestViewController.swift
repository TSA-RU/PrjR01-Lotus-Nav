//
//  TestViewController.swift
//  PrjR01 Lotus Nav
//
//  Created by Sergey Tolnykin on 02.06.2020.
//  Copyright © 2020 Sergey Tolnykin. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {
    
    struct DomainStruct: Decodable {
        var name: String
        var topLevelDomain: [String]
        var flag: String
        
//        var domainName: String
    }
    
    var domains: [DomainStruct] = []

    @IBOutlet weak var topImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        topImageView.downloadedFrom(link: "https://demotivation.ru/wp-content/uploads/2020/03/s1200-64.jpg")
        
        let url = URL(string: "https://restcountries.eu/rest/v2/all")
        URLSession.shared.dataTask(with: url!) {(data, responce, error) in
            if error == nil {
                do {
                    self.domains = try JSONDecoder().decode([DomainStruct].self, from:data!)
                }catch {
                    print("Parsing Error")
                }
                print(self.domains.count)
            }
        }.resume()
        
//        for i in 0..<20 {
//            domains += [DomainStruct(name: "Country \(i)")]
//        }

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension TestViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return domains.count
    }
    
    func svgImage (image: String, width: Int, height: Int) -> UIImage {
        let imgs : UIImage = UIImage(named: image)!
        let size = imgs.size
        let uSize = CGSize(width: width, height: height)
        let uWidth = uSize.width / imgs.size.width
        let uHeight = uSize.height / imgs.size.height
        var newSize: CGSize
        if uWidth > uHeight {
            newSize = CGSize(width: size.width * uHeight, height: size.height * uHeight)
        } else {
            newSize = CGSize(width: size.width * uWidth, height: size.height * uWidth)
        }
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0)
        imgs.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }


    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TestCell", for: indexPath)
       
        cell.textLabel?.text = domains[indexPath.row].name
        var dmn = "\(domains[indexPath.row].topLevelDomain.count) "
        for i in 0..<domains[indexPath.row].topLevelDomain.count {
            dmn += domains[indexPath.row].topLevelDomain[i] + " "
        }
        cell.detailTextLabel?.text = dmn
//        cell.imageView?.downloadedFrom(link: "http://swiftbook.ru/sites/default/files/images/ivan.png")
        
//        if let filePath = Bundle.main.path(forResource: "imageName", ofType: "jpg"), let image = UIImage(contentsOfFile: filePath) {
//            imageView.contentMode = .scaleAspectFit
//            imageView.image = image
//        }
        return cell
    }
    
    
}
 extension UIImageView {
   
   func downloadedFrom(link:String) {
    guard let url = URL(string: link) else { return }
    URLSession.shared.dataTask(with: url, completionHandler: { (data, _, error) -> Void in
      guard let data = data , error == nil, let image = UIImage(data: data) else { return }
      DispatchQueue.main.async { () -> Void in
        self.image = image
      }
    }).resume()
  }
  
}
