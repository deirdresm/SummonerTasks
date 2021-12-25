//
//  RuneCheckerVM.swift
//  RuneCheckerVM
//
//  Created by Deirdre Saoirse Moen on 10/3/21.
//

import Foundation
import FormValidator

// https://www.reddit.com/r/summonerswar/comments/mv6c50/guide_hitchhikers_guide_to_summoners_war_rune/

class RuneInfo: ObservableObject {
	
	public static var runeTypes: [RuneType] = [.violent, .rage, .swift, .despair, .fatal, .vampire,
									.will, .nemesis, .blade, .energy, .guardRune,
									.focus, .endure, .shield, .revenge, .destroy,
									.fight, .accuracy, .determination, .enhance, .tolerance]

	@Published var runeType: RuneType = .violent
	@Published var slot: Int = 1

	@Published var mainStat: Int = 0
	@Published var mainStatValue: Int = 0

	@Published var innateStat: Int = 0
	@Published var innateStatValue: Int = 0

	@Published var firstSubstat: Int = 0
	@Published var firstStatValue: Int = 0

	@Published var secondSubstat: Int = 0
	@Published var secondStatValue: Int = 0

	@Published var thirdSubstat: Int = 0
	@Published var thirdSStatValue: Int = 0

	@Published var fourthSubstat: Int = 0
	@Published var fourthtatValue: Int = 0
	
	@Published var form = FormValidation(validationType: .immediate, messages: RuneCheckerValidation())

//	lazy var runeTypeValidation: ValidationContainer = {
//		$runeType.nonEmptyValidator(
//				form: form,
//				errorMessage: "Invalid rune type",
//				disableValidation: {
//					true
//				}
//		)
//	}()

//	lazy var slotValidation: ValidationContainer = {
//		let slotNo = "\($slot)"
//		slot.intValidator(
//				form: form,
//				minValue: 1,
//				maxValue: 6,
//				errorMessage: "Invalid slot number",
//				disableValidation: {
//					true
//				}
//		)
//	}()

}

class RuneCheckerValidation: DefaultValidationMessages {
	public override var required: String {
		"Required field"
	}
}
