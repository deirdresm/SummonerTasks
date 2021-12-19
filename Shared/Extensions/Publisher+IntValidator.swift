//
//  Publisher+IntValidator.swift
//  Publisher+IntValidator
//
//  Created by Deirdre Saoirse Moen on 10/10/21.
//

import Foundation
import FormValidator

public extension Published.Publisher where Value == Int {
	func intValidator(
			form: FormValidation,
			minValue: Int,
			maxValue: Int,
			errorMessage: @autoclosure @escaping StringProducerClosure = "",
			disableValidation: @escaping DisableValidationClosure = {
				false
			}
	) -> ValidationContainer {
		let validator = IntValidator(minValue: minValue, maxValue: maxValue)
		return ValidationPublishers.create(
				form: form,
				validator: validator,
				for: self.eraseToAnyPublisher(),
				disableValidation: disableValidation,
				errorMessage: errorMessage().orIfEmpty(form.messages.invalidDate))
	}
}
