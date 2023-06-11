import Foundation

extension Dictionary where Key == String {
	func bool(for key: String) -> Bool? {
		self[key] as? Bool
	}

	func double(for key: String) -> Double? {
		self[key] as? Double
	}

	func int(for key: String) -> Int64? {
		self[key] as? Int64
	}

	func string(for key: String) -> String? {
		self[key] as? String
	}
}

@dynamicMemberLookup
public struct JSON: RandomAccessCollection {
	var value: Any?
	public var startIndex: Int { array.startIndex }
	public var endIndex: Int { array.endIndex }

	public init(string: String) throws {
		let data = Data(string.utf8)
		value = try JSONSerialization.jsonObject(with: data, options: [.allowFragments])
//		print(value)
	}

	public init(value: Any?) {
		self.value = value
	}

	public var optionalBool: Bool? {
		value as? Bool
	}

	public var optionalDouble: Double? {
		value as? Double
	}

	public var optionalInt: Int64? {
		value as? Int64
	}

	public var optionalInt16: Int16? {
		value as? Int16
	}

	public var optionalString: String? {
		value as? String
	}

	public var bool: Bool {
		optionalBool ?? false
	}

	public var double: Double {
		optionalDouble ?? 0
	}

	public var int: Int64 {
		optionalInt ?? 0
	}

	public var int16: Int16 {
		optionalInt16 ?? 0
	}

	public var string: String {
		optionalString ?? ""
	}

//	private func unwrap(_ object: Any) -> Any {
//		switch object {
//		case let json as JSON:
//			return unwrap(json.object)
//		case let array as [Any]:
//			return array.map(unwrap)
//		case let dictionary as [String: Any]:
//			var d = dictionary
//			dictionary.forEach { pair in
//				d[pair.key] = unwrap(pair.value)
//			}
//			return d
//		default:
//			return object
//		}
//	}

//	public var doubleArray: [Double] {
//		let converted = value as? [Double]
//		return converted.map { [$0.double] }
//	}

	public var optionalDoubleArray: [Double]? {
		var array = [Double]()

		let converted = value as? [AnyObject]
		let mapped: [Double]? = converted?.map {
			print($0)
			array.append(
				$0 as! Double
			)
			return $0 as! Double
//			return JSON(value: $0)
		}
		print("Mapped: \(mapped)")

		return array
	}

	public var optionalArray: [JSON]? {
		let converted = value as? [Any]
		let mapped: [JSON]? = converted?.map {
			print($0)
			return JSON(value: $0)
		}
		return mapped
	}

	public var optionalDictionary: [String: JSON]? {
		let converted = value as? [String: Any]
		return converted?.mapValues { JSON(value: $0) }
	}

	public var array: [JSON] {
		optionalArray ?? []
	}

	public var dictionary: [String: JSON] {
		optionalDictionary ?? [:]
	}

	public subscript(index: Int) -> JSON {
		optionalArray?[index] ?? JSON(value: nil)
	}

	public subscript(key: String) -> JSON {
		optionalDictionary?[key] ?? JSON(value: nil)
	}

	public subscript(dynamicMember key: String) -> JSON {
		optionalDictionary?[key] ?? JSON(value: nil)
	}
}
