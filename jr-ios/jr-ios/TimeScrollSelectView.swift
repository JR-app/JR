//
//  TimeScrollSelectView.swift
//  jr-ios
//
//  Created by Tongsheng Wu on 14/3/25.
//

import SwiftUI

struct TimeScrollSelectView: View {
    @State private var hour: Int = 0
    @State private var min: Int = 0
    var body: some View {
        HStack(spacing: 0) {
            CustomView("hours", 0...23, $hour)
            CustomView("mins", 0...59, $min)
        }
        .offset(x: -25)
    }
    
    @ViewBuilder
    private func CustomView(_ title: String, _ range: ClosedRange<Int>, _ selection: Binding<Int>) -> some View {
        TimerViewWithoutIndicator(selection: selection) {
            ForEach(range, id: \.self) { value in Text("\(value)")
                    .frame(width:35, alignment: .trailing)
                    .tag(value)
            }
        }
        .overlay {
            Text(title)
                .font(.callout.bold())
                .frame(width:50, alignment: .leading)
                .lineLimit(1)
                .offset(x:50)
        }
    }
}

struct TimerViewWithoutIndicator<Content: View, Selection: Hashable>: View {
    @Binding var selection: Selection
    @ViewBuilder var content: Content
    @State var isHidden: Bool = false
    var body: some View {
        Picker("", selection: $selection) {
            if !isHidden {
                RemoveIndicatorPicker{
                    isHidden = true
                }
            }
            content
        }
        .pickerStyle(.wheel)
    }
}

fileprivate
struct RemoveIndicatorPicker: UIViewRepresentable {
    var result: () -> ()
    func makeUIView(context:Context) -> UIView {
        let view = UIView()
        view.backgroundColor = .clear
        DispatchQueue.main.async {
            if let pickerView = view.pickerView {
                if pickerView.subviews.count >= 2 {
                    pickerView.subviews[1].backgroundColor = .clear
                }
                result()
            }
        }
        
        return view
    }
    func updateUIView(_ uiView: UIView, context: Context) {}
}
fileprivate
extension UIView {
    var pickerView: UIPickerView? {
        if let view = superview as? UIPickerView {
            return view
        }
        return superview?.pickerView
    }
}
#Preview {
    TimeScrollSelectView()
}
