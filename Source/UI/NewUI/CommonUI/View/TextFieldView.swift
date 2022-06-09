import UIKit

protocol TextFieldViewDelegate: AnyObject {
    func textFieldShouldBeginEditing(textField: UITextField)
    func textFieldShouldReturn()
    func textFieldShouldEndEditing(textField: UITextField, replacementString: String)
    func textFieldShouldChangeCharactersIn(textField: UITextField, replacementString string: String)
}

class TextFieldView: UIView {

    // MARK: - Properties

    weak var delegate: TextFieldViewDelegate?

    private var style: CellTextFieldStyle?
    private var type: BillingFormCell?
    private lazy var textFieldContainerBottomAnchor = textFieldContainer?.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)

    // MARK: - UI elements

    private(set) lazy var headerLabel: UILabel? = {
        let view = UILabel()
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()

    private(set) lazy var mandatoryLabel: UILabel? = {
        let view = UILabel()
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()

    private(set) lazy var hintLabel: UILabel? = {
        let view = UILabel()
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()

    private(set) lazy var textFieldContainer: UIView? = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private(set) lazy var textField: BillingFormTextField? = {
        var view = BillingFormTextField(type: type, tag: tag)
        if self.type?.index == BillingFormCell.phoneNumber(nil).index {
            view = BillingFormPhoneNumberText(type: type, tag: tag, phoneNumberTextDelegate: self)
        }
        view.autocorrectionType = .no
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()

    private(set) lazy var errorView: ErrorView? = {
        let view = ErrorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - Update subviews style

    func update(style: CellStyle?, type: BillingFormCell?, textFieldValue: String? = nil) {
        guard let type = type, let style = style as? CellTextFieldStyle else { return }
        self.type = type
        self.style = style
        setupViewsInOrder()
        backgroundColor = style.backgroundColor
        updateHeaderLabel(style: style)
        setupMandatoryLabel(style: style)
        updateHintLabel(style: style)
        updateTextFieldContainer(style: style)
        updateTextField(style: style, textFieldValue: textFieldValue)
        updateErrorView(style: style)
    }

    private func updateHeaderLabel(style: CellTextFieldStyle) {
        headerLabel?.text = style.title?.text
        headerLabel?.font = style.title?.font
        headerLabel?.textColor = style.title?.textColor
    }

    private func setupMandatoryLabel(style: CellTextFieldStyle) {
        mandatoryLabel?.isHidden = style.isMandatory
        mandatoryLabel?.text = Constants.LocalizationKeys.BillingForm.Cell.optionalInput
        mandatoryLabel?.font = UIFont(graphikStyle: .regular, size:  Constants.Style.BillingForm.InputOptionalLabel.fontSize.rawValue)
        mandatoryLabel?.textColor = .doveGray
    }

    private func updateHintLabel(style: CellTextFieldStyle) {
        hintLabel?.text = style.hint?.text
        hintLabel?.font = style.hint?.font
        hintLabel?.textColor = style.hint?.textColor
    }

    private func updateTextFieldContainer(style: CellTextFieldStyle) {
        let borderColor = !style.error.isHidden ?
        style.textfield.errorBorderColor.cgColor :
        style.textfield.normalBorderColor.cgColor

        textFieldContainer?.layer.borderColor = borderColor
        textFieldContainer?.layer.cornerRadius = style.textfield.cornerRadius
        textFieldContainer?.layer.borderWidth = style.textfield.borderWidth
        textFieldContainer?.backgroundColor = style.textfield.backgroundColor
    }

    private func updateTextField(style: CellTextFieldStyle, textFieldValue: String?) {
        if let textFieldValue = textFieldValue {
            textField?.text = textFieldValue
        }
        textField?.type = type
        textField?.keyboardType = style.textfield.isSupportingNumericKeyboard ? .phonePad : .default
        textField?.textContentType = style.textfield.isSupportingNumericKeyboard ? .telephoneNumber : .name
        textField?.text = style.textfield.text
        textField?.font = style.textfield.font
        textField?.placeholder = style.textfield.placeHolder
        textField?.textColor = style.textfield.textColor
        textField?.tintColor = style.textfield.tintColor
    }

    private func updateErrorView(style: CellTextFieldStyle) {
        errorView?.update(style: style.error)
        errorView?.isHidden = style.error.isHidden
        textFieldContainerBottomAnchor?.constant = -(style.error.isHidden ? 0 : style.error.height)
    }
}

// MARK: - Views Layout Constraint

extension TextFieldView {

    private func setupViewsInOrder() {
        backgroundColor = style?.backgroundColor
        setupHeaderLabel()
        setupMandatoryLabel()
        setupHintLabel()
        setupTextFieldContainer()
        setupTextField()
        setupErrorView()
    }

    private func setupHeaderLabel() {
        guard let headerLabel = headerLabel else { return }
        addSubview(headerLabel)
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: topAnchor),
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
        ])
    }

    private func setupMandatoryLabel() {
        guard let mandatoryLabel = mandatoryLabel else { return }
        guard let headerLabel = headerLabel else { return }
        addSubview(mandatoryLabel)
        NSLayoutConstraint.activate([
            mandatoryLabel.topAnchor.constraint(equalTo: topAnchor),
            mandatoryLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            mandatoryLabel.leadingAnchor.constraint(greaterThanOrEqualTo: headerLabel.trailingAnchor)
        ])
    }

    private func setupHintLabel() {
        guard let hintLabel = hintLabel else { return }
        guard let headerLabel = headerLabel else { return }
        addSubview(hintLabel)
        NSLayoutConstraint.activate([
            hintLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 2),
            hintLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            hintLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    private func setupTextFieldContainer() {
        guard let textFieldContainer = textFieldContainer else { return }
        guard let hintLabel = hintLabel else { return }

        textFieldContainer.setContentHuggingPriority(.required, for: .vertical)
        addSubview(textFieldContainer)
        NSLayoutConstraint.activate([
            textFieldContainer.topAnchor.constraint(equalTo: hintLabel.bottomAnchor, constant: 6),
            textFieldContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            textFieldContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            textFieldContainerBottomAnchor ?? textFieldContainer.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    private func setupTextField() {
        guard let textFieldContainer = textFieldContainer else { return }
        guard let textField = textField else { return }
        let heightStyle = style?.textfield.height ?? Constants.Style.BillingForm.InputTextField.height.rawValue
        textFieldContainer.addSubview(textField)
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: textFieldContainer.topAnchor),
            textField.leadingAnchor.constraint(equalTo: textFieldContainer.leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: textFieldContainer.trailingAnchor, constant: -20),
            textField.bottomAnchor.constraint(equalTo: textFieldContainer.bottomAnchor),
            textField.heightAnchor.constraint(equalToConstant: heightStyle)
        ])
    }

    private func setupErrorView() {
        guard let errorView = errorView else { return }
        guard let textFieldContainer = textFieldContainer else { return }

        addSubview(errorView)

        NSLayoutConstraint.activate([
            errorView.topAnchor.constraint(equalTo: textFieldContainer.bottomAnchor, constant: 10),
            errorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            errorView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}

// MARK: - Text Field Delegate

extension TextFieldView: UITextFieldDelegate {

    func textFieldDidBeginEditing(_ textField: UITextField) {
        delegate?.textFieldShouldBeginEditing(textField: textField)
        textFieldContainer?.layer.borderColor = style?.textfield.focusBorderColor.cgColor
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        delegate?.textFieldShouldEndEditing(textField: textField, replacementString: textField.text ?? "")
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        delegate?.textFieldShouldReturn()
        return false
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        delegate?.textFieldShouldChangeCharactersIn(textField: textField, replacementString: string)
        return true
    }

}

// MARK: - Phone Number Text Delegate

extension TextFieldView: BillingFormPhoneNumberTextDelegate {
    // TODO: implement phone number validation logic
    func validateNumber() {

    }

    func updateCountryCode(code: Int) {
    }
}