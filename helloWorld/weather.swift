struct Weather: Codable {
    var successs: String?
    var result:result
    var records: records
}

struct records: Codable {
    var datasetDescription:String
    var location: [location?]
}

struct location: Codable {
    var locationName: String
    var weatherElement: [weatherElement]
}

struct weatherElement: Codable {
    var elementName: String
    var time: [time]
}

struct time: Codable {
    var startTime: String
    var endTime: String
    var parameter:parameter
}

struct parameter: Codable{
    var parameterName: String
    var parameterValue: String?
    var parameterUnit: String?
}
struct result:Codable{
    var resource_id:String
    var fields:[fields]
}
struct fields:Codable{
    var id:String
    var type:String
}
