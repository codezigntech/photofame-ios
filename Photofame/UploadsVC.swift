//
//  UploadsVC.swift
//  Photofame
//
//  Created by Appit on 6/25/17.
//  Copyright © 2017 Appit. All rights reserved.
//

import UIKit

class UploadsVC: UIViewController {

    
    // MARK: - Properties
    
//    var tagStrings = [String]()
//    var tags = [Tag]()
    var sizingCell: TagCell?
    var mediaDetailsArray = [MediaDetails]()
    var loadingCompleted: Bool = false
    
    // MARK: - Outlets
    @IBOutlet weak var uploadButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Actions
    
    @IBAction func uploadAction(_ sender: UIButton) {
        
        
        loadImagePickerController()
    }
    
    
    // MARK: - Override methods
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.uploadButton.layer.masksToBounds = true
        self.uploadButton.layer.cornerRadius = self.uploadButton.frame.height / 2.0
        
        
        // tableview Automatic height
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 44
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        
    }

    // MARK: -
    
    // show image picker
    
    func loadImagePickerController() {
        
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            print("Button capture")
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary;
            
            // clear array
            self.mediaDetailsArray = [MediaDetails]()
            
            DispatchQueue.main.async {
                self.present(imagePicker, animated: true, completion: nil)
            }
        }
        
    }
    
    
    func configureCollectionView(tabCell: UploadPhotoCell, row: Int) {
        
        
    }
    


}

extension UploadsVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mediaDetailsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let uploadCell = tableView.dequeueReusableCell(withIdentifier: "UploadPhotoCell") as! UploadPhotoCell
        
        let mediaDetails = mediaDetailsArray[indexPath.row]
        
        uploadCell.photoImageView.image = mediaDetails.image
        
        uploadCell.activityIndicator.startAnimating()
        uploadCell.activityIndicator.isHidden = false
        
        uploadCell.collectionView.dataSource = self
        uploadCell.collectionView.delegate = self
        
//        self.configureCollectionView(tabCell: uploadCell)
        
        let cellNib = UINib(nibName: "TagCell", bundle: nil)
        uploadCell.collectionView.register(cellNib, forCellWithReuseIdentifier: "TagCell")
        uploadCell.collectionView.backgroundColor = UIColor.clear
        self.sizingCell = (cellNib.instantiate(withOwner: nil, options: nil) as NSArray).firstObject as! TagCell?
        uploadCell.flowLayout.sectionInset = UIEdgeInsetsMake(0, 15, 0, 15)
//        for name in mediaDetails.tags {
//            let tag = Tag()
//            tag.name = name
//            self.tags.append(tag)
//        }
        
        
        
        if mediaDetails.tagsObjects.count > 0 {
            uploadCell.activityIndicator.stopAnimating()
        }
        
        DispatchQueue.main.async {
            uploadCell.collectionView.reloadData()
        }
        
        return uploadCell
    }
    
}

extension UploadsVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        dismiss(animated: true, completion: nil)
        
        if let pickedImage = info[UIImagePickerControllerReferenceURL] as? NSURL {
           
            let directoryPath =  NSHomeDirectory().appending("/Documents/")
            if !FileManager.default.fileExists(atPath: directoryPath) {
                do {
                    try FileManager.default.createDirectory(at: NSURL.fileURL(withPath: directoryPath), withIntermediateDirectories: true, attributes: nil)
                } catch {
                    print(error)
                }
            }
            let filename = "tempfile.jpg"
            let filepath = directoryPath.appending(filename)
            let url = NSURL.fileURL(withPath: filepath)
            
            let image = info[UIImagePickerControllerOriginalImage] as! UIImage
            
            // insert new row
            let mediaInfo = MediaDetails()
            mediaInfo.image = image
            mediaDetailsArray.append(mediaInfo)
            self.tableView.reloadData()
            // save data
            let data = UIImageJPEGRepresentation(image, 0.4)
            
            do {
                try data?.write(to: url)
            } catch {
                print(error)
            }
            
        
            let widthInPoints = image.size.width
            let widthInPixels = widthInPoints * image.scale
            
            let heightInPoints = image.size.height
            let heightInPixels = heightInPoints * image.scale
            
            
            let params = ["photo_grapher_id" : 1,
                          "file" : Upload(fileUrl: url),
                          "width": widthInPixels,
                          "height":heightInPixels,
                          "colour_string": "#040404",
                          "primary_colour": "#533242",
                          "background_colour": "#030303",
                          "location_id":1] as [String : Any]
            
            do {
                let opt = try HTTP.POST("http://api.photofame.online/uploadMedia", parameters: params)
                opt.start { response in
                    //do things...
                    
                    do {
                        let json = try JSONSerialization.jsonObject(with: response.data, options: .mutableContainers) as? NSDictionary
                        if let parseJSON = json {
                            print(parseJSON)
                            if let code = parseJSON["code"] as? Int {
                                
                                if code == 200 {
                                    
                                    self.loadingCompleted = true
                                    
                                    if let result = parseJSON["result"] as? [String: Any] {
                                        if let tags = result["tags"] as? [String] {
                                            
                                            
                                            
                                            for name in tags {
                                                let tag = Tag()
                                                tag.name = name
                                                mediaInfo.tagsObjects.append(tag)
                                            }
                                            
//                                            mediaInfo.tags = tags
                                            DispatchQueue.main.async {
                                                self.tableView.reloadData()
                                            }
                                        }
                                    }
                                }
                            }
                        }
//                        completion(nil)
                    } catch let error as NSError {
                        print(error)
//                        completion(nil)
                    }
                    
                }
            } catch let error {
                print("got an error creating the request: \(error)")
            }
            
        }

        
//        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
//            let imageData = UIImagePNGRepresentation(pickedImage)!
//            
//            let params = ["photo_grapher_id" : 1,
//                          "file" : imageData,
//                "width": 159,
//                "height":288,
//                "colour_string": "#040404",
//                "primary_colour": "#533242",
//                "background_colour": "#030303",
//                "location_id":1] as [String : Any]
//            
//            NetworkManager.uploadImageData(params: params, completion: { (result) in
//                print(result)
//            })
//        }
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
   
    
}

extension UploadsVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let mediaDetails = self.mediaDetailsArray[0]
        
        return mediaDetails.tagsObjects.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagCell", for: indexPath) as! TagCell
        self.configureCell(cell, forIndexPath: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        self.configureCell(self.sizingCell!, forIndexPath: indexPath)
        return self.sizingCell!.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
    }
    
    //    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    //        collectionView.deselectItem(at: indexPath, animated: false)
    //        tags[indexPath.row].selected = !tags[indexPath.row].selected
    //        self.collectionView.reloadData()
    //    }
    
    func configureCell(_ cell: TagCell, forIndexPath indexPath: IndexPath) {
        
        let mediaDetails = self.mediaDetailsArray[0]
        
        let tag = mediaDetails.tagsObjects[indexPath.row]
        
        cell.tagName.text = tag.name
        //        cell.tagName.textColor = tag.selected ? UIColor.white : UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
        //        cell.backgroundColor = tag.selected ? UIColor(red: 0, green: 1, blue: 0, alpha: 1) : UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
    }
    
    
}

