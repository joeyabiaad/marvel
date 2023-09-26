//
//  Validiations.swift
//  Marvel
//
//  Created by Joey Abi Aad on 26/09/2023.
//

import UIKit

struct Regex {
    static let passwordRegExp = "(?=.*\\d+)(?=.*[a-zA-Z]+)(?=.*[-~!@#$%^&*()+_]+)(^[-\\w~!@#$%^&*()+]+$)"
    static let customerIdRegExp = "^\\w{4,}$"
    static let namesRegExp = "^[-\\w()'_,\\s./]*$"
    static let messageRegExp = "^[-+\\w'.,:;?!@#$%^&*(){}\\[\\]\\\\/\\r\\n\\t\\s]*$"
    static let emailRegExp = "^\\w+([-.]\\w+)*@\\w+(-\\w+)*(\\.\\w+(-\\w+)*)?\\.\\w{2,}$"
    static let numberRegExp = "^\\d*$"
    static let AmountRegExp = "^([\\d,]+([.]?[\\d,]+)?)?$"
    static let KeyRegex = "^[a-zA-Z]+$"
    static let otpcode = "^[0-9]{1,6}$"
    static let SecretKeyRegExp = "^[^o-yO-Y]+$"
    static let PhoneNumberRegExp = "^[0-9]{4,20}$"
    static let noSpecialCharactersRegExp = "^[-\\w()'_,\\s.\\/]*$"
    static let etheriumWalletRegex = "0x[a-fA-F0-9]{40}$"
}

struct Messages {
    static let customIdInvalid = "customIdInvalid"
    static let customIdInUse = "customIdInUse"
    static let customIdAvailable = "customIdAvailable"
    static let countryRequired = "country_required"
    static let addressLine1Required = "address_line1_required"
    static let cityRequired = "city_required"
    static let postCodeRequired = "post_code_required"
    static let phoneRequired = "phone_required"
    static let wrongPhoneFormat = "wrong_phone_format"
    static let emailRequired = "email_required"
    static let wrongEmailFormat = "wrong_email_format"
    static let invalidDob = "older_than_x"
    static let usernameRequired = "username_required"
    static let passwordRequired = "password_required"
    static let usernameLength = "username_should_contain_characters"
    static let metamaskNotInstalled = "metamask_required"
    
    static let forceUpdate = "Update application"
    static let noNetwork = "noNetwork"
    static let unexpectedError = "unexpected_error"
}

