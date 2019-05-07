//
//  ExerciseViewController.swift
//  JavaTutor
//
//  Created by Sam Carlin on 4/27/19.
//  Copyright © 2019 Logan Stahl. All rights reserved.
//

import UIKit
import WebKit

class ExerciseVC: UIViewController, WKScriptMessageHandler {
    
    public var module : Int = 0

    @IBOutlet weak var webview: WKWebView!
    @IBOutlet weak var descriptionButton: UIBarButtonItem!
    
    private var sourceCode : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load HTML and Register Listeners
        let url = Bundle.main.url(forResource: "editor", withExtension: "html")!
        webview.loadFileURL(url, allowingReadAccessTo: url)
        let request = URLRequest(url: url)
        webview.load(request)
        
        webview.configuration.userContentController.add(self, name: "codeChanged")
        
        UIApplication.shared.sendAction(descriptionButton.action!, to: descriptionButton.target, from: self, for: nil)
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        // We either update our local code or send the initial template
        if (message.name == "codeChanged") {
            if let code = (message.body as AnyObject)["text"]! as? String {
                self.sourceCode = code
            } else {
                loadCode()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destVC = segue.destination as? ExerciseRunnerVC {
            destVC.sourceCode = sourceCode
            destVC.exercise = loadExercise(module: module)
        }
        
        if let destVC = segue.destination as? ExerciseDescriptionVC {
            destVC.exerciseVC = self
            destVC.exercise = loadExercise(module: module)
        }
    }
    
    public func loadCode() {
        let code = "window.setCode(`\(loadExercise(module: module)!.initial)`)"
        webview.evaluateJavaScript(code, completionHandler: nil)
    }
    
    func loadExercise(module: Int) -> Exercise? {
        if let path = Bundle.main.path(forResource: "exercises", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
            
                let exercises = (jsonResult as! [[String: Any]]).map({ item in Exercise(item) })
                
                return exercises[module]
            } catch {
                print("Invalid JSON in exercises file!")
            }
        }
        
        return nil;
    }
}
