import UIKit

enum CustomTextFieldType {
    case normal
    case cellphone
    case cnpj
}

final class CustomTextFieldView: UIView {

    private let titleLabel: UILabel = {
        let label = UILabel()
//        label.font = Fonts.titleSmall()
        label.textColor = Colors.textHeading
        return label
    }()

    private let textField: UITextField = {
        let field = UITextField()
        field.backgroundColor = Colors.backgroundTertiary
        field.textColor = Colors.textLabel
//        field.font = Fonts.paragraphMedium()
        field.layer.cornerRadius = 8
        field.layer.borderWidth = 1
        field.layer.borderColor = Colors.borderPrimary.cgColor
        field.setLeftPaddingPoints(12)
        return field
    }()

    private let type: CustomTextFieldType

    init(title: String, placeholder: String, type: CustomTextFieldType = .normal) {
        self.type = type
        super.init(frame: .zero)
        titleLabel.text = title
        setupView(placeholder: placeholder)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView(placeholder: String) {
        addSubview(titleLabel)
        addSubview(textField)

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),

            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor),
            textField.heightAnchor.constraint(equalToConstant: 39),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [
                .foregroundColor: Colors.textPlaceholder/*,*/
//                .font: Fonts.paragraphSmall()
            ]
        )

        textField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }

    @objc private func textDidChange() {
        switch type {
        case .cellphone:
            formatPhoneNumber()
        case .cnpj:
            formatCNPJ()
        case .normal:
            break
        }
    }

    private func formatPhoneNumber() {
        guard let text = textField.text else { return }
        let cleanPhoneNumber = text.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        let mask = "(##) #####-####"
        textField.text = applyMask(mask: mask, to: cleanPhoneNumber)
    }

    private func formatCNPJ() {
        guard let text = textField.text else { return }
        let cleanCNPJ = text.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        let mask = "##.###.###/####-##"
        textField.text = applyMask(mask: mask, to: cleanCNPJ)
    }

    private func applyMask(mask: String, to value: String) -> String {
        var result = ""
        var index = value.startIndex
        for ch in mask where index < value.endIndex {
            if ch == "#" {
                result.append(value[index])
                index = value.index(after: index)
            } else {
                result.append(ch)
            }
        }
        return result
    }
}

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}
