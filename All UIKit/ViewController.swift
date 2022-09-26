
import UIKit

class ViewController: UIViewController {
    
    var textForPickerView = ["Hi !",
                             "Bye !",
                             "Hello !",
                             "Good bye !"]

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var labelForSegmentedControl: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var buttonForTextField: UIButton!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var labelForDatePicker: UILabel!
    @IBOutlet weak var fontSizeLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet var actionButtons: [UIButton]!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var switchLabel: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var progressView: UIProgressView!
    
    let fontSize = 17
    let fontName = "AcademyEngravedLetPlain"
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.isHidden = true
        textView.alpha = 0
        
        //self.view.isUserInteractionEnabled = false
        
        label.isHidden = true
        label.font = label.font.withSize(35)
        
        labelForSegmentedControl.isHidden = true
        labelForSegmentedControl.textAlignment = .center
        labelForSegmentedControl.font = label.font.withSize(40)
        labelForSegmentedControl.numberOfLines = 2
        
        segmentedControl.insertSegment(withTitle: "Third", at: 2, animated: true)
        
        slider.minimumValue = 1
        slider.maximumValue = 100
        slider.value = 50
        slider.minimumTrackTintColor = .blue
        slider.maximumTrackTintColor = .yellow
        slider.thumbTintColor = .black
        
        datePicker.preferredDatePickerStyle = .wheels
        
        pickerView.delegate = self
        
        for button in actionButtons {
            button.setTitleColor(.blue, for: .normal)
            button.backgroundColor = .green
        }
        
        button.isHidden = true
        button.setTitle("Clear", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.backgroundColor = .green
        
        textView.delegate = self
        textView.font = UIFont(name: fontName, size: CGFloat(fontSize))
        textView.backgroundColor = self.view.backgroundColor
        textView.layer.cornerRadius = 10
        
        stepper.value = Double(fontSize)
        stepper.minimumValue = 10
        stepper.maximumValue = 25
        stepper.tintColor = .white
        stepper.backgroundColor = .gray
        stepper.layer.cornerRadius = 10
        
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .gray
        activityIndicator.startAnimating()
        
        progressView.setProgress(0, animated: true)
        
        
        
        createToolBar()
        
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateTextView(notification:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)//наблюдатель за появлением клавиатуры
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateTextView(notification:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)//наблюдатель за скрытие клавиатуры
         
        UIView.animate(withDuration: 0, delay: 5, options: .curveEaseIn) {
            self.textView.alpha = 1
        } completion: { finished in
            self.activityIndicator.stopAnimating()
            self.textView.isHidden = false
            //self.view.isUserInteractionEnabled = true
        }

        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if self.progressView.progress != 1{
                self.progressView.progress += 0.2
            } else {
                self.progressView.isHidden = true
            }
        }
    }
    
    @objc func updateTextView(notification: Notification){
        
        guard
            let userInfo = notification.userInfo as? [String: Any],
            let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else
                { return } //получаем прямоугольные размеры клавиатуры
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            textView.contentInset = UIEdgeInsets.zero // растояние до нижней граници textView = 0
        } else {
            textView.contentInset = UIEdgeInsets(top: 0,
                                                 left: 0,
                                                 bottom: keyboardFrame.height - 300,
                                                 right: 0)//растояние до нижней граници textView = размер клавиатуры
            textView.scrollIndicatorInsets = textView.contentInset // сдвигаем индикатор прокрутки
        }
        //зона видимости скролинга
        textView.scrollRangeToVisible(textView.selectedRange)
        
    }
    
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        super.touchesBegan(touches, with: event)
//        self.view.endEditing(true)//скрытие клавиатуры вызванной любым обьектом
//       // textView.resignFirstResponder()//скрытие клавиатуры вызванна этим обьектом
//
//    }
    
    func createToolBar(){
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(dissmissKeyboard))
        toolBar.setItems([doneButton], animated: true)
        
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
        
        
    }
    
    @objc func dissmissKeyboard(){
        view.endEditing(true)
    }

    @IBAction func pressedButton(_ sender: UIButton) {
        label.isHidden = false
        button.isHidden = false
        if sender.tag == 0{
        print("dd")
            label.text = "Hello Word!"
            label.textColor = .red
        }else if sender.tag == 1{
            
            label.text = "Hi there!"
            label.textColor = . blue
        }else if sender.tag == 2{
            label.isHidden = true
            button.isHidden = true
        }
    }
    
    @IBAction func choiceSegment(_ sender: UISegmentedControl) {
        labelForSegmentedControl.isHidden = false
        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            labelForSegmentedControl.text = "The first segment is selected"
            labelForSegmentedControl.textColor = .red
        case 1:
            labelForSegmentedControl.text = "The second segment is selected"
            labelForSegmentedControl.textColor = .blue
        case 2:
            labelForSegmentedControl.text = "The third segment is selected"
            labelForSegmentedControl.textColor = .yellow
            
        default:
            break
        }
    }
    
    @IBAction func sliderAction(_ sender: UISlider) {
        labelForSegmentedControl.isHidden = false
        labelForSegmentedControl.alpha = CGFloat(slider.value / 100)
        labelForSegmentedControl.text = String(slider.value)
    }
    
    @IBAction func pressedButtonForTextField(_ sender: UIButton) {
        guard !textField.text!.isEmpty else {return}
        
        if let _ = Double(textField.text!) {
            let alert = UIAlertController(title: "Wrong format!", message: "Pleas enter your name", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default)
            alert.addAction(okAction)
            present(alert, animated: true)
        }else {
            label.isHidden = false
            label.text = textField.text
            textField.text = nil
        }
        
    }
    
    
    @IBAction func changeDate(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        dateFormatter.locale = Locale(identifier: "ru_RU")
        let dateValue = dateFormatter.string(from: sender.date)
        labelForDatePicker.text = dateValue
    }
    
    
    @IBAction func switchAction(_ sender: UISwitch) {
        
        datePicker.isHidden = !datePicker.isHidden
        
        if sender.isOn {
            switchLabel.text = "Скрыть дату!"
        }else {
            switchLabel.text = "Показать дату!"
        }
    }
    
    @IBAction func fontSize(_ sender: UIStepper) {
        let fontSize = CGFloat(sender.value)
        textView.font = UIFont(name: fontName, size: fontSize)
        
    }
    
}



extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return textForPickerView.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return textForPickerView[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        label.text = textForPickerView[row]
    }
}

extension ViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.backgroundColor = .white
        textView.textColor = .darkGray
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.backgroundColor = self.view.backgroundColor
        textView.textColor = .black
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        countLabel.text = "\(textView.text.count)"
        
        return true
    }
}
