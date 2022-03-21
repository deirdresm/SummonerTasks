//
//  Data+Checksum.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 3/13/22.
//

import Foundation
import CryptoKit

/// md5: used to determine if bestiary file has changed.
public extension Data {
	var md5: String? {
		return Insecure.MD5.hash(data: self).map { String(format: "%02hhx", $0) }.joined()
	 }
}
