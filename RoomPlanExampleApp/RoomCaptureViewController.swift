/*
See LICENSE folder for this sample’s licensing information.

Abstract:
The sample app's main view controller that manages the scanning process.
*/

import UIKit
import RoomPlan
import RealmSwift
import Foundation
class RoomCaptureViewController: UIViewController, RoomCaptureViewDelegate, RoomCaptureSessionDelegate {
    let realm = try! Realm()
    @IBOutlet var exportButton: UIButton?
    
    @IBOutlet var doneButton: UIBarButtonItem?
    @IBOutlet var cancelButton: UIBarButtonItem?
    
    private var isScanning: Bool = false
    
    private var roomCaptureView: RoomCaptureView!
    private var roomCaptureSessionConfig: RoomCaptureSession.Configuration = RoomCaptureSession.Configuration()
    
    private var finalResults: CapturedRoom?
    var allRooms: Results<Room>?
    var finalUrl: URL?
    var isExport = false
    
    // AlertTextFields
    var roomNameTextField: UITextField!
    var addressTextField: UITextField!
    var descriptionTextField: UITextField!
    var clientTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        print("its final result\n\n\n",finalUrl ?? "nil")
        // Set up after loading the view.
        setupRoomCaptureView()
    }
    
    private func setupRoomCaptureView() {
        roomCaptureView = RoomCaptureView(frame: view.bounds)
        roomCaptureView.captureSession.delegate = self
        roomCaptureView.delegate = self
        
        view.insertSubview(roomCaptureView, at: 0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startSession()
    }
    
    override func viewWillDisappear(_ flag: Bool) {
        super.viewWillDisappear(flag)
        stopSession()
    }
    
    private func startSession() {
        isScanning = true
        roomCaptureView?.captureSession.run(configuration: roomCaptureSessionConfig)
        
        setActiveNavBar()
    }
    
    private func stopSession() {
        isScanning = false
        roomCaptureView?.captureSession.stop()
        
        setCompleteNavBar()
    }
    
    // Decide to post-process and show the final results.
    func captureView(shouldPresent roomDataForProcessing: CapturedRoomData, error: Error?) -> Bool {
        return true
    }
    
    // Access the final post-processed results.
    func captureView(didPresent processedResult: CapturedRoom, error: Error?) {
        finalResults = processedResult
    }
    
    // Alert with information
    @IBAction func doneScanning(_ sender: UIBarButtonItem) {
        if isScanning { stopSession()
            doneButton?.title = "Add to gallery"
        } else if doneButton?.title == "Close" {
            cancelScanning(sender)
        } else {
            if isExport == false {
                let alertController = UIAlertController(title: "Warning", message: "You can add to gallery your scan only after export it!", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                alertController.addAction(cancelAction)
                present(alertController, animated: true, completion: nil)
            } else {
                let alertController = UIAlertController(title: "Enter information", message: nil, preferredStyle: .alert)
                alertController.addTextField { (textField) in
                    textField.placeholder = "Name"
                    self.roomNameTextField = textField
                }
                alertController.addTextField { (textField) in
                    textField.placeholder = "Client"
                    self.clientTextField = textField
                }
                alertController.addTextField { (textField) in
                    textField.placeholder = "Adress"
                    self.addressTextField = textField
                }
                alertController.addTextField { (textField) in
                    textField.placeholder = "Description"
                    self.descriptionTextField = textField
                }
                // Save data
                let doneAction = UIAlertAction(title: "Save", style: .default) { _ in
                    // Получаем значения из текстовых полей
                    if let roomName = self.roomNameTextField.text,
                       let address = self.addressTextField.text,
                       let description = self.descriptionTextField.text,
                       let client = self.clientTextField.text {
                        
                        rooms.roomName = roomName
                        rooms.adress = address
                        rooms.descriptionOfRoom = description
                        rooms.client = client
                        if let url = self.finalUrl {
                            let urlString = url.absoluteString
                            rooms.urlString = urlString
                            //print(rooms.urlString, "/n Hi Dasha/n/n")
                        }
                        let realm = try! Realm()
                        try! realm.write {
                            realm.add(rooms)
                        }
                    }
                    self.doneButton?.title = "Close"
                }
                
                
                alertController.addAction(doneAction)
                // Cancel action
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                alertController.addAction(cancelAction)
                
                // Показываем алерт контроллер
                present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func cancelScanning(_ sender: UIBarButtonItem) {
        navigationController?.dismiss(animated: true)
    }
    
    // Export the USDZ output by specifying the `.parametric` export option.
    // Alternatively, `.mesh` exports a nonparametric file and `.all`
    // exports both in a single USDZ.
        @IBAction func exportResults(_ sender: UIButton) {
            let destinationURL = FileManager.default.temporaryDirectory.appending(path: "Room.usdz")
                do {
                try finalResults?.export(to: destinationURL, exportOptions: .parametric)
    
                let activityVC = UIActivityViewController(activityItems: [destinationURL], applicationActivities: nil)
                activityVC.modalPresentationStyle = .popover
                    
                    activityVC.completionWithItemsHandler = { [weak self] activityType, completed, returnedItems, error in
                              guard let self = self else {
                                  return
                              }
                              
                              if completed {
                                  isExport = true
                                  finalUrl = destinationURL
                              } else {
                                  // Экспорт был отменен или произошла ошибка
                                  print("Экспорт файла был отменен или произошла ошибка.")
                                  if let error = error {
                                      print("Ошибка экспорта: \(error.localizedDescription)")
                                  }
                              }
                          }
                          
                           present(activityVC, animated: true, completion: nil)
                        if let popOver = activityVC.popoverPresentationController {
                    popOver.sourceView = self.exportButton
                }
    
            
    
    
            } catch {
                print("Error = \(error)")
            }
            
        }
    
           
    // Visual options
    
    private func setActiveNavBar() {
        UIView.animate(withDuration: 1.0, animations: {
            self.cancelButton?.tintColor = .white
            self.doneButton?.tintColor = .white
            self.exportButton?.alpha = 0.0
        }, completion: { complete in
            self.exportButton?.isHidden = true
        })
    }
    
    private func setCompleteNavBar() {
        self.exportButton?.isHidden = false
        UIView.animate(withDuration: 1.0) {
            self.cancelButton?.tintColor = .systemBlue
            self.doneButton?.tintColor = .systemBlue
            self.exportButton?.alpha = 1.0
        }
    }
}

