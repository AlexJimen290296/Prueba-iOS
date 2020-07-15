import UIKit

class MenuViewController: UIViewController {

    // MARK:- VARIABLES
    private let TAG: String = "MenuViewController.swift"
    private let nameImage: [String] = [
        "IconCamera",
        "IconImage",
        "IconName",
        "IconTelephone",
        "IconBirthday",
        "IconGender",
        "IconColor"
    ]
    private let nameOption: [String] = [
        "Cámara",
        "Foto",
        "Nombre completo",
        "Número telefónico",
        "Fecha de nacimiento",
        "Sexo(Masculino/Femenino)",
        "Color favorito"
    ]
    private var statusOption: [Bool] = [
        true,
        true,
        true,
        true,
        true,
        true,
        true
    ]
    // MARK:- IBOUTLETS
    @IBOutlet weak var tableViewOptions: UITableView!
    @IBOutlet weak var buttonContinuar: UIButton!
    // MARK:- LIFECYCLE VIEW CONTROLLER
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UI
        setupUI()
    }
    // MARK:- FUNCTIONS
    private func setupUI() {
        // Table view
        tableViewOptions.delegate = self
        tableViewOptions.dataSource = self
        
        // Button
        buttonContinuar.setBorderStyle()
    }
    
    private func showAlertWarning() {
        let alert = UIAlertController(title: "Menú", message: "Al menos se debe seleccionar una opción", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Entendido", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func verifySelectionOption() {
        var count: Int = 0
        for index in statusOption {
            if index == false {
                count = count + 1
            }
        }
        if count > 0 {
            print(TAG, "verifySelectionOption() --> Cambiar vista")
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let opcionesActivasViewController = storyBoard.instantiateViewController(identifier: "IDOpcionesActivas") as? OpcionesActivasViewController
            self.navigationController?.pushViewController(opcionesActivasViewController!, animated: true)
            //performSegue(withIdentifier: "segueCapturar", sender: self)
        } else {
            showAlertWarning()
        }
    }
    
    // MARK:- IBACTIONS
    @IBAction func listenerButtonContinuar(_ sender: UIButton) {
        verifySelectionOption()
    }
    

}

extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let sizeTableView = tableView.frame.size
        return sizeTableView.height / 7
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameOption.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let customCell = tableView.dequeueReusableCell(withIdentifier: "menuCustomCell", for: indexPath) as! MenuCustomCell
        customCell.selectionStyle = .none
        customCell.imageViewAvatar.image = UIImage(named: nameImage[indexPath.row])
        customCell.imageViewAvatar.contentMode = .scaleAspectFit
        customCell.labelNameOption.text = nameOption[indexPath.row]
        customCell.labelNameOption.textColor = UIColor(named: "PrimaryViewsColor")
        customCell.imageViewCheck.image = UIImage(named: "IconCheck")
        customCell.imageViewCheck.isHidden = statusOption[indexPath.row]
        return customCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentIndex = indexPath.row
        let currentCell = tableView.cellForRow(at: indexPath) as! MenuCustomCell
        if currentCell.imageViewCheck.isHidden {
            currentCell.imageViewCheck.isHidden = false
            statusOption[currentIndex] = false
        } else {
            currentCell.imageViewCheck.isHidden = true
            statusOption[currentIndex] = true
        }
    }
}
