//
//  AutoQueryViewController.swift
//  AutoQueryViewer
//
//  Created by Demis Bellot on 2/15/15.
//  Copyright (c) 2015 ServiceStack LLC. All rights reserved.
//

import UIKit

struct ViewerStyles {
    static let maxFieldWidth:CGFloat = 250
    
    static let cellPadding:CGFloat = 12
    
    static let rowHeaderHeight:CGFloat = 36

    static let rowBodyHeight:CGFloat = 28
    
    static let cellFontSize:CGFloat = 17
}

class AutoQueryViewController: UIViewController, UITextFieldDelegate, MDSpreadViewDataSource, MDSpreadViewDelegate {
    
    @IBOutlet weak var imgBackground: UIImageView!
    @IBOutlet weak var txtSearchField: UITextField!
    @IBOutlet weak var txtSearchType: UITextField!
    @IBOutlet weak var txtSearchText: UITextField!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var btnViewCsv: UIButton!
    
    var selectedOperation:AutoQueryOperation!
    var response:AutoQueryMetadataResponse!
    var config:AutoQueryViewerConfig {
        return response.config!
    }
    
    var txtSearchFieldPicker:TextPickerDelegate!
    var txtSearchTypePicker:TextPickerDelegate!
    
    var mdView:MDSpreadView!
    
    var offset:Int = 0
    var total:Int = 0
    var results:NSArray = NSArray()
    var opType:MetadataType!
    var resultType:MetadataType!
    var resultProperties = [MetadataPropertyType]()
    var messageColor:UIColor = UIColor.blackColor()
    var errorMessageColor = UIColor.redColor()
    var columnWidths = [CGFloat]()
    var searchUrl:String?
    
    @IBAction func search() {
        if txtSearchField.text.trim().count == 0 || txtSearchType.text.trim().count == 0 || txtSearchText.text.trim().count == 0 {
            return
        }
        
        var client = JsonServiceClient(baseUrl: config.serviceBaseUrl!)
        
        let field = createAutoQueryParam(txtSearchField.text, txtSearchType.text)
        searchUrl = "/json/reply/\(selectedOperation.request!)"
                + "?\(field.urlEncode()!)=\(txtSearchText.text.trim().urlEncode()!)"

        setMessage(nil)
        spinner.startAnimating()
        txtSearchText.resignFirstResponder()
        
        client.getDataAsync(searchUrl!)
            .then(body:{ (r:NSData) -> AnyObject in
                self.spinner.stopAnimating()

                let json = r.toUtf8String()!
                if let map = parseJson(json) as? NSDictionary {
                    if let offset = map.getItem("Offset") as? NSInteger {
                        self.offset = offset
                    }
                    if let total = map.getItem("Total") as? NSInteger {
                        self.total = total
                    }
                    self.updateResults(map.getItem("Results") as? NSArray ?? NSArray())
                }
                return r
            })
            .catch(body:{ (e:NSError) -> Void in
                self.spinner.stopAnimating()
                self.setErrorMessage(e.responseStatus.message)
                self.results = NSArray()
            })
    }
    
    @IBAction func viewCsv() {
        if searchUrl != nil {
            if let absoluteUrl = NSURL(string:config.serviceBaseUrl!.combinePath(searchUrl!) + "&format=csv") {
                UIApplication.sharedApplication().openURL(absoluteUrl)
            }
        }
    }
    
    func updateResults(results:NSArray) {
        
        calculateColumnWidths(results)
        self.results = results
        
        switch results.count {
        case 0:
            setMessage("this search returned no results")
            mdView.hidden = true
            btnViewCsv.hidden = true
        case 1:
            mdView.hidden = false
            mdView.reloadData()
            setMessage("showing 1 result:")
        default:
            mdView.hidden = false
            mdView.reloadData()
            if results.count == total {
                setMessage("showing \(results.count) results:")
            }
            else {
                setMessage("showing \(offset+1) - \(offset+results.count) of \(total) results:")
            }
            saveDefaultSetting("searchText", txtSearchText.text)
        }
    }
    
    func calculateColumnWidths(results:NSArray) {
        columnWidths = resultProperties.map {
            ($0.name! as NSString).sizeWithAttributes([NSFontAttributeName: UIFont.systemFontOfSize(ViewerStyles.cellFontSize)]).width
        }
        for var row = 0; row<results.count; row++ {
            if let result = results[row] as? NSDictionary {
                for var column = 0; column<resultProperties.count; column++ {
                    var property = resultProperties[column]
                    if let value: AnyObject = result.getItem(property.name!) {
                        var string = "\(value)"
                        let font = UIFont.systemFontOfSize(ViewerStyles.cellFontSize)
                        var stringSize = (string as NSString).sizeWithAttributes([NSFontAttributeName: font])
                        
                        var columnWidth = columnWidths[column]
                        if stringSize.width > columnWidth {
                            columnWidths[column] = stringSize.width
                        }
                    }
                }
            }
        }
    }
    
    func setMessage(message:String?) {
        var hasMessage = (message ?? "").count > 0
        
        lblMessage.textColor = messageColor
        lblMessage.text = hasMessage
            ? (opType.getViewerAttrProperty("Title")?.value ?? opType.name!) + " - " + message!
            : message
        
        btnViewCsv.hidden = !hasMessage
    }
    
    func setErrorMessage(message:String?) {
        lblMessage.textColor = errorMessageColor
        lblMessage.text = message
    }
    
    func createAutoQueryParam(field:String, _ operand:String) -> String {
        let template = response.getQueryTypeTemplate(operand)!
        let mergedField = template.replace("%", withString:field)
        return mergedField
    }

    func textFieldShouldReturn(textField:UITextField) -> Bool {
        if textField == txtSearchText {
            search()
            return true
        }
        return false
    }
    
    func textFieldShouldBeginEditing(textField:UITextField) -> Bool {
        return textField == txtSearchText
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.stopAnimating()
        txtSearchText.delegate = self
        
        mdView = MDSpreadView(frame: CGRect(x: 0, y: 80, width: self.view.frame.width, height: self.view.frame.height - 80))
        mdView.backgroundColor = UIColor.clearColor()
        mdView.dataSource = self
        mdView.delegate = self
        mdView.hidden = true
        self.view.addSubview(mdView)
        
        opType = response.getType(selectedOperation.request)!
        resultType = response.getType(selectedOperation.to)!
        resultProperties = response.getProperties(resultType.name)
        loadStyle()
        
        var from = response.getType(selectedOperation.from)
        var fromFields = response.getProperties(from?.name).map { $0.name ?? "" }

        txtSearchFieldPicker = TextPickerDelegate(textField:txtSearchField, options:fromFields)
        txtSearchFieldPicker.onSelected = { self.txtSearchType.becomeFirstResponder() }
        txtSearchField.inputView = txtSearchFieldPicker.pickerFields

        var conventionNames = response.config?.implicitConventions.map { $0.name ?? "" } ?? [String]()
        txtSearchTypePicker = TextPickerDelegate(textField:txtSearchType, options:conventionNames)
        txtSearchTypePicker.onSelected = { self.txtSearchText.becomeFirstResponder() }
        txtSearchType.inputView = txtSearchTypePicker.pickerFields

        txtSearchField.text = opType.getViewerAttrProperty("DefaultSearchField")?.value
        txtSearchType.text = opType.getViewerAttrProperty("DefaultSearchType")?.value
        txtSearchText.text = opType.getViewerAttrProperty("DefaultSearchText")?.value ?? getDefaultSetting("searchText")
        txtSearchText.clearsOnBeginEditing = true
        
        search()
    }
    
    func loadStyle() {
        if let bgColor = opType.getViewerAttrProperty("BackgroundColor")?.value ?? config.backgroundColor {
            view.backgroundColor = UIColor(rgba: bgColor)
        }
        if let textColor = opType.getViewerAttrProperty("TextColor")?.value ?? config.textColor {
            messageColor = UIColor(rgba: textColor)
            spinner.color = messageColor
        }
        if let linkColor = opType.getViewerAttrProperty("LinkColor")?.value ?? config.linkColor {
            btnBack.setTitleColor(UIColor(rgba: linkColor), forState: .Normal)
            btnSearch.setTitleColor(UIColor(rgba: linkColor), forState: .Normal)
            btnViewCsv.setTitleColor(UIColor(rgba: linkColor), forState: .Normal)
        }
        if var brandImageUrl = opType.getViewerAttrProperty("BrandImageUrl")?.value ?? config.brandImageUrl {
            if brandImageUrl.hasPrefix("/") {
                brandImageUrl = config.serviceBaseUrl!.combinePath(brandImageUrl)
            }
            self.addBrandImage(brandImageUrl, action: "btnBrandGo:")
        }
        
        if var backgroundImageUrl = opType.getViewerAttrProperty("BackgroundImageUrl")?.value ?? config.backgroundImageUrl {
            if backgroundImageUrl.hasPrefix("/") {
                backgroundImageUrl = config.serviceBaseUrl!.combinePath(backgroundImageUrl)
            }
            self.imgBackground.loadAsync(backgroundImageUrl)
        }
    }
    
    func btnBrandGo(sender:UIButton!) {
        let brandUrl = opType.getViewerAttrProperty("brandUrl")?.value ?? config.brandUrl
        if brandUrl != nil {
            if let nsUrl = NSURL(string: brandUrl!) {
                UIApplication.sharedApplication().openURL(nsUrl)
            }
        }
    }
    
    @IBAction func unwindSegue(unwindSegue: UIStoryboardSegue) {
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    /* MDSpreadView */
    func numberOfRowSectionsInSpreadView(aSpreadView:MDSpreadView) -> NSInteger
    {
        return 1
    }
    
    func numberOfColumnSectionsInSpreadView(aSpreadView:MDSpreadView) -> NSInteger
    {
        return 1
    }
    
    func spreadView(aSpreadView:MDSpreadView, numberOfRowsInSection:NSInteger) -> NSInteger
    {
        return results.count
    }
    
    func spreadView(aSpreadView:MDSpreadView, numberOfColumnsInSection:NSInteger) -> NSInteger
    {
        return resultProperties.count
    }
    
    func spreadView(aSpreadView:MDSpreadView, objectValueForRowAtIndexPath rowPath:MDIndexPath, forColumnAtIndexPath columnPath:MDIndexPath) -> AnyObject
    {
        if let result = results[rowPath.row] as? NSDictionary {
            var property = resultProperties[columnPath.column]
            if let value: AnyObject = result.getItem(property.name!) {
                return value
            }
        }
        
        return ""
    }
    
    func spreadView(aSpreadView:MDSpreadView, titleForHeaderInColumnSection section:NSInteger, forRowAtIndexPath rowPath:MDIndexPath)  -> AnyObject
    {
        return "\(rowPath.row + 1)"
    }
    
    func spreadView( aSpreadView:MDSpreadView, titleForHeaderInRowSection section:NSInteger, forColumnAtIndexPath columnPath:MDIndexPath) -> AnyObject
    {
        var property = resultProperties[columnPath.column]
        return property.name ?? ""
    }
    
    func spreadView(aSpreadView:MDSpreadView, titleForHeaderInRowSection rowSection:NSInteger, forColumnSection columnSection:NSInteger) -> AnyObject
    {
        return ""
    }
    
    /* Display Customization */
    func spreadView(aSpreadView:MDSpreadView, heightForRowHeaderInSection rowSection:NSInteger) -> CGFloat
    {
        return ViewerStyles.rowHeaderHeight
    }
    
    func spreadView(aSpreadView:MDSpreadView, heightForRowAtIndexPath indexPath:MDIndexPath) -> CGFloat
    {
        return ViewerStyles.rowBodyHeight
    }
    
    func spreadView(aSpreadView:MDSpreadView, heightForRowFooterInSection rowSection:NSInteger) -> CGFloat
    {
        return 0
    }
    
    func spreadView(aSpreadView:MDSpreadView, widthForColumnHeaderInSection columnSection:NSInteger) -> CGFloat
    {
        return 50
    }
    
    func spreadView(aSpreadView:MDSpreadView, widthForColumnAtIndexPath indexPath:MDIndexPath) -> CGFloat
    {
        if columnWidths.count == 0 {
            return ViewerStyles.maxFieldWidth
        }
        var columnWidth = columnWidths[indexPath.column] + (ViewerStyles.cellPadding * 2)
        return columnWidth < ViewerStyles.maxFieldWidth ? columnWidth : ViewerStyles.maxFieldWidth
    }
    
    func spreadView(aSpreadView:MDSpreadView, widthForColumnFooterInSection columnSection:NSInteger) -> CGFloat
    {
        return 0
    }
}

class TextPickerDelegate : NSObject, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    var options:[String]
    var textField:UITextField
    var pickerFields:UIPickerView
    var onSelected:(() -> Any)?
    
    init(textField:UITextField, options:[String]) {
        self.textField = textField
        self.options = options
        pickerFields = UIPickerView()

        super.init()
        
        textField.text = options.first ?? ""
        textField.delegate = self
        pickerFields.delegate = self
        pickerFields.dataSource = self
    }
    
    func textFieldShouldEndEditing(textField:UITextField) -> Bool {
        return options.filter { $0 == textField.text }.count > 0
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return options.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return options[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        textField.text = options[row]
        textField.resignFirstResponder()
        
        if let fn = onSelected {
            fn()
        }
    }
}