//
//  ViewController.swift
//  xml-tutorial
//
//  Created by Glenn Adams on 9/6/24.
//

import UIKit
struct Snippet {
    var Id:String="" //IDECodeSnippetIdentifier
    var title:String=""  //IDECodeSnippetTitle
    var summary:String="" //IDECodeSnippetSummary
    var completionPrefix:String="" //IDECodeSnippetCompletionPrefix
    var contents:String="" //IDECodeSnippetContents
    var language:String="" //IDECodeSnippetLanguage
}


class ViewController: UIViewController {
    var masterIndex = 0
    let START_OF_PAIRS:String = "<dict>"
    let END_OF_PAIRS:String = "</dict>"
    let START_OF_STRING_TAG = "<string>"
    let END_OF_STRING_TAG = "</string>"
    var snippet = Snippet()
    let keys:[String] = [
        "IDECodeSnippetIdentifier",
        "IDECodeSnippetTitle",
        "IDECodeSnippetSummary",
        "IDECodeSnippetCompletionPrefix",
        "IDECodeSnippetContents",
        "IDECodeSnippetLanguage"
    ]
    
    var snippets:[Snippet]=[]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        // Do any additional setup after loading the view.
        setupUI()
    }
    func setupUI() {
        view.addSubview(readButton)
        readButton.frame = CGRect(x: 100, y: 100, width: 100, height: 100)

    }

    //FIXME: Uncomment and put in view did load if needed
    //UILabel.appearance(whenContainedInInstancesOf:[UINavigationBar.self ]).adjustsFontSizeToFitWidth=true
    
    lazy var readButton:UIButton = {  //snip zxuibtnl
        let ui = UIButton(type: .system)
        ui.setTitle("Read", for: .normal)
        ui.titleLabel?.font = .systemFont(ofSize: 20)
        ui.setTitleColor(UIColor.white, for: UIControl.State.normal)
        ui.backgroundColor = UIColor.orange
        ui.layer.borderWidth = 1
        ui.layer.cornerRadius = 16
        ui.addTarget(self, action: #selector(readButtonTouchSelector), for: .touchUpInside)
        return ui
    }()
    @objc fileprivate func readButtonTouchSelector(sender:Any) {
       
        let fileName = "test"
        guard
            let fileDescriptor = Bundle.main.url(forResource: "test", withExtension: "txt")
        else {
            print("cant build descriptor" )
            return
        }
        var snippetsSaved = 0

        do {
            let contents = try String(contentsOf: fileDescriptor,encoding: String.Encoding.utf8)
//print(contents)
            var lines = contents.components(separatedBy: "\n")
            print(lines.count)
            let max = lines.count - 1
            for masterIndex in 0...max {
                let rawLine = lines[masterIndex]
                let trimmedLine = rawLine.trimmingCharacters(in: .whitespaces)
                switch trimmedLine {
                    case "<key>IDECodeSnippetIdentifier</key>":
                        processId(trimmedLine, masterIndex, lines)
                    case "<key>IDECodeSnippetTitle</key>":
                        processTitle( trimmedLine, masterIndex, lines)
                    case "<key>IDECodeSnippetSummary</key>":
                        processSummary(trimmedLine, masterIndex, lines)
                    case "<key>IDECodeSnippetCompletionPrefix</key>":
                        processPrefix(trimmedLine, masterIndex, lines)
                    case "<key>IDECodeSnippetContents</key>":
                        processContents(trimmedLine, masterIndex, lines)
                    case "<key>IDECodeSnippetLanguage</key>":
                    
                        processLanguage(trimmedLine, masterIndex, lines )
                    default: break
            
                }
                
                if trimmedLine == END_OF_PAIRS {
                    print("==============E N D  O F  SNIPPET =========")
                    #warning("save the snippet here")
                    snippetsSaved+=1
                    
                }
            }
            
        } catch let err {
            print("Error: \(err)")
        }
      
        print("*** END OF JOB: \(snippetsSaved) snippets saved.")
    }
    
    func createSnippet() -> Snippet {
        
        return Snippet(Id:"", title: "", summary: "", completionPrefix: "", contents: "", language: "")
    }
    
    func processTitle(_ line:String , _ index:Int , _ lines: [String]) {
        print("title is in : ")
        var indexOfValue = index + 1
        print(lines[indexOfValue])
        var value = lines[indexOfValue]
       var editedValue = value.replacingOccurrences(of: END_OF_STRING_TAG, with: "")
        print(editedValue)
       var finalValue = editedValue.replacingOccurrences(of: START_OF_STRING_TAG, with: "")
       print(finalValue)
        snippet.title = finalValue
        print(snippet.title)
    }
    func stripTags(_ value :String) -> String {
        var editedValue = value.replacingOccurrences(of: END_OF_STRING_TAG, with: "")
        var finalValue = editedValue.replacingOccurrences(of: START_OF_STRING_TAG, with: "")
        return finalValue
    }
    func processId(_ line:String , _ index:Int, _ lines: [String]) {
        print("Id")
        var indexOfValue = index + 1
        print(lines[indexOfValue])
    }
    
    func processSummary(_ line:String ,_ index:Int, _ lines: [String]) {
        print("Summary")
        var indexOfValue = index + 1
        print(lines[indexOfValue])
    }
    func processPrefix(_ line:String , _ index:Int, _ lines: [String]) {
        print("Prefix")
        var indexOfValue = index + 1
        print(lines[indexOfValue])
    }
    func processContents(_ line:String, _ index:Int , _ lines: [String]) {
        print("Contents:")
        var indexOfValue = index + 1
        print(lines[indexOfValue])
    }
    func processLanguage(_ line:String , _ index:Int, _ lines: [String]) {
        print("Language")
        var indexOfValue = index + 1
        print(lines[indexOfValue])
    }
    
    lazy var myLabel:UILabel = {
        let ui = UILabel()
        ui.text = "file data"
        ui.font = UIFont.systemFont(ofSize: 20)
        ui.textColor = UIColor.black
        ui.backgroundColor = UIColor.white
        ui.numberOfLines = 1
        return ui
    }()

}

