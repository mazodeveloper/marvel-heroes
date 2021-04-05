//
//  MD5.swift
//  MarvelTest
//
//  Created by Joan Andres Mazo Muñoz on 30/03/21.
//

import Foundation
import CommonCrypto

final class MD5: NSObject {
    func generateMD5(info: String) -> String {
        let length = Int(CC_MD5_DIGEST_LENGTH)
        let infoData = info.data(using:.utf8)!
        var digestData = Data(count: length)
        _ = digestData.withUnsafeMutableBytes { digestBytes -> UInt8 in
            infoData.withUnsafeBytes { infoBytes -> UInt8 in

            if let infoBytesBaseAddress = infoBytes.baseAddress,
               let digestBytesBindMemory = digestBytes.bindMemory(to: UInt8.self).baseAddress {
              let messageLength = CC_LONG(infoData.count)
              CC_MD5(infoBytesBaseAddress, messageLength, digestBytesBindMemory)
            }
            return 0

          }
        }

        return MD5Hex(data: digestData)
    }

    private func MD5Hex(data: Data) -> String {
      let md5Hex = data.map { String(format: "%02hhx", $0) }.joined()
      return md5Hex
    }
}
