//
//  NonZeroValidator.swift
//  NonZeroValidator
//
//  Created by Deirdre Saoirse Moen on 10/9/21.
//

import Foundation
import FormValidator

/// A protocol representing a form validator.
public protocol IntValidator: Validatable {
	/// The value type of this validator
	var value: Int { get set }

	/// This functions is called internally to trigger validation.
	///
	/// - Parameters:
	///   - value: The value type.
	///   - errorMessage: The error message.
	/// - Returns: Validation object.
	func validate() -> Validation
}


//// This validator validates if a string is empty of blank.
public class NonZeroValidator: IntValidator {
	public var publisher: ValidationPublisher!
	public var subject: ValidationSubject = .init()
	public var onChanged: ((Validation) -> Void)? = nil

	public init() {
	}

	public var errorMessage: StringProducerClosure = {
		""
	}
	public var value: Int = 0

	public func validate() -> Validation {
		if value.signum() == 0 {
			return .failure(message: errorMessage())
		}
		return .success
	}

}

