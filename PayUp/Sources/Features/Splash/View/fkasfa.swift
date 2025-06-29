import UIKit

// ---------------------------------------------------
// Helper para descobrir o UIViewController de um UIView
// ---------------------------------------------------
fileprivate extension UIView {
    func parentViewController() -> UIViewController? {
        var responder: UIResponder? = self
        while let r = responder {
            if let vc = r as? UIViewController {
                return vc
            }
            responder = r.next
        }
        return nil
    }
}

// ---------------------------------------------------
// Model de modo do formulário
// ---------------------------------------------------
enum ClientFormMode {
    case add, edit
}

// ---------------------------------------------------
// ViewController do formulário (action-sheet que sobe)
// ---------------------------------------------------
final class ClientFormViewController: UIViewController {

    // MARK: – Configurações
    private let mode: ClientFormMode
    private var hasInitializedPosition = false

    init(mode: ClientFormMode) {
        self.mode = mode
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle   = .overFullScreen
        modalTransitionStyle     = .coverVertical
    }
    required init?(coder: NSCoder) { fatalError() }

    // MARK: – Container (sheet)
    private let containerView: UIView = {
        let v = UIView()
        v.backgroundColor   = Colors.backgroundPrimary
        v.layer.cornerRadius = 16
        v.clipsToBounds     = true
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    // “handle” superior
    private let handleBar: UIView = {
        let h = UIView()
        h.backgroundColor   = Colors.backgroundSecondary
        h.layer.cornerRadius = 2
        h.translatesAutoresizingMaskIntoConstraints = false
        return h
    }()

    // Título
    private lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text          = mode == .add ? "Adicionar cliente" : "Editar cliente"
        lbl.font          = Fonts.titleSmall()
        lbl.textColor     = .white
        return lbl
    }()

    // ---------------------------------------------------
    // Campos customizados
    // ---------------------------------------------------

    private lazy var valueField = CurrencyTextField(
        title: "Valor",
        placeholder: "R$ 0,00"
    )

    private lazy var dateField = DatePickerTextField(
        title: "Data de cobrança",
        placeholder: "DD/MM/AAAA"
    )

    private let recurLabel: UILabel = {
        let lbl = UILabel()
        lbl.text       = "Cobrança recorrente?"
        lbl.font       = Fonts.paragraphMedium()
        lbl.textColor  = Colors.textHeading
        return lbl
    }()

    private let recurSwitch: UISwitch = {
        let s = UISwitch()
        // track OFF
        s.onTintColor    = Colors.backgroundTertiary
        // knob
        s.thumbTintColor = Colors.accentBrand

        // escala para 31×16 a partir de 51×31
        let scaleX = 31.0 / 51.0
        let scaleY = 16.0 / 31.0
        s.transform = CGAffineTransform(scaleX: scaleX, y: scaleY)

        // Auto Layout
        s.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            s.widthAnchor.constraint(equalToConstant: 31),
            s.heightAnchor.constraint(equalToConstant: 16)
        ])

        return s
    }()

    private let periodButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Mensalmente ▾", for: .normal)
        btn.titleLabel?.font = Fonts.paragraphMedium()
        btn.setTitleColor(Colors.textHeading, for: .normal)
        btn.backgroundColor  = Colors.backgroundTertiary
        btn.layer.cornerRadius = 8
        btn.contentEdgeInsets = UIEdgeInsets(top: 2, left: 8, bottom: 2, right: 8)
        return btn
    }()

    private let divider: UIView = {
        let v = UIView()
        v.backgroundColor    = Colors.backgroundSecondary
        v.translatesAutoresizingMaskIntoConstraints = false
        v.heightAnchor.constraint(equalToConstant: 1).isActive = true
        return v
    }()

    private let nameField = InputTextFieldView(
        title: "Nome do cliente",
        placeholder: "Ex: João Silva | Loja do Bairro"
    )
    private let contactField = InputTextFieldView(
        title: "Contato",
        placeholder: "Ex: joao@exemplo.com"
    )
    private let phoneField = InputTextFieldView(
        title: "Telefone",
        placeholder: "Ex: (11) 91234-5678",
        type: .cellphone
    )
    private let cnpjField = InputTextFieldView(
        title: "CNPJ",
        placeholder: "Ex: 12.345.678/0001-90",
        type: .cnpj
    )
    private let addressField = InputTextFieldView(
        title: "Endereço",
        placeholder: "Ex: Rua das Flores, 123 – Centro, São Paulo – SP"
    )

    // ---------------------------------------------------
    // Ações inferiores
    // ---------------------------------------------------

    private let deleteButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: "trash.fill"), for: .normal)
        btn.tintColor = Colors.accentRed
        return btn
    }()

    private let cancelButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Cancelar", for: .normal)
        btn.titleLabel?.font = Fonts.paragraphMedium()
        btn.setTitleColor(Colors.textHeading, for: .normal)
        return btn
    }()

    private let saveButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Salvar alterações", for: .normal)
        btn.titleLabel?.font = Fonts.paragraphMedium()
        btn.setTitleColor(Colors.textInvert, for: .normal)
        btn.backgroundColor  = Colors.accentBrand
        btn.layer.cornerRadius = 8
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.widthAnchor.constraint(equalToConstant: 152).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return btn
    }()


    // MARK: – Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        setupLayout()
        bindActions()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // posiciona o sheet fora da tela (baixo) só uma vez
        guard !hasInitializedPosition else { return }
        hasInitializedPosition = true
        containerView.transform = CGAffineTransform(
            translationX: 0,
            y: containerView.bounds.height
        )
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // animação de subir
        UIView.animate(withDuration: 0.3) {
            self.containerView.transform = .identity
        }
    }

    // MARK: – Layout

    private func setupLayout() {
        view.addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            containerView.heightAnchor.constraint(
                equalTo: view.heightAnchor,
                multiplier: 0.9
            )
        ])

        // Top fields: Valor (211×43) e Data (120×43)
        let topFieldsStack = UIStackView(arrangedSubviews: [
            valueField, dateField
        ])
        topFieldsStack.axis    = .horizontal
        topFieldsStack.spacing = 16

        // Recorrência
        let recurStack = UIStackView(arrangedSubviews: [
            recurLabel, recurSwitch, UIView(), periodButton
        ])
        recurStack.axis      = .horizontal
        recurStack.alignment = .center

        // Ações do rodapé
        let actionsStack = UIStackView(arrangedSubviews: [
            mode == .edit ? deleteButton : UIView(),
            UIView(),
            cancelButton,
            saveButton
        ])
        actionsStack.axis      = .horizontal
        actionsStack.alignment = .center
        actionsStack.spacing   = 16

        // Stack principal
        let formStack = UIStackView(arrangedSubviews: [
            handleBar,
            titleLabel,
            topFieldsStack,
            recurStack,
            divider,
            nameField,
            contactField,
            phoneField,
            cnpjField,
            addressField,
            actionsStack
        ])
        formStack.axis                         = .vertical
        formStack.spacing                      = 16
        formStack.isLayoutMarginsRelativeArrangement = true
        formStack.layoutMargins                = UIEdgeInsets(
            top: 12, left: 24, bottom: 24, right: 24
        )
        formStack.translatesAutoresizingMaskIntoConstraints = false

        containerView.addSubview(formStack)
        NSLayoutConstraint.activate([
            formStack.topAnchor.constraint(equalTo: containerView.topAnchor),
            formStack.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            formStack.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            formStack.bottomAnchor.constraint(
                lessThanOrEqualTo: containerView.bottomAnchor
            )
        ])

        // handleBar
        NSLayoutConstraint.activate([
            handleBar.topAnchor.constraint(
                equalTo: formStack.layoutMarginsGuide.topAnchor
            ),
            handleBar.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            handleBar.widthAnchor.constraint(equalToConstant: 40),
            handleBar.heightAnchor.constraint(equalToConstant: 4)
        ])
    }

    // MARK: – Ações

    private func bindActions() {
        // Fechar
        cancelButton.addAction(.init(handler: { _ in
            UIView.animate(withDuration: 0.25, animations: {
                self.containerView.transform = CGAffineTransform(
                    translationX: 0,
                    y: self.containerView.bounds.height
                )
                self.view.backgroundColor = .clear
            }, completion: { _ in
                self.dismiss(animated: false)
            })
        }), for: .touchUpInside)

        // Periodicidade
        periodButton.addAction(.init(handler: { _ in
            let ac = UIAlertController(
                title: "Periodicidade",
                message: nil,
                preferredStyle: .actionSheet
            )
            ["Semanalmente","Mensalmente","Trimestralmente",
             "Semestralmente","Anualmente"].forEach { op in
                ac.addAction(.init(title: op, style: .default) { _ in
                    self.periodButton.setTitle("\(op) ▾", for: .normal)
                })
            }
            ac.addAction(.init(title: "Cancelar", style: .cancel))
            self.present(ac, animated: true)
        }), for: .touchUpInside)

        // Salvar
        saveButton.addAction(.init(handler: { _ in
            UIView.animate(withDuration: 0.25, animations: {
                self.containerView.transform = CGAffineTransform(
                    translationX: 0,
                    y: self.containerView.bounds.height
                )
                self.view.backgroundColor = .clear
            }, completion: { _ in
                self.dismiss(animated: false)
            })
        }), for: .touchUpInside)

        // Deletar (modo edit)
        if mode == .edit {
            deleteButton.addAction(.init(handler: { _ in
                // TODO: deletar cliente
            }), for: .touchUpInside)
        }
    }
}

// ---------------------------------------------------
// TextField com botão de moeda (com padding)
// ---------------------------------------------------
final class CurrencyTextField: UIView {
    private let titleLabel  = UILabel()
    private let textField   = UITextField()
    private let currencyBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("BRL ▾", for: .normal)
        btn.titleLabel?.font = Fonts.paragraphMedium()
        btn.setTitleColor(Colors.textLabel, for: .normal)
        return btn
    }()

    init(title: String, placeholder: String) {
        super.init(frame: .zero)
        // título
        titleLabel.text      = title
        titleLabel.font      = Fonts.titleSmall()
        titleLabel.textColor = Colors.textHeading

        // textField
        textField.backgroundColor = Colors.backgroundTertiary
        textField.layer.cornerRadius = 8
        textField.layer.borderWidth  = 1
        textField.layer.borderColor  = Colors.borderPrimary.cgColor
        textField.font               = Fonts.paragraphMedium()
        textField.textColor          = Colors.textLabel
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [.foregroundColor: Colors.textPlaceholder]
        )
        textField.setLeftPaddingPoints(12)
        // botão moeda à direita
        textField.rightView     = currencyBtn
        textField.rightViewMode = .always

        // layout vertical
        let stack = UIStackView(arrangedSubviews: [titleLabel, textField])
        stack.axis    = .vertical
        stack.spacing = 4

        addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor),

            textField.heightAnchor.constraint(equalToConstant: 43),
            textField.widthAnchor.constraint(equalToConstant: 211)
        ])
    }

    required init?(coder: NSCoder) { fatalError() }

    func getText() -> String? { textField.text }
    func setText(_ v: String) { textField.text = v }
}

// ---------------------------------------------------
// TextField que abre UIDatePicker “wheels”
// ---------------------------------------------------
final class DatePickerTextField: UIView {
    private let titleLabel  = UILabel()
    private let textField   = UITextField()
    private let calendarBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: "calendar"), for: .normal)
        btn.tintColor = Colors.textLabel
        btn.widthAnchor.constraint(equalToConstant: 24).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 24).isActive = true
        return btn
    }()

    init(title: String, placeholder: String) {
        super.init(frame: .zero)
        // título
        titleLabel.text      = title
        titleLabel.font      = Fonts.titleSmall()
        titleLabel.textColor = Colors.textHeading

        // textField
        textField.backgroundColor = Colors.backgroundTertiary
        textField.layer.cornerRadius = 8
        textField.layer.borderWidth  = 1
        textField.layer.borderColor  = Colors.borderPrimary.cgColor
        textField.font               = Fonts.paragraphMedium()
        textField.textColor          = Colors.textLabel
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [.foregroundColor: Colors.textPlaceholder]
        )
        textField.setLeftPaddingPoints(12)
        // botão calendário
        textField.rightView     = calendarBtn
        textField.rightViewMode = .always

        calendarBtn.addAction(.init(handler: { [weak self] _ in
            self?.presentDatePicker()
        }), for: .touchUpInside)

        // layout vertical
        let stack = UIStackView(arrangedSubviews: [titleLabel, textField])
        stack.axis    = .vertical
        stack.spacing = 4

        addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor),

            textField.heightAnchor.constraint(equalToConstant: 43),
            textField.widthAnchor.constraint(equalToConstant: 120)
        ])
    }

    required init?(coder: NSCoder) { fatalError() }

    private func presentDatePicker() {
        let alert = UIAlertController(
            title: "\n\n\n\n\n\n\n\n",
            message: nil,
            preferredStyle: .actionSheet
        )
        let picker = UIDatePicker()
        picker.datePickerMode          = .date
        picker.preferredDatePickerStyle = .wheels
        picker.translatesAutoresizingMaskIntoConstraints = false

        alert.view.addSubview(picker)
        NSLayoutConstraint.activate([
            picker.leadingAnchor.constraint(
                equalTo: alert.view.leadingAnchor, constant: 8
            ),
            picker.trailingAnchor.constraint(
                equalTo: alert.view.trailingAnchor, constant: -8
            ),
            picker.topAnchor.constraint(
                equalTo: alert.view.topAnchor, constant: 8
            ),
            picker.heightAnchor.constraint(equalToConstant: 200)
        ])

        alert.addAction(.init(title: "OK", style: .default) { _ in
            let df = DateFormatter()
            df.dateFormat = "dd/MM/yyyy"
            self.textField.text = df.string(from: picker.date)
        })
        alert.addAction(.init(title: "Cancelar", style: .cancel))

        if let vc = self.parentViewController() {
            vc.present(alert, animated: true)
        }
    }
}

final class SmallSwitch: UISwitch {
  override var intrinsicContentSize: CGSize {
    return CGSize(width: 31, height: 16)
  }
}
