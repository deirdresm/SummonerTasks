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

    init(string: String) throws {
        let data = Data(string.utf8)
        value = try JSONSerialization.jsonObject(with: data, options: [.allowFragments])
    }

    init(value: Any?) {
        self.value = value
    }

    var optionalBool: Bool? {
        value as? Bool
    }

    var optionalDouble: Double? {
        value as? Double
    }

	var number: NSNumber {
		optionalNumber ?? 0
	}

	var optionalNumber: NSNumber? {
		value as? NSNumber
	}

    var optionalInt: Int64? {
        value as? Int64
    }

	var optionalInt16: Int16? {
		value as? Int16
	}

    var optionalString: String? {
        value as? String
    }

    var bool: Bool {
        optionalBool ?? false
    }

    var double: Double {
        optionalDouble ?? 0
    }

    var int: Int64 {
        optionalInt ?? 0
    }

	var int16: Int16 {
		optionalInt16 ?? 0
	}

    var string: String {
        optionalString ?? ""
    }

    var optionalArray: [JSON]? {
        let converted = value as? [Any]
        return converted?.map { JSON(value: $0) }
    }

    var optionalDictionary: [String: JSON]? {
        let converted = value as? [String: Any]
        return converted?.mapValues { JSON(value: $0) }
    }

    var array: [JSON] {
        optionalArray ?? []
    }

    var dictionary: [String: JSON] {
        optionalDictionary ?? [:]
    }

    public subscript(index: Int) -> JSON {
        optionalArray?[index] ?? JSON(value: nil)
    }

    subscript(key: String) -> JSON {
        optionalDictionary?[key] ?? JSON(value: nil)
    }

    subscript(dynamicMember key: String) -> JSON {
        optionalDictionary?[key] ?? JSON(value: nil)
    }
}
