//
//  UIFormDefaultField.swift
//  SehatQ
//
//  Created by Macbook on 08/05/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class UIFormDefaultField : UIView {
    
    enum FormState {
        case normal
        case disabled
        case error
    }
    
    enum Format{
        case normal
        case npwp
        case rtrw
    }
    
    @IBOutlet weak var formField: SkyFloatingLabelTextField!
    
    @IBOutlet weak var bottomLabel: UILabel!
    
    @IBOutlet var contentView: UIView!
    
    var prefixText: String = ""
    var maxLength: Int?
    var format : Format = Format.normal
    
    var formState : FormState = FormState.normal
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        Bundle.main.loadNibNamed("UIFormDefaultField", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        setState(state: FormState.normal)
        setFieldLabelText(labelText: "")
        setFieldText(text: "")
        setFieldPlaceholderText(placeholderText: "")
        setFieldHint(hint: "")
        toggleHint(show: false)
        toggleLeftView(show: false)
        toggleRightView(show: false)
        
        self.formField.delegate = self
    }
    
    open func toggleLeftView(show: Bool) {
        if (show) {
            formField.leftViewMode = .always
        } else {
            formField.leftViewMode = .never
        }
    }
    
    open func setPrefixText(text: String) {
        prefixText = text
    }

    open func setMaxText(length: Int) {
        maxLength = length
    }

    open func setSideIcon(view: UIFormDefaultFieldSideIcon) {
        addSideView(view: view)
    }
    
    open func setSideText(view: UIFormDefaultFieldSideText) {
        addSideView(view: view)
    }
    
    open func toggleRightView(show: Bool) {
        if (show) {
            formField.rightViewMode = .always
        } else {
            formField.rightViewMode = .never
        }
    }
    
    private func addSideView(view: UIView!) {
        formField.rightView = view
        formField.rightViewMode = .always
    }
    
    open func setFieldText(text: String) {
        formField.textColor = .gunmetal
        formField.font = Font.willUse(name: FontType.regular, size: FontSize.M)
        formField.text = text
    }
    
    open func setFieldLabelText(labelText: String) {
        formField.title = labelText
        formField.titleColor = .blueyGrey
        formField.selectedTitleColor = .blueyGrey
        formField.titleFont = Font.willUse(name: FontType.medium, size: 12.0)
        formField.titleFormatter = { $0 }
    }
    
    open func setFieldPlaceholderText(placeholderText: String) {
        formField.placeholder = placeholderText
        formField.placeholderColor = .blueyGrey
        formField.placeholderFont = Font.willUse(name: FontType.regular, size: FontSize.M)
    }
    
    open func toggleHint(show: Bool) {
        if (show) {
            bottomLabel.isHidden = false
        } else {
            bottomLabel.isHidden = true
        }
    }
    
    open func setState(state: FormState) {
        formState = state
        if (formState == FormState.normal) {
            formField.lineColor = .steelGrey
            formField.selectedLineColor = .steelGrey
            bottomLabel.textColor = .blueyGrey
        } else if (formState == FormState.error) {
            formField.lineColor = .systemRed
            formField.selectedLineColor = .systemRed
            bottomLabel.textColor = .colorRedMagentaRed
        } else if (formState == FormState.disabled) {
            // TODO: Handle disable?
        }
    }
    
    open func setFieldHint(hint : String) {
        bottomLabel.text = hint
        formField.titleFont = Font.willUse(name: FontType.regular, size: 12.0)
    }
    
    open func setSecureTextEntry(value: Bool) {
        formField.isSecureTextEntry = value
    }
    
    open func setKeyboardType(type: UIKeyboardType) {
        if (type == .numberPad){
            formField.addDoneCancelToolbar()
        }
        formField.keyboardType = type
    }
    
    open func getValue() -> String {
        let realTextCount = (formField.text?.count ?? 0) - prefixText.count
        let offset = 0 - realTextCount
        let str = formField.text!
        if (realTextCount > 0) {
            let index = str.index(str.endIndex, offsetBy: offset)
            let substring = str.suffix(from: index)
            return String(substring)
        }
        return ""
    }
    
    private func setText() {
        let realTextCount = (formField.text?.count ?? 0) - prefixText.count
        let offset = 0 - realTextCount
        let str = formField.text!
        if (realTextCount > 0) {
            let index = str.index(str.endIndex, offsetBy: offset)
            let substring = str.suffix(from: index)
            formField.text = prefixText + substring
        } else {
            formField.text = prefixText
        }
    }
    
    open func setFormError(errorHint: String) {
        self.setState(state: UIFormDefaultField.FormState.error)
        self.setFieldHint(hint: errorHint)
        self.toggleHint(show: true)
    }
    
    open func setFormNormal(hint: String? = nil) {
        self.setState(state: UIFormDefaultField.FormState.normal)
        if (hint != nil) {
            self.setFieldHint(hint: hint!)
            self.toggleHint(show: true)
        } else {
            self.setFieldHint(hint: "")
            self.toggleHint(show: false)
        }
    }
}

extension UIFormDefaultField : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
    @IBAction func editingDidEnd(_ sender: Any) {
        setText()
    }
    @IBAction func editingChanged(_ sender: Any) {
        setText()
    }
    @IBAction func editingDidBegin(_ sender: Any) {
        setText()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if (format == .npwp){
            // When you start editing check if there is nothing, in that case add the entire mask
            if let text = textField.text, text == "" || text == "__.___.___._-___.___" {
                textField.text = "__.___.___._-___.___"//= "__.___.___._-___.___"
                textField.textColor = .lightGray
                textField.setCursor(position: text.count)
            }
        } else if (format == .rtrw){
            // When you start editing check if there is nothing, in that case add the entire mask
            if let text = textField.text, text == "" || text == "___/___" {
                textField.text = "___.___."
                textField.textColor = .lightGray
                textField.setCursor(position: text.count)
            }
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
            textField.textColor = .black
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (format == .npwp){
            guard var number = textField.text else {
                return true
            }
            // If user try to delete, remove the char manually
            if string == "" {
                number.remove(at: number.index(number.startIndex, offsetBy: range.location))
            }
            // Remove all mask characters
            number = number.replacingOccurrences(of: "-", with: "")
            number = number.replacingOccurrences(of: ".", with: "")
            number = number.replacingOccurrences(of: "_", with: "")

            // Set the position of the cursor
            var cursorPosition = number.count+1
            if string == "" {
                //if it's delete, just take the position given by the delegate
                cursorPosition = range.location
            } else {
                // If not, take into account the slash
                if cursorPosition > 2 && cursorPosition < 6 {
                    cursorPosition += 1
                } else if cursorPosition > 5 && cursorPosition < 9 {
                    cursorPosition += 2
                } else if cursorPosition > 8 && cursorPosition < 10 {
                    cursorPosition += 3
                } else if cursorPosition > 9 && cursorPosition < 13{
                    cursorPosition += 4
                } else if cursorPosition > 12 {
                    cursorPosition += 5
                }
            }
            // Stop editing if we have rich the max numbers
            if number.count == 15 { return false }
            // Readd all mask char
            number += string
            while number.count < 15 {
                if number.count < 2 {
                    number += "_"
                } else if number.count < 5 {
                    number += "_"
                } else if number.count < 8 {
                    number += "_"
                } else if number.count < 9 {
                    number += "_"
                } else if number.count < 12 {
                    number += "_"
                } else {
                    number += "_"
                }
            }
            number.insert(".", at: number.index(number.startIndex, offsetBy: 12))
            number.insert("-", at: number.index(number.startIndex, offsetBy: 9))
            number.insert(".", at: number.index(number.startIndex, offsetBy: 8))
            number.insert(".", at: number.index(number.startIndex, offsetBy: 5))
            number.insert(".", at: number.index(number.startIndex, offsetBy: 2))

            // Some styling
            let enteredTextAttribute = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)]
            let maskTextAttribute = [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)]

            let partOne = NSMutableAttributedString(string: String(number.prefix(cursorPosition)), attributes: enteredTextAttribute)
            let partTwo = NSMutableAttributedString(string: String(number.suffix(number.count-cursorPosition)), attributes: maskTextAttribute)

            let combination = NSMutableAttributedString()

            combination.append(partOne)
            combination.append(partTwo)

            textField.attributedText = combination
            textField.setCursor(position: cursorPosition)

            textField.sendActions(for: .editingChanged)
            
            return false
        }else if (format == .rtrw){
            guard var number = textField.text else {
                return true
            }
            // If user try to delete, remove the char manually
            if string == "" {
                number.remove(at: number.index(number.startIndex, offsetBy: range.location))
            }
            // Remove all mask characters
            number = number.replacingOccurrences(of: "/", with: "")
            number = number.replacingOccurrences(of: "_", with: "")

            // Set the position of the cursor
            var cursorPosition = number.count+1
            if string == "" {
                //if it's delete, just take the position given by the delegate
                cursorPosition = range.location
            } else {
                // If not, take into account the slash
                if cursorPosition > 3 && cursorPosition < 7 {
                    cursorPosition += 1
                } else if cursorPosition > 6{
                    cursorPosition += 2
                }
            }
            // Stop editing if we have rich the max numbers
            if number.count == 15 { return false }
            // Readd all mask char
            number += string
            while number.count < 15 {
                if number.count < 3 {
                    number += "_"
                } else {
                    number += "_"
                }
            }
            number.insert("/", at: number.index(number.startIndex, offsetBy: 6))
            number.insert("/", at: number.index(number.startIndex, offsetBy: 3))

            // Some styling
            let enteredTextAttribute = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)]
            let maskTextAttribute = [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)]

            let partOne = NSMutableAttributedString(string: String(number.prefix(cursorPosition)), attributes: enteredTextAttribute)
            let partTwo = NSMutableAttributedString(string: String(number.suffix(number.count-cursorPosition)), attributes: maskTextAttribute)

            let combination = NSMutableAttributedString()

            combination.append(partOne)
            combination.append(partTwo)

            textField.attributedText = combination
            textField.setCursor(position: cursorPosition)

            textField.sendActions(for: .editingChanged)

            return false
        }else{
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            if (maxLength == nil){
                return true
            }else{
                return newString.length <= maxLength!
            }
        }
    }
}

extension UITextField {
    func setCursor(position: Int) {
        let position = self.position(from: beginningOfDocument, offset: position)!
        selectedTextRange = textRange(from: position, to: position)
    }
    
    func addDoneCancelToolbar(onDone: (target: Any, action: Selector)? = nil, onCancel: (target: Any, action: Selector)? = nil) {
        let onCancel = onCancel ?? (target: self, action: #selector(cancelButtonTapped))
        let onDone = onDone ?? (target: self, action: #selector(doneButtonTapped))

        let toolbar: UIToolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.items = [
            UIBarButtonItem(title: "Cancel", style: .plain, target: onCancel.target, action: onCancel.action),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "Done", style: .done, target: onDone.target, action: onDone.action)
        ]
        toolbar.sizeToFit()

        self.inputAccessoryView = toolbar
    }

    // Default actions:
    @objc func doneButtonTapped() { self.resignFirstResponder() }
    @objc func cancelButtonTapped() { self.resignFirstResponder() }
}
