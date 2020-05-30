import UIKit

var str = "Hello, playground"

//// CODABLE
//class City: NSObject, NSCoding
//{
//    var name: String?
//    var id: Int?
//
//    required init?(coder aDecoder: NSCoder)
//    {
//        self.name = aDecoder.decodeObject(forKey: "name") as? String
//        self.id = aDecoder.decodeObject(forKey: "id") as? Int
//    }
//
//    func encode(with aCoder: NSCoder)
//    {
//        aCoder.encode(self.name, forKey: "name")
//        aCoder.encode(self.id, forKey: "id")
//    }
//}

// mã hoá bằng cách sử dụng codable
struct Photo: Codable
{
    //String, URL, Bool and Date conform to Codable.
    var title: String
    var url: URL
    var isSample: Bool

    //The Dictionary is of type [String:String] and String already conforms to Codable.
    var metaData: [String:String]

    //PhotoType and Size are also Codable types
    var type: PhotoType
    var size: Size
}

struct Size: Codable
{
    var height: Double
    var width: Double
}

enum PhotoType: String, Codable
{
    case flower
    case animal
    case fruit
    case vegetable
}


// Encodable json encoder
let photoObject = Photo(title: "Hibiscus", url: URL(string: "https://www.flowers.com/hibiscus")!, isSample: false, metaData: ["color" : "red"], type: .flower, size: Size(height: 200, width: 200))
let encodedData = try? JSONEncoder().encode(photoObject)

let jsonString = """

"""
if let jsonData = jsonString.data(using: .utf8)
{
    let photoObject = try? JSONDecoder().decode(Photo.self, from: jsonData)
}

// Cách giải mã từ jsonData sang  
struct GroceryProduct: Codable {
    var name: String
    var points: Int
    var description: String?
}

let json = """
{
    "name": "Durian",
    "points": 600,
    "description": "A fruit with a distinctive scent."
}
""".data(using: .utf8)!

let decoder = JSONDecoder()
let product = try decoder.decode(GroceryProduct.self, from: json)

print(product.name) // Prints "Durian"


//struct Photo: Codable
//{
//    //This property is not included in the CodingKeys enum and hence will not be encoded/decoded.
//    var format: String = "png"
//
//    enum CodingKeys: String, CodingKey
//    {
//        case title = "name"
//        case url = "link"
//        case isSample
//        case metaData
//        case type
//        case size
//    }
//}

//struct Photo1
//{
//    var title: String
//    var size: Size
//
//    enum CodingKeys: String, CodingKey
//    {
//        case title = "name"
//        case width
//        case height
//    }
//}
//


struct photo1 {
    var title: String
    var size: Size
    enum codingKeys: String, CodingKey {
        case title = "name"
        case width
        case height
    }
}
extension photo1: Encodable {
    func encoding(to encoder: Encoder) throws  {
        var container = encoder.container(keyedBy: codingKeys.self)
        try  container.encode(title, forKey: .title)
        try container.encode(size.width, forKey: .width)
        try container.encode(size.height, forKey: .height)
        
        
    }
}
extension photo1: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: codingKeys.self)
        title = try values.decode(String.self, forKey: .title)
        let width = try values.decode(Double.self, forKey: .width)
        let height = try values.decode(Double.self, forKey: .height)
        size = Size(height: height, width: width)
    }
}

  
//SWIFT 4 Code

struct User: Decodable {
  let id: Int
  let name: String
  let age: Int
  let picture: URL?

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    id = try values.decode(Int.self, forKey: .id)
    name = try values.decode(String.self, forKey: .name)
    age = try values.decode(Int.self, forKey: .age)
    picture = try values.decode(URL?.self, forKey: .picture)
  }

  private enum CodingKeys: String, CodingKey {
    case id, name, age, picture = "profile_picture" //NOTICE THIS
  }
}

do {
//  let myUserStruct = JSONDecoder().decode(User.self, from: response.data)
    let myUserStruct = JSONDecoder().decode(User.self, from:  )
  print(myUserStruct.name) // prints "Mustafa"
} catch(let error) {
  print(error)
}
