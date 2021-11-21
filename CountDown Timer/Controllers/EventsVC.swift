//
//  ViewController.swift
//  CountDown Timer
//
//  Created by Ali Hameedaldeen on 07/11/2021.
//

import UIKit
import CoreData
import AVFoundation

class EventsVC: UIViewController {


    @IBOutlet weak var EventsTableView: UITableView!
    @IBOutlet weak var SearchBar: UISearchBar!
    @IBOutlet weak var AddEventButton: UIButton!
    @IBOutlet weak var settingsButton: UIBarButtonItem!
    
    var eventName: String?
    var eventDate: Date?
    
    var eventsArray = [Item]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        EventsTableView.delegate = self
        EventsTableView.dataSource = self
        
        SearchBar.delegate = self
        
        SearchBar.placeholder = "Search Events Here"
        
        loadItems()
    }

    @IBAction func AddEventPressed(_ sender: UIButton) {
        
    }
    
    
    @IBAction func unwind(_ sender: UIStoryboardSegue) {
        
        let newItem = Item(context: context)
        newItem.name = eventName!
        newItem.date = eventDate!
        eventsArray.append(newItem)

        EventsTableView.reloadData()
        
        saveItems()

    }
    
    
    @IBAction func EditPressed(_ sender: UIBarButtonItem) {
        EventsTableView.isEditing = !EventsTableView.isEditing
        sender.title = (EventsTableView.isEditing) ? "Done" : "Edit"
    }
    
    func saveItems() {
        
        do {
            try context.save()
        } catch {
            print("Error Saving Context \(error)")
        }
        
        EventsTableView.reloadData()
    }
    
    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest()) {

        do {
            eventsArray = try context.fetch(request)
        } catch {
            print("Error Loading Data \(error)")
        }
        EventsTableView.reloadData()
    }
}



//MARK: - TableView Delegate Method

extension EventsVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ToCountDownVC", sender: self)
        tableView.deselectRow(at: indexPath, animated: false)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        let vc = segue.destination as? DateViewController

        vc?.nameOfEvent = eventsArray[indexPath()].name
        vc?.dateOfEvent = eventsArray[indexPath()].date
    }
    
    func indexPath() -> Int {
      return EventsTableView.indexPathForSelectedRow!.row
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0//Choose your custom row height
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            
            context.delete(eventsArray[indexPath.row])

            eventsArray.remove(at: indexPath.item)
            EventsTableView.deleteRows(at: [indexPath], with: .automatic)
            
            saveItems()
        }
    }
}


//MARK: - TableView Data Source Methods

extension EventsVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath)
        
        cell.textLabel?.text = eventsArray[indexPath.row].name
        cell.textLabel?.textColor = .white
        return cell
        
    }
}

//MARK: - Search Bar Delegate Methods

extension EventsVC: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        
        request.predicate = NSPredicate(format: "name CONTAINS[cd] %@", searchBar.text!)
                
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: false)]
        
        loadItems(with: request)
        
        EventsTableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            
            loadItems()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}
