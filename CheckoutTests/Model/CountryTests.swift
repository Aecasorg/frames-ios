//
//  CountryTests.swift
//  
//
//  Created by Daven.Gomes on 18/11/2021.
//

import XCTest
@testable import Checkout
// swiftlint:disable type_body_length function_body_length
final class CountryTests: XCTestCase {
  func test_allAvailable_matchesExpected() {
    let expectedCountries: [Country] = [
      Country(iso3166Alpha2: "AF", dialingCode: "93"),
      Country(iso3166Alpha2: "AX", dialingCode: "358"),
      Country(iso3166Alpha2: "AL", dialingCode: "355"),
      Country(iso3166Alpha2: "DZ", dialingCode: "213"),
      Country(iso3166Alpha2: "AS", dialingCode: "1684"),
      Country(iso3166Alpha2: "AD", dialingCode: "376"),
      Country(iso3166Alpha2: "AO", dialingCode: "244"),
      Country(iso3166Alpha2: "AI", dialingCode: "1264"),
      Country(iso3166Alpha2: "AQ", dialingCode: "672"),
      Country(iso3166Alpha2: "AG", dialingCode: "1268"),
      Country(iso3166Alpha2: "AR", dialingCode: "54"),
      Country(iso3166Alpha2: "AM", dialingCode: "374"),
      Country(iso3166Alpha2: "AW", dialingCode: "297"),
      Country(iso3166Alpha2: "AC", dialingCode: "247"),
      Country(iso3166Alpha2: "AU", dialingCode: "61"),
      Country(iso3166Alpha2: "AT", dialingCode: "43"),
      Country(iso3166Alpha2: "AZ", dialingCode: "994"),
      Country(iso3166Alpha2: "BS", dialingCode: "1242"),
      Country(iso3166Alpha2: "BH", dialingCode: "973"),
      Country(iso3166Alpha2: "BD", dialingCode: "880"),
      Country(iso3166Alpha2: "BB", dialingCode: "1246"),
      Country(iso3166Alpha2: "BY", dialingCode: "375"),
      Country(iso3166Alpha2: "BE", dialingCode: "32"),
      Country(iso3166Alpha2: "BZ", dialingCode: "501"),
      Country(iso3166Alpha2: "BJ", dialingCode: "229"),
      Country(iso3166Alpha2: "BM", dialingCode: "1441"),
      Country(iso3166Alpha2: "BT", dialingCode: "975"),
      Country(iso3166Alpha2: "BO", dialingCode: "591"),
      Country(iso3166Alpha2: "BA", dialingCode: "387"),
      Country(iso3166Alpha2: "BW", dialingCode: "267"),
      Country(iso3166Alpha2: "BR", dialingCode: "55"),
      Country(iso3166Alpha2: "IO", dialingCode: "246"),
      Country(iso3166Alpha2: "BN", dialingCode: "673"),
      Country(iso3166Alpha2: "BG", dialingCode: "359"),
      Country(iso3166Alpha2: "BF", dialingCode: "226"),
      Country(iso3166Alpha2: "BI", dialingCode: "257"),
      Country(iso3166Alpha2: "KH", dialingCode: "855"),
      Country(iso3166Alpha2: "CM", dialingCode: "237"),
      Country(iso3166Alpha2: "CA", dialingCode: "1"),
      Country(iso3166Alpha2: "CV", dialingCode: "238"),
      Country(iso3166Alpha2: "KY", dialingCode: "1345"),
      Country(iso3166Alpha2: "CF", dialingCode: "236"),
      Country(iso3166Alpha2: "TD", dialingCode: "235"),
      Country(iso3166Alpha2: "CL", dialingCode: "56"),
      Country(iso3166Alpha2: "CN", dialingCode: "86"),
      Country(iso3166Alpha2: "CX", dialingCode: "61"),
      Country(iso3166Alpha2: "CC", dialingCode: "61"),
      Country(iso3166Alpha2: "CO", dialingCode: "57"),
      Country(iso3166Alpha2: "KM", dialingCode: "269"),
      Country(iso3166Alpha2: "CG", dialingCode: "242"),
      Country(iso3166Alpha2: "CK", dialingCode: "682"),
      Country(iso3166Alpha2: "CR", dialingCode: "506"),
      Country(iso3166Alpha2: "HR", dialingCode: "385"),
      Country(iso3166Alpha2: "CU", dialingCode: "53"),
      Country(iso3166Alpha2: "CY", dialingCode: "357"),
      Country(iso3166Alpha2: "CZ", dialingCode: "420"),
      Country(iso3166Alpha2: "CD", dialingCode: "243"),
      Country(iso3166Alpha2: "DK", dialingCode: "45"),
      Country(iso3166Alpha2: "DJ", dialingCode: "253"),
      Country(iso3166Alpha2: "DM", dialingCode: "1767"),
      Country(iso3166Alpha2: "DO", dialingCode: "1849"),
      Country(iso3166Alpha2: "EC", dialingCode: "593"),
      Country(iso3166Alpha2: "EG", dialingCode: "20"),
      Country(iso3166Alpha2: "SV", dialingCode: "503"),
      Country(iso3166Alpha2: "GQ", dialingCode: "240"),
      Country(iso3166Alpha2: "ER", dialingCode: "291"),
      Country(iso3166Alpha2: "EE", dialingCode: "372"),
      Country(iso3166Alpha2: "SZ", dialingCode: "268"),
      Country(iso3166Alpha2: "ET", dialingCode: "251"),
      Country(iso3166Alpha2: "FK", dialingCode: "500"),
      Country(iso3166Alpha2: "FO", dialingCode: "298"),
      Country(iso3166Alpha2: "FJ", dialingCode: "679"),
      Country(iso3166Alpha2: "FI", dialingCode: "358"),
      Country(iso3166Alpha2: "FR", dialingCode: "33"),
      Country(iso3166Alpha2: "GF", dialingCode: "594"),
      Country(iso3166Alpha2: "PF", dialingCode: "689"),
      Country(iso3166Alpha2: "GA", dialingCode: "241"),
      Country(iso3166Alpha2: "GM", dialingCode: "220"),
      Country(iso3166Alpha2: "GE", dialingCode: "995"),
      Country(iso3166Alpha2: "DE", dialingCode: "49"),
      Country(iso3166Alpha2: "GH", dialingCode: "233"),
      Country(iso3166Alpha2: "GI", dialingCode: "350"),
      Country(iso3166Alpha2: "GR", dialingCode: "30"),
      Country(iso3166Alpha2: "GL", dialingCode: "299"),
      Country(iso3166Alpha2: "GD", dialingCode: "1473"),
      Country(iso3166Alpha2: "GP", dialingCode: "590"),
      Country(iso3166Alpha2: "GU", dialingCode: "1671"),
      Country(iso3166Alpha2: "GT", dialingCode: "502"),
      Country(iso3166Alpha2: "GG", dialingCode: "44"),
      Country(iso3166Alpha2: "GN", dialingCode: "224"),
      Country(iso3166Alpha2: "GW", dialingCode: "245"),
      Country(iso3166Alpha2: "GY", dialingCode: "592"),
      Country(iso3166Alpha2: "HT", dialingCode: "509"),
      Country(iso3166Alpha2: "VA", dialingCode: "379"),
      Country(iso3166Alpha2: "HN", dialingCode: "504"),
      Country(iso3166Alpha2: "HK", dialingCode: "852"),
      Country(iso3166Alpha2: "HU", dialingCode: "36"),
      Country(iso3166Alpha2: "IS", dialingCode: "354"),
      Country(iso3166Alpha2: "IN", dialingCode: "91"),
      Country(iso3166Alpha2: "ID", dialingCode: "62"),
      Country(iso3166Alpha2: "IR", dialingCode: "98"),
      Country(iso3166Alpha2: "IQ", dialingCode: "964"),
      Country(iso3166Alpha2: "IE", dialingCode: "353"),
      Country(iso3166Alpha2: "IM", dialingCode: "44"),
      Country(iso3166Alpha2: "IL", dialingCode: "972"),
      Country(iso3166Alpha2: "IT", dialingCode: "39"),
      Country(iso3166Alpha2: "CI", dialingCode: "225"),
      Country(iso3166Alpha2: "JM", dialingCode: "1876"),
      Country(iso3166Alpha2: "JP", dialingCode: "81"),
      Country(iso3166Alpha2: "JE", dialingCode: "44"),
      Country(iso3166Alpha2: "JO", dialingCode: "962"),
      Country(iso3166Alpha2: "KZ", dialingCode: "77"),
      Country(iso3166Alpha2: "KE", dialingCode: "254"),
      Country(iso3166Alpha2: "KI", dialingCode: "686"),
      Country(iso3166Alpha2: "KP", dialingCode: "850"),
      Country(iso3166Alpha2: "KR", dialingCode: "82"),
      Country(iso3166Alpha2: "XK", dialingCode: "383"),
      Country(iso3166Alpha2: "KW", dialingCode: "965"),
      Country(iso3166Alpha2: "KG", dialingCode: "996"),
      Country(iso3166Alpha2: "LA", dialingCode: "856"),
      Country(iso3166Alpha2: "LV", dialingCode: "371"),
      Country(iso3166Alpha2: "LB", dialingCode: "961"),
      Country(iso3166Alpha2: "LS", dialingCode: "266"),
      Country(iso3166Alpha2: "LR", dialingCode: "231"),
      Country(iso3166Alpha2: "LY", dialingCode: "218"),
      Country(iso3166Alpha2: "LI", dialingCode: "423"),
      Country(iso3166Alpha2: "LT", dialingCode: "370"),
      Country(iso3166Alpha2: "LU", dialingCode: "352"),
      Country(iso3166Alpha2: "MO", dialingCode: "853"),
      Country(iso3166Alpha2: "MG", dialingCode: "261"),
      Country(iso3166Alpha2: "MW", dialingCode: "265"),
      Country(iso3166Alpha2: "MY", dialingCode: "60"),
      Country(iso3166Alpha2: "MV", dialingCode: "960"),
      Country(iso3166Alpha2: "ML", dialingCode: "223"),
      Country(iso3166Alpha2: "MT", dialingCode: "356"),
      Country(iso3166Alpha2: "MH", dialingCode: "692"),
      Country(iso3166Alpha2: "MQ", dialingCode: "596"),
      Country(iso3166Alpha2: "MR", dialingCode: "222"),
      Country(iso3166Alpha2: "MU", dialingCode: "230"),
      Country(iso3166Alpha2: "YT", dialingCode: "262"),
      Country(iso3166Alpha2: "MX", dialingCode: "52"),
      Country(iso3166Alpha2: "FM", dialingCode: "691"),
      Country(iso3166Alpha2: "MD", dialingCode: "373"),
      Country(iso3166Alpha2: "MC", dialingCode: "377"),
      Country(iso3166Alpha2: "MN", dialingCode: "976"),
      Country(iso3166Alpha2: "ME", dialingCode: "382"),
      Country(iso3166Alpha2: "MS", dialingCode: "1664"),
      Country(iso3166Alpha2: "MA", dialingCode: "212"),
      Country(iso3166Alpha2: "MZ", dialingCode: "258"),
      Country(iso3166Alpha2: "MM", dialingCode: "95"),
      Country(iso3166Alpha2: "NA", dialingCode: "264"),
      Country(iso3166Alpha2: "NR", dialingCode: "674"),
      Country(iso3166Alpha2: "NP", dialingCode: "977"),
      Country(iso3166Alpha2: "NL", dialingCode: "31"),
      Country(iso3166Alpha2: "AN", dialingCode: "599"),
      Country(iso3166Alpha2: "NC", dialingCode: "687"),
      Country(iso3166Alpha2: "NZ", dialingCode: "64"),
      Country(iso3166Alpha2: "NI", dialingCode: "505"),
      Country(iso3166Alpha2: "NE", dialingCode: "227"),
      Country(iso3166Alpha2: "NG", dialingCode: "234"),
      Country(iso3166Alpha2: "NU", dialingCode: "683"),
      Country(iso3166Alpha2: "NF", dialingCode: "672"),
      Country(iso3166Alpha2: "MK", dialingCode: "389"),
      Country(iso3166Alpha2: "MP", dialingCode: "1670"),
      Country(iso3166Alpha2: "NO", dialingCode: "47"),
      Country(iso3166Alpha2: "OM", dialingCode: "968"),
      Country(iso3166Alpha2: "PK", dialingCode: "92"),
      Country(iso3166Alpha2: "PW", dialingCode: "680"),
      Country(iso3166Alpha2: "PS", dialingCode: "970"),
      Country(iso3166Alpha2: "PA", dialingCode: "507"),
      Country(iso3166Alpha2: "PG", dialingCode: "675"),
      Country(iso3166Alpha2: "PY", dialingCode: "595"),
      Country(iso3166Alpha2: "PE", dialingCode: "51"),
      Country(iso3166Alpha2: "PH", dialingCode: "63"),
      Country(iso3166Alpha2: "PN", dialingCode: "872"),
      Country(iso3166Alpha2: "PL", dialingCode: "48"),
      Country(iso3166Alpha2: "PT", dialingCode: "351"),
      Country(iso3166Alpha2: "PR", dialingCode: "1939"),
      Country(iso3166Alpha2: "QA", dialingCode: "974"),
      Country(iso3166Alpha2: "RE", dialingCode: "262"),
      Country(iso3166Alpha2: "RO", dialingCode: "40"),
      Country(iso3166Alpha2: "RU", dialingCode: "7"),
      Country(iso3166Alpha2: "RW", dialingCode: "250"),
      Country(iso3166Alpha2: "BL", dialingCode: "590"),
      Country(iso3166Alpha2: "SH", dialingCode: "290"),
      Country(iso3166Alpha2: "KN", dialingCode: "1869"),
      Country(iso3166Alpha2: "LC", dialingCode: "1758"),
      Country(iso3166Alpha2: "MF", dialingCode: "590"),
      Country(iso3166Alpha2: "PM", dialingCode: "508"),
      Country(iso3166Alpha2: "VC", dialingCode: "1784"),
      Country(iso3166Alpha2: "WS", dialingCode: "685"),
      Country(iso3166Alpha2: "SM", dialingCode: "378"),
      Country(iso3166Alpha2: "ST", dialingCode: "239"),
      Country(iso3166Alpha2: "SA", dialingCode: "966"),
      Country(iso3166Alpha2: "SN", dialingCode: "221"),
      Country(iso3166Alpha2: "RS", dialingCode: "381"),
      Country(iso3166Alpha2: "SC", dialingCode: "248"),
      Country(iso3166Alpha2: "SL", dialingCode: "232"),
      Country(iso3166Alpha2: "SG", dialingCode: "65"),
      Country(iso3166Alpha2: "SX", dialingCode: "1721"),
      Country(iso3166Alpha2: "SK", dialingCode: "421"),
      Country(iso3166Alpha2: "SI", dialingCode: "386"),
      Country(iso3166Alpha2: "SB", dialingCode: "677"),
      Country(iso3166Alpha2: "SO", dialingCode: "252"),
      Country(iso3166Alpha2: "ZA", dialingCode: "27"),
      Country(iso3166Alpha2: "GS", dialingCode: "500"),
      Country(iso3166Alpha2: "SS", dialingCode: "211"),
      Country(iso3166Alpha2: "ES", dialingCode: "34"),
      Country(iso3166Alpha2: "LK", dialingCode: "94"),
      Country(iso3166Alpha2: "SD", dialingCode: "249"),
      Country(iso3166Alpha2: "SR", dialingCode: "597"),
      Country(iso3166Alpha2: "SJ", dialingCode: "47"),
      Country(iso3166Alpha2: "SE", dialingCode: "46"),
      Country(iso3166Alpha2: "CH", dialingCode: "41"),
      Country(iso3166Alpha2: "SY", dialingCode: "963"),
      Country(iso3166Alpha2: "TW", dialingCode: "886"),
      Country(iso3166Alpha2: "TJ", dialingCode: "992"),
      Country(iso3166Alpha2: "TZ", dialingCode: "255"),
      Country(iso3166Alpha2: "TH", dialingCode: "66"),
      Country(iso3166Alpha2: "TL", dialingCode: "670"),
      Country(iso3166Alpha2: "TG", dialingCode: "228"),
      Country(iso3166Alpha2: "TK", dialingCode: "690"),
      Country(iso3166Alpha2: "TO", dialingCode: "676"),
      Country(iso3166Alpha2: "TT", dialingCode: "1868"),
      Country(iso3166Alpha2: "TN", dialingCode: "216"),
      Country(iso3166Alpha2: "TR", dialingCode: "90"),
      Country(iso3166Alpha2: "TM", dialingCode: "993"),
      Country(iso3166Alpha2: "TC", dialingCode: "1649"),
      Country(iso3166Alpha2: "TV", dialingCode: "688"),
      Country(iso3166Alpha2: "UG", dialingCode: "256"),
      Country(iso3166Alpha2: "UA", dialingCode: "380"),
      Country(iso3166Alpha2: "AE", dialingCode: "971"),
      Country(iso3166Alpha2: "GB", dialingCode: "44"),
      Country(iso3166Alpha2: "US", dialingCode: "1"),
      Country(iso3166Alpha2: "UM", dialingCode: "246"),
      Country(iso3166Alpha2: "UY", dialingCode: "598"),
      Country(iso3166Alpha2: "UZ", dialingCode: "998"),
      Country(iso3166Alpha2: "VU", dialingCode: "678"),
      Country(iso3166Alpha2: "VE", dialingCode: "58"),
      Country(iso3166Alpha2: "VN", dialingCode: "84"),
      Country(iso3166Alpha2: "VG", dialingCode: "1284"),
      Country(iso3166Alpha2: "VI", dialingCode: "1340"),
      Country(iso3166Alpha2: "WF", dialingCode: "681"),
      Country(iso3166Alpha2: "YE", dialingCode: "967"),
      Country(iso3166Alpha2: "ZM", dialingCode: "260"),
      Country(iso3166Alpha2: "ZW", dialingCode: "263")
    ]

    XCTAssertEqual(Country.allAvailable, expectedCountries)
  }

  func test_Country_init() {
    XCTAssertEqual(Country(iso3166Alpha2: "GB"), Country(iso3166Alpha2: "GB", dialingCode: "44"))
    XCTAssertEqual(Country(iso3166Alpha2: "AE"), Country(iso3166Alpha2: "AE", dialingCode: "971"))
    XCTAssertEqual(Country(iso3166Alpha2: "UZ"), Country(iso3166Alpha2: "UZ", dialingCode: "998"))
    XCTAssertEqual(Country(iso3166Alpha2: "WF"), Country(iso3166Alpha2: "WF", dialingCode: "681"))
  }
}