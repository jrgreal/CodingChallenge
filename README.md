# CodingChallenge
An application that lists all items retrieved from the iTunes Search API given some predefined parameters, 
and capable of showing a detailed view of each item.

Below are some explanations to the choices I made in implementing the features of this app.

## Persistence

### Date when the user last visited
I opted to use NSUserDefaults because of its simplicity and straghtforward use.
Only a single information is needed to be stored, so it would not make sense to make a more complex persistence.

### Last screen the user visted
Apple has already provided state preservation and restoration in the UIKit framework, 
and I think it should be used to our advantage so that we don't have to manually keep track of the view hierarchy. 
These are found in the AppDelegate and UIViewController

##### AppDelegate
```
func application(_ application: UIApplication, shouldSaveApplicationState coder: NSCoder) -> Bool
func application(_ application: UIApplication, shouldRestoreApplicationState coder: NSCoder) -> Bool 
```

##### ViewController
```
func encodeRestorableState(with coder: NSCoder)
func encodeRestorableState(with coder: NSCoder)
func applicationFinishedRestoringState()
```

For the data displayed by the view controller, the approach I used in storing it is to have the model 
conform to the Codable protocol, then encode it using a JSONEncoder to convert it to a JSON data, 
then encode it once again using the view controller's coder.

```
func encode<T: Encodable>(_ object: T) {
    guard let data = try? JSONEncoder().encode(object) else { 
        return
    }
    encode(data)
}
```

For restoration, I used the view controller's coder to decode the JSON data, 
then the JSONDecoder do convert back to the model, which will be used by views.
```
func decode<T: Decodable>() -> T? {
    guard let data = decodeObject() as? Data,
        let object = try? JSONDecoder().decode(T.self, from: data) else {
            return nil
    }
    return object
}
```


I no longer implemented the state preservation and restoration in the list view because it is the first 
view controller displayed anyway and the data will be fetched again from the API once it loads.

## Architecture

### Model-View-Controller (MVC)
It is a given that in iOS development, MVC is used almost everywhere because of how the frameworks have been designed.

### Decorator
Extensions are, in a way, decorators because they additional behavior and functionalities to classes, structs and enums.
An example if this is the Date type that I extendend to add a computed property of its string representation in a given format.

```
extension Date {
    /// A string representation of the date
    var dateText: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        let formatted = formatter.string(from: self)
        return formatted
    }
}
```

### Delegation
When using a table view, delegation is needed in order to display data through its data source, 
and respond to different events through the table view delegate.

#### UITableViewDataSource
```
extension MoviesTableViewDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataOrganizer.rowsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MovieCell = tableView.dequeueReusableCell(for: indexPath)
        cell.viewModel = MovieCell.ViewModel(movie: dataOrganizer[indexPath])
        return cell
    }
}
```

#### UITableViewDelegate
```
extension MoviesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        fetchImageForRow(at: indexPath)
    }
}
```

### Memento
This pattern was used in order to preserve and restore the state of the screen that the user last visited.

