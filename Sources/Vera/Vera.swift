//
// Vera.swift
// Vera
//
// Copyright (c) 2021 Andrés Ocampo (http://icologic.co)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

import Foundation

/// Strength of password. There are five levels divided by entropy value.
/// The entropy value is evaluated by infromation entropy theory.
public enum PasswordStrength {
    /// Entropy value is smaller than 28
    case veryWeak
    /// Entropy value is between 28 and 35
    case weak
    /// Entropy value is between 36 and 59
    case reasonable
    /// Entropy value is between 60 and 127
    case strong
    /// Entropy value is larger than 127
    case veryStrong
}

/// Vera validates strength of passwords.
open class Vera {

    /// Gets strength of a password.
    ///
    /// - parameter password: Password string to be calculated
    ///
    /// - returns: Level of strength in VRAPasswordStrength
    public static func strength(ofPassword password: String) -> PasswordStrength {
        return passwordStrength(forEntropy: entropy(of: password))
    }

    /// Converts VRAPasswordStrength to localized string.
    ///
    /// - parameter strength: NJOPasswordStrength to be converted
    ///
    /// - returns: Localized string
    public static func localizedString(forStrength strength: PasswordStrength) -> String {
        switch strength {
        case .veryWeak:
            return NSLocalizedString("VERA_VERY_WEAK", tableName: nil, bundle: Bundle.main, value: "Very Weak", comment: "Vera - Very weak")
        case .weak:
            return NSLocalizedString("VERA_WEAK", tableName: nil, bundle: Bundle.main, value: "Weak", comment: "Vera - Weak")
        case .reasonable:
            return NSLocalizedString("VERA_REASONABLE", tableName: nil, bundle: Bundle.main, value: "Reasonable", comment: "Vera - Reasonable")
        case .strong:
            return NSLocalizedString("VERA_STRONG", tableName: nil, bundle: Bundle.main, value: "Strong", comment: "Vera - Strong")
        case .veryStrong:
            return NSLocalizedString("VERA_VERY_STRONG", tableName: nil, bundle: Bundle.main, value: "Very Strong", comment: "Vera - Very Strong")
        }
    }

    private static func entropy(of string: String) -> Float {
        guard string.count > 0 else {
            return 0
        }

        var includesLowercaseCharacter = false,
            includesUppercaseCharacter = false,
            includesDecimalDigitCharacter = false,
            includesPunctuationCharacter = false,
            includesSymbolCharacter = false,
            includesWhitespaceCharacter = false,
            includesNonBaseCharacter = false

        var sizeOfCharacterSet: Float = 0

        string.enumerateSubstrings(in: string.startIndex ..< string.endIndex, options: .byComposedCharacterSequences) { subString, _, _, _ in
            guard let unicodeScalars = subString?.first?.unicodeScalars.first else {
                return
            }

            if !includesLowercaseCharacter && CharacterSet.lowercaseLetters.contains(unicodeScalars) {
                includesLowercaseCharacter = true
                sizeOfCharacterSet += 26
            }

            if !includesUppercaseCharacter && CharacterSet.uppercaseLetters.contains(unicodeScalars) {
                includesUppercaseCharacter = true
                sizeOfCharacterSet += 26
            }

            if !includesDecimalDigitCharacter && CharacterSet.decimalDigits.contains(unicodeScalars) {
                includesDecimalDigitCharacter = true
                sizeOfCharacterSet += 10
            }

            if !includesSymbolCharacter && CharacterSet.symbols.contains(unicodeScalars) {
                includesSymbolCharacter = true
                sizeOfCharacterSet += 10
            }

            if !includesPunctuationCharacter && CharacterSet.punctuationCharacters.contains(unicodeScalars) {
                includesPunctuationCharacter = true
                sizeOfCharacterSet += 20
            }

            if !includesWhitespaceCharacter && CharacterSet.whitespacesAndNewlines.contains(unicodeScalars) {
                includesWhitespaceCharacter = true
                sizeOfCharacterSet += 1
            }

            if !includesNonBaseCharacter && CharacterSet.nonBaseCharacters.contains(unicodeScalars) {
                includesNonBaseCharacter = true
                sizeOfCharacterSet += 32 + 128
            }
        }

        return log2f(sizeOfCharacterSet) * Float(string.count)
    }

    private static func passwordStrength(forEntropy entropy: Float) -> PasswordStrength {
        if entropy < 28 {
            return .veryWeak
        } else if entropy < 36 {
            return .weak
        } else if entropy < 60 {
            return .reasonable
        } else if entropy < 128 {
            return .strong
        } else {
            return .veryStrong
        }
    }
}
