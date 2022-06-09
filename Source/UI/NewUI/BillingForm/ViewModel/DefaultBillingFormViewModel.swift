import UIKit
import Checkout

/**
 This class is for billing form list view model logic.
 */

final class DefaultBillingFormViewModel: BillingFormViewModel {

    // MARK: - Properties

    /// Delegates
    weak var editDelegate: BillingFormViewModelEditingDelegate?
    weak var textFieldDelegate: BillingFormTextFieldDelegate?
    weak var delegate: BillingFormViewModelDelegate?

    var updateRow: (() -> Void)?
    var errorFlagOfCellType = [Int: Bool]()
    var textValueOfCellType = [Int: String]()

    private var country: Country?
    private(set) var style: BillingFormStyle
    private(set) var data: BillingForm?
    private(set) var updatedRow: Int? {
        didSet { updateRow?() }
    }

    // MARK: - Public methods

    /**
     Initializes view model with some required protocols
     
     - Parameters:
     - style: The bill form view Style implementation.
     - initialCountry: //TODO: will be implemented in country ticket
     - initialRegionCode: //TODO: will be implemented in country next ticket
     - delegate: Optional billing form view Model delegate
     */

    init(style: BillingFormStyle, data: BillingForm? = nil, delegate: BillingFormViewModelDelegate? = nil) {
        self.style = style
        self.data = data
        self.delegate = delegate
        updateCellsValues()
    }

    func getHeaderView(delegate: BillingFormHeaderCellDelegate?) -> UIView {
        let isDoneButtonEnabled = textValueOfCellType.values.count == self.style.cells.count
        style.header.doneButton.isEnabled = isDoneButtonEnabled
        let view = BillingFormHeaderCell(style: style.header, delegate: delegate)
        view.update(style: style.header)
        editDelegate = view
        return view
    }

    func getCell(tableView: UITableView, indexPath: IndexPath, sender: UIViewController?) -> UITableViewCell {
        guard style.cells.count > indexPath.row else { return UITableViewCell() }

        if isCountryType(for: indexPath.row) {
            return getCountryCell(tableView: tableView, indexPath: indexPath, sender: sender)
        }
        return getTextFieldCell(tableView: tableView, indexPath: indexPath, sender: sender)
    }

    // MARK: - Private methods

    /// update cell text values and error values dictionaries after updating billing form data object
    private func updateCellsValues() {
        style.cells.forEach { type in
            let isMandatory = type.style?.isMandatory ?? true
            let value = type.getText(from: data)
            let hasValue = value != nil

            textValueOfCellType[type.index] = hasValue ? value : (!isMandatory ? "" : nil)
            errorFlagOfCellType[type.index] = hasValue ? false : isMandatory
        }
    }

    private func isCountryType(for row: Int) -> Bool {
        style.cells[row].index == BillingFormCell.country(.none).index
    }

    private func getTextFieldCell(tableView: UITableView, indexPath: IndexPath, sender: UIViewController?) -> UITableViewCell {

        if let cell: CellTextField = tableView.dequeueReusable(for: indexPath) {
            let cellStyle = updateTextFieldStyle(for: indexPath.row)
            cell.delegate = sender as? CellTextFieldDelegate
            cell.update(type: style.cells[indexPath.row],
                        style: cellStyle,
                        tag: indexPath.row,
                        textFieldValue: textValueOfCellType[style.cells[indexPath.row].index])
            return cell
        }

        return UITableViewCell()
    }

    /// country selection button
    private func getCountryCell(tableView: UITableView, indexPath: IndexPath, sender: UIViewController?) -> UITableViewCell {

        /// table view cell
        if let cell: CellButton = tableView.dequeueReusable(for: indexPath) {
            let cellStyle = updateCountrySelectionStyle(for: indexPath.row)
            cell.delegate = sender as? CellButtonDelegate
            cell.update(type: style.cells[indexPath.row],
                        style: cellStyle,
                        tag: indexPath.row)
            return cell
        }
        return UITableViewCell()

    }

    /// update text fields with pre-filled text
    private func updateTextFieldStyle(for row: Int) -> CellTextFieldStyle? {
        var viewStyle = style.cells[row].style as? CellTextFieldStyle
        if let text = textValueOfCellType[row] {
            viewStyle?.textfield.text = text
        }
        viewStyle?.error.isHidden = !(errorFlagOfCellType[row] ?? false)
        return viewStyle
    }

    /// update country selection with pre-filled text
    private func updateCountrySelectionStyle(for row: Int) -> CellButtonStyle? {
        var viewStyle = style.cells[row].style as? CellButtonStyle
        if let text = textValueOfCellType[row] {
            viewStyle?.button.text = text
        }
        viewStyle?.error.isHidden = !(errorFlagOfCellType[row] ?? false)
        return viewStyle
    }

    // MARK: - Text Field logic

    func validate(text: String?, cellStyle: BillingFormCell, row: Int) {

        guard cellStyle.index < errorFlagOfCellType.count,
              cellStyle.index >= 0,
              let style = cellStyle.style,
              style.isMandatory else {
            errorFlagOfCellType[cellStyle.index] = false
            return
        }
        errorFlagOfCellType[cellStyle.index] = cellStyle.validator.validate(text: text)
    }

    func validateTextFieldByCharacter(textField: UITextField, replacementString string: String) {
        guard let type = (textField as? BillingFormTextField)?.type else { return }
        
        validate(text: string, cellStyle: type, row: textField.tag)
        
        let shouldRemoveText = (textField.text?.count ?? 1 == 1) && (type.style?.isMandatory ?? false)
        
        if !string.isEmpty {
            textValueOfCellType[type.index] = string
        } else if shouldRemoveText {
            textValueOfCellType[type.index] = nil
        }

        let hasErrorValue = errorFlagOfCellType.isEmpty || errorFlagOfCellType.values.allSatisfy({$0})

        let areAllFieldsAreFulfilled = textValueOfCellType.values.count == style.cells.count && !hasErrorValue

        editDelegate?.didFinishEditingBillingForm(successfully: areAllFieldsAreFulfilled)
    }

    private func validateTextOnEndEditing(textField: BillingFormTextField) {
        guard let type = textField.type else { return }
        
        validate(text: textField.text , cellStyle: type, row: textField.tag)
        
        let shouldSaveText = !(textField.text?.isEmpty ?? true) || (type.style?.isMandatory ?? false)
        
        textValueOfCellType[type.index] =  shouldSaveText ? textField.text : nil

        updatedRow = textField.type?.index
    }
}

// MARK: - Table View Delegate

extension DefaultBillingFormViewModel: BillingFormTableViewDelegate {
    func tableView(estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }

    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        UITableView.automaticDimension
    }

    func tableView(numberOfRowsInSection section: Int) -> Int {
        style.cells.count
    }

    func tableView(tableView: UITableView, cellForRowAt indexPath: IndexPath, sender: UIViewController) -> UITableViewCell {
        getCell(tableView: tableView, indexPath: indexPath, sender: sender)
    }
}

// MARK: - Text View Delegate

extension DefaultBillingFormViewModel: BillingFormTextFieldDelegate {
    func textFieldShouldEndEditing(textField: BillingFormTextField, replacementString: String) {
        validateTextOnEndEditing(textField: textField)
    }

    func textFieldShouldChangeCharactersIn(textField: UITextField, replacementString string: String) {
        validateTextFieldByCharacter(textField: textField, replacementString: string)
    }
}

// MARK: - Billing form view controller Delegate

extension DefaultBillingFormViewModel: BillingFormViewControllerDelegate {

    func update(country: Country) {
        self.country = country
        let index = BillingFormCell.country(nil).index
        textValueOfCellType[index] = country.name
        updatedRow = index
    }

    func getViewForHeader(sender: UIViewController) -> UIView? {
        return getHeaderView(delegate: sender as? BillingFormHeaderCellDelegate)
    }

    func doneButtonIsPressed(sender: UIViewController) {

        let phone = Phone(
            number: textValueOfCellType[BillingFormCell.phoneNumber(nil).index],
            country: country)

        let address = Address(
            addressLine1: textValueOfCellType[BillingFormCell.addressLine1(nil).index],
            addressLine2: textValueOfCellType[BillingFormCell.addressLine2(nil).index],
            city: textValueOfCellType[BillingFormCell.city(nil).index],
            state: textValueOfCellType[BillingFormCell.state(nil).index],
            zip: textValueOfCellType[BillingFormCell.postcode(nil).index],
            country: country)

        let name = textValueOfCellType[BillingFormCell.fullName(nil).index] ?? ""

        let data: BillingForm = BillingForm(name: name,
                                                     address: address,
                                                     phone: phone)

        delegate?.onTapDoneButton(data: data)

        sender.dismiss(animated: true)
    }

    func cancelButtonIsPressed(sender: UIViewController) {
        sender.dismiss(animated: true)
    }
}