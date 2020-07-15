import UIKit

class OpcionesActivasViewController: UIViewController {

    // MARK:- VARIABLES
    private let TAG: String = "OpcionesActivasViewController.swift"
    private let nameSection: [String] = [
        "Cámara",
        "Foto",
        "Nombre Completo",
        "Número Telefónico",
        "Fecha de Nacimiento",
        "Sexo",
        "Color Favorito"
    ]
    private let nameGender: [String] = [
        "Masculino",
        "Femenino"
    ]
    private var statusGender: [Bool] = [
        false,
        false
    ]
    private let nameImageGender: [String] = [
        "IconMale",
        "IconFemale"
    ]
    private let nameFavoriteColor: [String] = [
        "ColorFavoriteBlue",
        "ColorFavoriteGreen",
        "ColorFavoriteOrange",
        "ColorFavoritePurple",
        "ColorFavoriteRed"
    ]
    private var statusFavoriteColor: [Bool] = [
        true,
        true,
        true,
        true,
        true
    ]
    // MARK:- IBOUTLETS
    @IBOutlet weak var tableViewOptions: UITableView!
    
    // MARK:- VIEW
    private let datePicker: UIDatePicker = UIDatePicker()
    private var textFieldBirthdayAux: UITextField?
    private var imageAux: UIImage?
    private var imageCameraAux: UIImage?
    
    // MARK:- LIFECYCLE VIEWCONTROLLER
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
        
        // Image Aux
        loadImageToURL(urlImage: "https://images6.alphacoders.com/593/593473.png")
    }
    
    func loadImageToURL(urlImage:String) {
        guard let url = URL(string: urlImage) else {return}
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.imageAux = image
                    }
                }
            }
        }
    }
    
    // MARK:- SELECTORS
    @objc func donePicker() {
        textFieldBirthdayAux!.text = ""
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        dateFormatter.dateFormat = "dd/MM/yyyy"
        textFieldBirthdayAux!.text = dateFormatter.string(from: datePicker.date )
        textFieldBirthdayAux!.resignFirstResponder()
    }
    
    // MARK:- IBACTIONS
    @IBAction func listenerBarButtonBack(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension OpcionesActivasViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return nameSection.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return nameSection[section]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let header = nameSection[indexPath.section]
        switch header {
        case "Cámara":
            return 250
        case "Foto":
            return 250
        case "Nombre Completo":
            return 100
        case "Número Telefónico":
            return 100
        case "Fecha de Nacimiento":
            return 100
        case "Sexo":
            return 75
        case "Color Favorito":
            return 75
        default:
            return 50
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let header = nameSection[section]
        if header == "Cámara" {
            return 1
        } else if header == "Foto" {
            return 1
        } else if header == "Nombre Completo" {
            return 1
        } else if header == "Número Telefónico" {
            return 1
        } else if header == "Fecha de Nacimiento" {
            return 1
        } else if header == "Sexo" {
            return 2
        } else if header == "Color Favorito" {
            return 5
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let header = nameSection[indexPath.section]
        switch header {
        case "Cámara":
            let cameraCell = tableView.dequeueReusableCell(withIdentifier: "cameraCustomCell", for: indexPath) as! CameraCustomCell
            cameraCell.imageViewCamera.image = UIImage(named: "IconSelect")
            if imageCameraAux != nil {
                cameraCell.imageViewCamera.image = imageCameraAux
            }
            //self.imageViewCameraAux = cameraCell.imageViewCamera
            return cameraCell
        case "Foto" :
            let imageCell = tableView.dequeueReusableCell(withIdentifier: "imageCustomCell", for: indexPath) as! ImageCustomCell
            imageCell.imageViewImage.image = imageAux
            imageCell.contentMode = .scaleAspectFit
            return imageCell
        case "Nombre Completo":
            let nameCell = tableView.dequeueReusableCell(withIdentifier: "nameCustomCell", for: indexPath) as! NameCustomCell
            nameCell.textFieldName.delegate = self
            return nameCell
        case "Número Telefónico":
            let telephoneCell = tableView.dequeueReusableCell(withIdentifier: "telephoneCustomCell", for: indexPath) as! TelephoneCustomCell
            telephoneCell.textFieldTelephone.addDoneCancelToolbar()
            return telephoneCell
        case "Fecha de Nacimiento":
            let birthdayCell = tableView.dequeueReusableCell(withIdentifier: "birthdayCustomCell", for: indexPath) as! BirthdayCustomCell
            textFieldBirthdayAux = birthdayCell.textFieldBirthday
            let toolbar: UIToolbar = UIToolbar()
            toolbar.sizeToFit()
            let buttonAceptar = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePicker))
            toolbar.setItems([buttonAceptar], animated: true)
            birthdayCell.textFieldBirthday.inputAccessoryView = toolbar
            birthdayCell.textFieldBirthday.inputView = datePicker
            datePicker.datePickerMode = .date
            return birthdayCell
        case "Sexo":
            let genderCell = tableView.dequeueReusableCell(withIdentifier: "maleCustomCell", for: indexPath) as! GenderCustomCell
            genderCell.imageViewAvatar.image = UIImage(named: nameImageGender[indexPath.row])
            genderCell.labelGender.text = nameGender[indexPath.row]
            genderCell.labelGender.textColor = UIColor(named: "ColorPrimaryDark")
            return genderCell
        case "Color Favorito":
            let colorCustomCell = tableView.dequeueReusableCell(withIdentifier: "colorOneCustomCell", for: indexPath) as! ColorCustomCell
            colorCustomCell.backgroundColor = UIColor(named: nameFavoriteColor[indexPath.row])
            colorCustomCell.imageViewCheck.image = UIImage(named: "IconCheck")
            colorCustomCell.imageViewCheck.isHidden = statusFavoriteColor[indexPath.row]
            return colorCustomCell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let header = nameSection[indexPath.section]
        switch header {
        case "Cámara":
            //let currentCell = tableView.cellForRow(at: indexPath) as! CameraCustomCell
            //currentCell.imageViewCamera.image = imageCameraAux?
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true, completion: nil)
            } else {
                print(TAG, "No se puede acceder a la camara")
            }
        case "Sexo":
            if nameGender[indexPath.row] == "Masculino" {
                if statusGender[indexPath.row] == false {
                    let currentCell = tableView.cellForRow(at: indexPath) as! GenderCustomCell
                    currentCell.backgroundColor = UIColor(named: "ColorMale")
                    statusGender[indexPath.row] = true
                    tableView.reloadData()
                } else if statusGender[indexPath.row] == true {
                    let currentCell = tableView.cellForRow(at: indexPath) as! GenderCustomCell
                    currentCell.backgroundColor = UIColor.clear
                    statusGender[indexPath.row] = false
                    tableView.reloadData()
                }
            } else if nameGender[indexPath.row] == "Femenino" {
                if statusGender[indexPath.row] == false {
                    let currentCell = tableView.cellForRow(at: indexPath) as! GenderCustomCell
                    currentCell.backgroundColor = UIColor(named: "ColorFemale")
                    statusGender[indexPath.row] = true
                    tableView.reloadData()
                } else if statusGender[indexPath.row] == true {
                    let currentCell = tableView.cellForRow(at: indexPath) as! GenderCustomCell
                    currentCell.backgroundColor = UIColor.clear
                    statusGender[indexPath.row] = false
                    tableView.reloadData()
                }
            }
        case "Color Favorito":
            let currentIndex = indexPath.row
            let currentCell = tableView.cellForRow(at: indexPath) as! ColorCustomCell
            if currentCell.imageViewCheck.isHidden {
                currentCell.imageViewCheck.isHidden = false
                statusFavoriteColor[currentIndex] = false
            } else {
                currentCell.imageViewCheck.isHidden = true
                statusFavoriteColor[currentIndex] = true
            }
        default:
            print(TAG, "No se selecciono nada")
        }
    }
}

extension OpcionesActivasViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}

extension OpcionesActivasViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            //self.image!.contentMode = .scaleAspectFit
            //self.imageViewCameraAux!.image = pickedImage
            self.imageCameraAux = pickedImage
        }
        picker.dismiss(animated: true, completion: nil)
        tableViewOptions.reloadData()
    }
}
