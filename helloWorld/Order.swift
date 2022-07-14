import RealmSwift
class Order:Object{
    @objc dynamic var id:String=UUID().uuidString
    @objc dynamic var name=""
    @objc dynamic var price=0
    @objc dynamic var date=Date()
    override static func primaryKey() -> String? {
        return "id"
        
    }
}
