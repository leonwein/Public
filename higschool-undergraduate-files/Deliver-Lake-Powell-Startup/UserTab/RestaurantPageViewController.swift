//
//  ViewControllerRestaurantPageViewController.swift
//  DeliverPage
//
//  Created by Leon Weingartner on 6/20/20.
//  Copyright © 2020 Leon Weingartner. All rights reserved.
//

import UIKit
import SafariServices
import Firebase
import FirebaseFirestore

class RestaurantPageViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    
    var restaurants: [Restaurant] = []
    var isAcitve: Bool = false
    
    let group = DispatchGroup()
    //var loadIndicator = UIActivityIndicatorView()
    

    
    private func setupNavigationBarItems() {
        
        let titleImageView = UIImageView(image: #imageLiteral(resourceName: "Deliver Logo"))
        titleImageView.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        titleImageView.contentMode = .scaleAspectFit
        let widthConstraint = titleImageView.widthAnchor.constraint(equalToConstant: 120)
        let heightConstraint = titleImageView.heightAnchor.constraint(equalToConstant: 48)
         heightConstraint.isActive = true
         widthConstraint.isActive = true
        navigationItem.titleView = titleImageView
  
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // activityIndicator()
       // loadIndicator.backgroundColor = .white
        //loadIndicator.stopAnimating()
        
        setupNavigationBarItems()
        
        
        globRest.name = ""
        globOrder.name = ""
        globName.name = ""
        globPhone.name = ""
        globPayment.name = ""
        globOrderID.name = ""
        globTimeOfDelivery.name = ""
        globDateOfDelivery.name = ""
        globDestDes.name = ""
        globDestination.name = ""
        globMenuLink.name = ""

        restaurants = createArray()
        
        tableView.delegate = self
        tableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    
    func createArray() -> [Restaurant] {
        var tempRestaurants: [Restaurant] = []
        
        let rest1 = Restaurant(image: #imageLiteral(resourceName: "o-1"), title: "Bird House  $$", link: "https://www.birdhouseaz.com/")
        let rest2 = Restaurant(image: #imageLiteral(resourceName: "BigJohnsBBQ.jpg"), title: "Big John's Texas BBQ  $$", link: "http://bigjohnstexasbbq.com/menus/pagelake-powell-restaurant-menu/")
        let rest3 = Restaurant(image: #imageLiteral(resourceName: "BlueBuddha_Youjeen_Cho"), title: "Blue Buddha  $$", link: "https://bluebuddhasushilounge.com/menu")
        let rest4 = Restaurant(image: #imageLiteral(resourceName: "Bonkers_Markus_Winkler"), title: "Bonkers  $$", link: "http://bonkerspageaz.com/menu.html")
        let rest5 = Restaurant(image: #imageLiteral(resourceName: "DDB"), title: "Dam Bar & Grille  $$", link: "http://www.damplaza.com/images/images/menus/2020/DamBar_AllDay_Menu2020.pdf")
        let rest6 = Restaurant(image: #imageLiteral(resourceName: "Denny's_Zachary_Spears"), title: "Denny's  $$", link: "https://www.dennys.com/food/")
        let rest7 = Restaurant(image: #imageLiteral(resourceName: "DarTai_Makrus_Winkler"), title: "Dara Thai Express  $$", link: "https://zmenu.com/dara-thai-express-page-online-menu/")
        let rest8 = Restaurant(image: #imageLiteral(resourceName: "Dominos_brett_jordan"), title: "Domino's  $$", link: "https://www.dominos.com/en/pages/order/menu#!/menu/category/viewall/")
        let rest9 = Restaurant(image: #imageLiteral(resourceName: "ElTapitio"), title: "El Tapitio  $$", link: "https://tapatiorestaurants.com/")
        let rest10 = Restaurant(image: #imageLiteral(resourceName: "FiestaMexicana"), title: "Fiesta Mexicana  $$", link: "https://fiestamexrest.com/dinner/")
        let rest11 = Restaurant(image: #imageLiteral(resourceName: "GlenSteakHouse_Loija_Nguyen"), title: "Glen Canyon Steak House  $$", link: "http://places.singleplatform.com/glen-canyon-steak-house/menu?ref=google#menu_1658982")
        let rest12 = Restaurant(image: #imageLiteral(resourceName: "unnamed-2"), title: "Gone West  $$", link: "http://www.gonewestfamilyrestaurant.com/menu.html")
        let rest13 = Restaurant(image: #imageLiteral(resourceName: "JackInTheBox"), title: "Jack In The Box  $", link: "https://www.jackinthebox.com/food")
        let rest14 = Restaurant(image: #imageLiteral(resourceName: "LittleCeasers_Alan_Hardman"), title: "Little Caesars  $", link: "https://littlecaesars.com/en-us/")
        let rest15 = Restaurant(image: #imageLiteral(resourceName: "McDonalds_Sepet"), title: "Mcdonald's  $", link: "https://www.mcdonalds.com/us/en-us/full-menu.html")
        let rest16 = Restaurant(image: #imageLiteral(resourceName: "NemosFish"), title: "Nemo's Fish and Chips  $$", link: "http://s3-media4.fl.yelpcdn.com/bphoto/wbccK6XJlHtfPy205vHHbg/o.jpg")
        let rest17 = Restaurant(image: #imageLiteral(resourceName: "PacosTacos_Tai's_Captures"), title: "Paco's Tacos  $", link: "https://zmenu.com/pacos-tacos-page-online-menu/")
        let rest18 = Restaurant(image: #imageLiteral(resourceName: "unnamed-4"), title: "Pizza Hut  $$", link: "https://www.pizzahut.com/index.php#/home")
        let rest19 = Restaurant(image: #imageLiteral(resourceName: "unnamed"), title: "R D's  $$", link: "https://s3-media1.fl.yelpcdn.com/bphoto/6FsZYZLqbV0_jvlYa6cKBA/o.jpg")
        
        let rest21 = Restaurant(image: #imageLiteral(resourceName: "Slakers_Jake_Weirick"), title: "Slakers  $$", link: "https://slackersqualitygrub.com/menu/")
        let rest22 = Restaurant(image: #imageLiteral(resourceName: "o-3"), title: "Sonic  $", link: "https://www.sonicdrivein.com/menu")
        let rest23 = Restaurant(image: #imageLiteral(resourceName: "o"), title: "Starlite Diner  $", link: "https://www.zomato.com/page-az/starlite-chinese-american-page/menu")
        let rest24 = Restaurant(image: #imageLiteral(resourceName: "State48_Andreas_M"), title: "State 48 Taver  $$", link: "https://state48tavern.com/")
        let rest25 = Restaurant(image: #imageLiteral(resourceName: "steer"), title: "Steer89  $$", link: "https://steer89.com/wp-content/uploads/2018/06/Steer-89-Menu.pdf")
        let rest26 = Restaurant(image: #imageLiteral(resourceName: "Stroms_Jonas_Kakaroto"), title: "Strombolli’s Italian  $$", link: "https://strombollisrestaurant.com/page/full-menu-page/")
        let rest27 = Restaurant(image: #imageLiteral(resourceName: "unnamed-3"), title: "Subway  $", link: "https://www.subway.com/en-US/MenuNutrition/Menu")
        let rest28 = Restaurant(image: #imageLiteral(resourceName: "20191108-182629-largejpg"), title: "Sunset89  $$", link: "https://www.sunset89.com/menu")
        let rest29 = Restaurant(image: #imageLiteral(resourceName: "TacoBell"), title: "Taco Bell  $", link: "https://www.tacobell.com/food")
        
        
        
        tempRestaurants.append(rest2)
        tempRestaurants.append(rest1)
        tempRestaurants.append(rest3)
        tempRestaurants.append(rest4)
        tempRestaurants.append(rest5)
        tempRestaurants.append(rest6)
        tempRestaurants.append(rest7)
        tempRestaurants.append(rest8)
        tempRestaurants.append(rest9)
        tempRestaurants.append(rest10)
        tempRestaurants.append(rest11)
        tempRestaurants.append(rest12)
        tempRestaurants.append(rest13)
        tempRestaurants.append(rest14)
        tempRestaurants.append(rest15)
        tempRestaurants.append(rest16)
        tempRestaurants.append(rest17)
        tempRestaurants.append(rest18)
        tempRestaurants.append(rest19)
    
        tempRestaurants.append(rest21)
        tempRestaurants.append(rest22)
        tempRestaurants.append(rest23)
        tempRestaurants.append(rest24)
        tempRestaurants.append(rest25)
        tempRestaurants.append(rest26)
        tempRestaurants.append(rest27)
        
        tempRestaurants.append(rest28)
        tempRestaurants.append(rest29)
        
        
        
        
        
        
        return tempRestaurants
    }

    

}

extension RestaurantPageViewController: RestaurantCellDelegate{
    func didTapMenu(url: String) {
        let menuURL = URL(string: url)!
        let safariVC = SFSafariViewController(url: menuURL)
        present(safariVC, animated: true, completion: nil)
    }
}

extension RestaurantPageViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let restaurant = restaurants[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell") as! RestaurantCell
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.gray
        cell.selectedBackgroundView = backgroundView
        
        
        cell.setRestaurant(restaurant: restaurant)
        cell.delegate = self
        
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let restaurant = restaurants[indexPath.row]
        isAcitve = false
        
        
        
        globRest.name = restaurant.title.replacingOccurrences(of: "$", with: "")
        globMenuLink.name = restaurant.link
        
        tableView.allowsSelection = false
        
        //start animating load indicator
        //loadIndicator.stopAnimating()

        
        
        fetchDataIsActive(coll: "UnclaimedOrders", doc: UserDefaults.standard.string(forKey: "activeOrder") ?? "")
       
        
        fetchDataIsActive(coll: "ClaimedOrders", doc: UserDefaults.standard.string(forKey: "activeOrder") ?? "")
        
        
        
        group.notify(queue: .main){
            
            print(self.isAcitve)
            
            tableView.allowsSelection = true
            if(self.isAcitve == true){
                self.createAlert(title: "CANT CREATE ORDER", message: "You can't have more than one active order. Check your active orders page to view the status of your delivery")
            }else{
                
                self.performSegue(withIdentifier: "cellToOrder", sender: nil)
            }
        }
       
       
        
    }
 
    
    func fetchDataIsActive(coll: String, doc: String){
     
        
        group.enter()

        
        Firestore.firestore().collection(coll).getDocuments() { (querySnapshot, err) in
            
             
               if let err = err {
                   print("Error getting documents: \(err)")
               } else {
               
                   for document in (querySnapshot?.documents)! {
                      
                       if document.documentID == doc {
                     
                        print("found it")
                        self.isAcitve = true                 
                           
                       }
                   }
                
               
                self.group.leave()
                 
               }
           }
        
       
       }
    
        @IBAction func unwindToOne(_sender: UIStoryboardSegue){}
        
    
    func createAlert (title:String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {(action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    

    
    
    
    
}
