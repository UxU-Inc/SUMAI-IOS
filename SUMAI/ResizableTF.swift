//
//  ResizableTF.swift
//  SUMAI
//
//  Created by 서영규 on 2021/02/16.
//

import SwiftUI

struct ResizableTF : UIViewRepresentable {
    @Binding var txt : String
    @Binding var height : CGFloat
    let isEditable : Bool
    
    func makeCoordinator() -> Coordinator {
        
        return ResizableTF.Coordinator(parent1: self)
    }
    
    func makeUIView(context: Context) -> UITextView {
        let view = UITextView()
        if self.isEditable{
            view.text = "요약할 내용을 입력하세요."
            view.textColor = .gray
        } else{
            view.text = txt
            view.textColor = .black
        }
        view.isEditable = self.isEditable
        view.font = .systemFont(ofSize: 18)
        view.backgroundColor = .clear
        view.autocorrectionType = .no
        view.delegate = context.coordinator
        
        return view
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        if !isEditable{
            uiView.text = self.txt
        } else if self.txt == ""{
            uiView.endEditing(true)
            uiView.text = "요약할 내용을 입력하세요."
            uiView.textColor = .gray
        }
        
        DispatchQueue.main.async {
            self.height = uiView.contentSize.height
        }
    }
    
    class Coordinator : NSObject, UITextViewDelegate{
        var parent : ResizableTF
        
        init(parent1 : ResizableTF) {
            parent = parent1
        }
        
        func textViewDidBeginEditing(_ textView: UITextView) {
            if self.parent.txt == ""{
                textView.text = ""
                textView.textColor = .black
            }
        }
        
        func textViewDidEndEditing(_ textView: UITextView) {
            if self.parent.txt == ""{
                textView.text = "요약할 내용을 입력하세요."
                textView.textColor = .gray
            }
        }
        
        func textViewDidChange(_ textView: UITextView) {
            DispatchQueue.main.async {
                self.parent.height = textView.contentSize.height
                self.parent.txt = textView.text
            }
        }
    }
}
