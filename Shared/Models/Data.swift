/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Helpers for loading images and data.
*/

import Foundation
import CoreLocation
import CoreData
import SwiftUI
import ImageIO

protocol JsonArray {
    associatedtype ItemsArray
    
    static var items: [ItemsArray] {get set}

    static func saveToCoreData(_ docInfo: SummonerDocumentInfo)
}

protocol CoreDataUtility
{
    func update(from: AnyObject)
    static func insertOrUpdate(from: AnyObject, docInfo: SummonerDocumentInfo)
    static func batchUpdate(from: [AnyObject], docInfo: SummonerDocumentInfo)
}

extension Array where Element == String {
    func compactMap<T: LosslessStringConvertible>() -> [T] {
        return self.compactMap({ T($0) })
    }
}

extension StringProtocol {
    var firstUppercased: String { prefix(1).uppercased() + dropFirst() }
    var firstCapitalized: String { prefix(1).capitalized + dropFirst() }
}

// from https://www.swiftbysundell.com/articles/customizing-codable-types-in-swift/

protocol StringRepresentable: CustomStringConvertible {
    init?(_ string: String)
}

extension Int: StringRepresentable {}

struct StringBacked<Value: StringRepresentable>: Codable {
    var value: Value
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let string = try container.decode(String.self)
        
        guard let value = Value(string) else {
            throw DecodingError.dataCorruptedError(
                in: container,
                debugDescription: """
                Failed to convert an instance of \(Value.self) from "\(string)"
                """
            )
        }
        
        self.value = value
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(value.description)
    }
}

extension Array where Element: BinaryInteger {

    /// The average value of all the items in the array
    var average: Double {
        if self.isEmpty {
            return 0
        } else {
            let sum = Double(self.reduce(0, +))
            return sum / Double(self.count)
        }
    }
    
    var leastSquares: Double {
        let avg = self.average
        var squareSum = 0.0
        
        for color in 0 ..< self.count {
            squareSum += (Double(self[color]) - avg) * (Double(self[color]) - avg)
        }
        
        return squareSum
    }
}

//class IntArrayToDataTransformer: ValueTransformer {
//    override func transformedValue(_ value: Any?) -> Any? {
//        let boxedData = NSKeyedArchiver.archivedData(withRootObject: value!)
//        return boxedData
//    }
//    override func reverseTransformedValue(_ value: Any?) -> Any? {
//        let typedBlob = value as! Data
//        let data = try NSKeyedUnarchiver.unarchivedObject(ofClasses: [Int.self], from: typedBlob)
//        return (data as! [Int])
//    }
//}


enum ImageType: String {
    case artifacts
    case buffs
    case buildings
    case dungeons
    case elements
    case future
    case icons
    case items
    case monsters
    case runes
    case skills
    case leaders
    case stars
    
    var path: String {
        switch self {
        case .leaders:
            return ("skills/leader")
        case .artifacts, .buffs, .buildings, .dungeons, .elements, .future, .icons, .items,
             .monsters, .runes, .skills, .stars:
            return ("\(self)")
        default:
            return ""
        }
    }

}

//let landmarkData: [Landmark] = load("landmarkData.json")
//let features = landmarkData.filter { $0.isFeatured }
//let hikeData: [Hike] = load("hikeData.json")

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    // TODO: will need to unzip the bestiary_data.json.zip
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}

final class ImageStore {
    fileprivate static var scale = 1
    
    static var shared = ImageStore()
    
    static func loadImage(type: ImageType, name: String) -> CGImage {
        guard
            let url = Bundle.main.url(forResource: name, withExtension: "", subdirectory: "Images/\(type.path)"),
            let imageSource = CGImageSourceCreateWithURL(url as NSURL, nil),
            let image = CGImageSourceCreateImageAtIndex(imageSource, 0, nil)
        else {
            fatalError("Couldn't load image Images/\(type.rawValue)/\(name) from main bundle.")
        }
        return image
    }
}


//final class JsonStore {
//    static var shared = JsonStore()
//    
//    static func loadJson(name: String) -> Any {
//        var json: Any?
//        
//        if let fileUrl = Bundle.main.url(forResource: name, withExtension: "json") {
//            do {
//                var data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
//                var decoder = JSONDecoder()
//                decoder.keyDecodingStrategy = .convertFromSnakeCase
//                
//                json = try? JSONSerialization.jsonObject(with: data)
//            } catch {
//                fatalError("Couldn't load JSON file \(name).json from main bundle.")
//            }
//            return json as Any
//        }
//    }
//}
