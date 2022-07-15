//
//  CardNumberViewTests.swift
//  FramesTests
//
//  Created by Harry Brown on 13/07/2022.
//  Copyright © 2022 Checkout. All rights reserved.
//

import XCTest
import UIKit
@testable import Frames

final class CardNumberViewTests: XCTestCase {
  private var subject: CardNumberView!

  private var mockViewModel: MockCardNumberViewModel! = MockCardNumberViewModel()

  override func setUp() {
    super.setUp()

    subject = CardNumberView(viewModel: mockViewModel)
  }

  override func tearDown() {
    mockViewModel = nil

    super.tearDown()
  }

  func test_textFieldShouldReturn_returnTrue() {
    XCTAssertTrue(subject.textFieldShouldReturn())
    XCTAssertNil(mockViewModel.eagerValidateCalledWith)
    XCTAssertEqual(subject.schemeIcon, .blank)
    XCTAssertNil(subject.cardNumberError)
  }

  func test_textField_rangeIsInvalid_returnTrue() {
    // given
    let textField = UITextField()
    textField.text = ""
    let range = NSRange(3...4)

    // then
    XCTAssertTrue(subject.textField(textField, shouldChangeCharactersIn: range, replacementString: ""))
    XCTAssertNil(mockViewModel.eagerValidateCalledWith)
    XCTAssertEqual(subject.schemeIcon, .blank)
    XCTAssertNil(subject.cardNumberError)
  }

  func test_textField_noUpdateFromViewModel() {
    // given
    let textField = UITextField()
    textField.text = ""
    mockViewModel.eagerValidateToReturn = nil

    // when
    XCTAssertFalse(subject.textField(textField, shouldChangeCharactersIn: NSRange(), replacementString: "12345"))

    // then
    XCTAssertEqual(textField.text, "")
    XCTAssertEqual(mockViewModel.eagerValidateCalledWith, "12345")
    XCTAssertEqual(subject.schemeIcon, .blank)
    XCTAssertNil(subject.cardNumberError)
  }

  func test_textField_updateFromViewModel() {
    // given
    let textField = UITextField()
    textField.text = ""
    mockViewModel.eagerValidateToReturn = ("45678", .visa)

    // when
    XCTAssertFalse(subject.textField(textField, shouldChangeCharactersIn: NSRange(), replacementString: "12345"))

    // then
    XCTAssertEqual(textField.text, "45678")
    XCTAssertEqual(mockViewModel.eagerValidateCalledWith, "12345")
    XCTAssertEqual(subject.schemeIcon, .visa)
    XCTAssertNil(subject.cardNumberError)
  }

  func test_textFieldShouldEndEditing_success() {
    // given
    mockViewModel.validateToReturn = .success(.visa)

    // when
    XCTAssertTrue(subject.textFieldShouldEndEditing(textField: UITextField(), replacementString: "12345"))

    // then
    XCTAssertEqual(subject.schemeIcon, .visa)
    XCTAssertNil(subject.cardNumberError)
    XCTAssertEqual(mockViewModel.validateCalledWith, "12345")
  }

  func test_textFieldShouldEndEditing_failure() {
    // given
    mockViewModel.validateToReturn = .failure(.invalid)

    // when
    XCTAssertTrue(subject.textFieldShouldEndEditing(textField: UITextField(), replacementString: "12345"))

    // then
    XCTAssertEqual(subject.schemeIcon, .blank)
    XCTAssertEqual(subject.cardNumberError, .invalid)
    XCTAssertEqual(mockViewModel.validateCalledWith, "12345")
  }
}

