//
//  sendViewController.swift
//  supermarket
//
//  Created by apple on 2016/10/7.
//  Copyright © 2016年 zoujiahong. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher
import Firebase

class sendViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate{

    var nametextfield : UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "商品民称"
        textfield.layer.borderWidth = 1
        textfield.layer.borderColor = UIColor.lightGrayColor().CGColor
        return textfield
    }()
    var pricetextfield : UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "商品价格"
        textfield.layer.borderWidth = 1
        textfield.layer.borderColor = UIColor.lightGrayColor().CGColor
        return textfield
    }()
    var namelabel : UILabel = {
        let label = UILabel()
        label.text = "商品民称"
        return label
    }()
    var pricelabel : UILabel = {
        let label = UILabel()
        label.text = "商品价格"
        return label
    }()
    lazy var imageview : UIImageView = {
        let imageview = UIImageView()
        imageview.image = UIImage(named:"addimage")
        imageview.addGestureRecognizer(UITapGestureRecognizer(target: self,action:#selector(touchimage)))
        imageview.userInteractionEnabled = true
        return imageview
    }()
    lazy var sendbutton:UIButton = {
        let button = UIButton(type: .System)
        button.backgroundColor = UIColor.init(red: 119/255, green: 136/255, blue: 153/255, alpha: 1)
        button.setTitle("发布", forState: .Normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFontOfSize(16)
        button.layer.cornerRadius = 60
        button.layer.masksToBounds = true
        button.addTarget(self, action:#selector(sendthings), forControlEvents: .TouchUpInside)
        return button
    }()
    func sendthings(){
        let imagenName = NSUUID().UUIDString
        let storageref = FIRStorage.storage().reference().child("supermarket").child("\(imagenName).png")
        if let uploadData = UIImagePNGRepresentation(self.imageview.image!){
            storageref.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                if error != nil{
                    print(error)
                    return
                }
                if let salesimageurl = metadata?.downloadURL()?.absoluteString{
                    let name = self.nametextfield.text
                    let price = self.pricetextfield.text
                    let ref = FIRDatabase.database().reference().child("supermarket").childByAutoId()
                    let things :[String: AnyObject] = ["name":name!,
                        "price":price!,
                        "imageurl":salesimageurl]
                    ref.setValue(things)
                    self.navigationController?.popViewControllerAnimated(true)
                }
            })
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(imageview)
        self.view.addSubview(namelabel)
        self.view.addSubview(pricelabel)
        self.view.addSubview(nametextfield)
        self.view.addSubview(pricetextfield)
        self.view.addSubview(sendbutton)
        setupui()
    }
    func setupui(){
        namelabel.snp_makeConstraints { (make) in
            make.top.equalTo(self.view.snp_top).offset(100)
            make.left.equalTo(self.view.snp_left).offset(20)
            make.size.equalTo(CGSizeMake(100, 30))
        }
        pricelabel.snp_makeConstraints { (make) in
            make.top.equalTo(namelabel.snp_bottom).offset(20)
            make.left.equalTo(self.view.snp_left).offset(20)
            make.size.equalTo(CGSizeMake(100, 30))
        }
        nametextfield.snp_makeConstraints { (make) in
            make.top.equalTo(namelabel.snp_top)
            make.left.equalTo(namelabel.snp_right)
            make.size.equalTo(CGSizeMake(200, 30))
        }
        pricetextfield.snp_makeConstraints { (make) in
            make.top.equalTo(pricelabel.snp_top)
            make.left.equalTo(pricelabel.snp_right)
            make.size.equalTo(CGSizeMake(200, 30))
        }
        imageview.snp_makeConstraints { (make) in
            make.top.equalTo(pricelabel.snp_bottom).offset(20)
            make.left.equalTo(self.view.snp_left).offset(20)
            make.size.equalTo(CGSizeMake(80, 80))
        }
        sendbutton.snp_makeConstraints { (make) in
            make.centerX.equalTo(self.view.snp_centerX)
            make.top.equalTo(imageview.snp_bottom).offset(20)
            make.size.equalTo(CGSizeMake(120, 120))
        }

        

    }
    func touchimage(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        presentViewController(picker, animated: true, completion: nil)
    }
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        var selectedimagefromepicker : UIImage?
        if let editedimage = info["UIImagePickerControllerEditedImage"] as? UIImage{
            selectedimagefromepicker = editedimage
            
        }else if let orignalimage = info["UIImagePickerControllerOriginalImage"] as?UIImage{
            selectedimagefromepicker = orignalimage
        }
        if let selectedimage = selectedimagefromepicker{
            imageview.image = selectedimage
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }

   

}
