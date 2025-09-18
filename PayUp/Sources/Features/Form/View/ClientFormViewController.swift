//
//  ClientFormViewController.swift
//  PayUp
//
//  Created by Mateus Henrique Coelho de Paulo on 29/06/25.
//

import UIKit

final class ClientFormViewController: UIViewController {
    private let mode: ClientFormMode
    private let viewModel = ClientFormViewModel()
    private var hasInitializedPosition = false
    private lazy var contentView = ClientFormView(mode: mode)
    
    init(mode: ClientFormMode) {
        self.mode = mode
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .overFullScreen
        modalTransitionStyle = .coverVertical
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.delegate = self
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard !hasInitializedPosition else { return }
        
        hasInitializedPosition = true
        contentView.containerView.transform = CGAffineTransform(translationX: 0,
                                                                y: contentView.containerView.bounds.height)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.3) {
            self.contentView.containerView.transform = .identity
        }
    }
    
}

extension ClientFormViewController: ClientFormViewDelegate {
    func didTapCancel() {
        dismiss(animated: true)
    }
    
    func didTapSave() {
        guard let client = contentView.getClientData() else {
            showAlert(title: "ERRO", message: "Dados inserios invalidos. Verifique os campos e tente novamente")
            return
        }
        
        let success = viewModel.saveClient(client: client)
       
        if success {
            NotificationCenter.default.post(name: .clientDataChanged, object: nil)
            dismiss(animated: true)
        } else {
            showAlert(title: "Erro", message: "Nao foi possivel salvar o cliente, erro ao inserir no banco de dados")
        }
    }
    
    func didTapDelete() {
        let alert = UIAlertController(title: "Excluir cliente",
                                      message: "Tem certeza que deseja excluir este cliente?",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel))
        alert.addAction(UIAlertAction(title: "Excluir", style: .destructive) { _ in
            guard case .edit(let client) = self.mode,
                  let clientId = client.id else {
                self.showAlert(title: "Erro", message: "Não foi possível identificar o cliente para exclusão")
                return
            }
            
            let success = self.viewModel.deleteClient(by: clientId)
            if success {
                NotificationCenter.default.post(name: .clientDataChanged, object: nil)
                self.dismiss(animated: true)
            } else {
                self.showAlert(title: "Erro", message: "Não foi possível excluir o cliente do banco de dados")
            }
        })
        present(alert, animated: true)
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

extension Notification.Name {
    static let clientDataChanged = Notification.Name("clientDataChanged")
}
