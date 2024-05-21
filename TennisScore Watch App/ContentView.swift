//
//  ContentView.swift
//  TennisScore Watch App
//
//  Created by Mac on 2024/01/03.
//


import SwiftUI

class score_index: ObservableObject {
    @Published var my_nscore_index: Int = 0
    @Published var you_nscore_index: Int = 0
    @Published var my_tscore_index: Int = 0
    @Published var you_tscore_index: Int = 0
}

struct ContentView: View {
    var count = score_index()
    @State var show_normal: Bool = false
    @State var show_tie_break: Bool = false
    @State var selectednumber: Int = 1
    let max_selecte: Int = 20
    
    var body: some View {
        VStack {
            Text("start")
                .frame(height: 0.0)
            Button("Score") {
                self.show_normal.toggle()
            }
            .font(.title3)
            .foregroundColor(.green)
            .padding()
            .sheet(isPresented: $show_normal) {
                //normal_view(count: count.self)
                normal_view(count: count.self)
            }
            Button("Game") {
                self.show_tie_break.toggle()
            }
            .font(.title3)
            .foregroundColor(.yellow)
            .padding()
            .sheet(isPresented: $show_tie_break) {
                tie_break_view(count: count.self)
            }
            Picker("", selection: $selectednumber) {
                ForEach(1..<30) { num in
                    Text(String(num)).tag(num)
                }
            }
            .padding(.bottom, 0.0)
            .font(.title)
            .frame(width: 80, height: 60)
            .clipped()
        }
    }
}

class counter_calc {
    func count(n: Int, limit: Int, cal: Bool) -> Int {
        var cc: Int = 0
        if cal {
            if n == limit {
                cc = 0
            } else {
                cc = n + 1
            }
        } else {
            if n == 0 {
                cc = limit
            } else {
                cc = n - 1
            }
        }
        return cc
    }
}

struct normal_view: View {
    @ObservedObject var count: score_index
    @State var Score: [String] = ["00","15","30","40"]
    @State var my_Score:String = "00"
    @State var you_score: String = "00"
    let limit_val: Int = 3
    var Normal_calc = counter_calc()
    
    
    var body: some View {
        HStack {
            VStack {
                Spacer(minLength: 15)
                Button("+") {
                    count.my_nscore_index = Normal_calc.count(n: count.my_nscore_index, limit: limit_val, cal: true)
                }
                .font(.title)
                .foregroundColor(.green)
                //.padding()
                Text(Score[count.my_nscore_index])
                    .font(.largeTitle)
                    .foregroundColor(.green)
                    .multilineTextAlignment(.center)
                    .padding()
                Button("-") {
                    count.my_nscore_index = Normal_calc.count(n: count.my_nscore_index, limit: limit_val, cal: false)
                }
                .font(.title)
                .foregroundColor(.green)
                //.padding()
            }
            Spacer(minLength: 20)
            VStack {
                Spacer(minLength: 15)
                Button("+") {
                    count.you_nscore_index = Normal_calc.count(n: count.you_nscore_index, limit: limit_val, cal: true)
                }
                .font(.title)
                .foregroundColor(.yellow)
                //.padding()
                Text(Score[count.you_nscore_index])
                    .font(.title)
                    .foregroundColor(.yellow)
                    .multilineTextAlignment(.center)
                    .padding()
                Button("-") {
                    count.you_nscore_index = Normal_calc.count(n: count.you_nscore_index, limit: limit_val, cal: false)
                }
                .font(.largeTitle)
                .foregroundColor(.yellow)
                //.padding()
            }
        }
    }
}

struct tie_break_view: View {
    @ObservedObject var count: score_index
    @State var Score: [String] = ["0","1","2","3","4","5","6","7","8","9","10"]
    @State var my_Score:String = "0"
    @State var you_score: String = "0"
    @State var my_count: Int = 0
    @State var you_count: Int = 0
    let limit_val: Int = 10
    var Tie_break_count = counter_calc()
    
    var body: some View {
        HStack {
            VStack {
                Spacer(minLength: 15)
                Button("+") {
                    count.my_tscore_index = Tie_break_count.count(n: count.my_tscore_index, limit: limit_val, cal: true)
                }
                .font(.title)
                .foregroundColor(.green)
                //.padding()
                Text(Score[count.my_tscore_index])
                    .font(.largeTitle)
                    .foregroundColor(.green)
                    .padding()
                Button("-") {
                    count.my_tscore_index = Tie_break_count.count(n: count.my_tscore_index, limit: limit_val, cal: false)
                }
                .font(.title)
                .foregroundColor(.green)
                //.padding()
            }
            Spacer(minLength: 20)
            VStack {
                Spacer(minLength: 15)
                Button("+") {
                    count.you_tscore_index = Tie_break_count.count(n: count.you_tscore_index, limit: limit_val, cal: true)
                }
                .font(.title)
                .foregroundColor(.yellow)
                //.padding()
                Text(Score[count.you_tscore_index])
                    .font(.title)
                    .foregroundColor(.yellow)
                    .padding()
                Button("-") {
                    count.you_tscore_index = Tie_break_count.count(n: count.you_tscore_index, limit: limit_val, cal: false)
                }
                .font(.largeTitle)
                .foregroundColor(.yellow)
                //.padding()
            }
        }
    }
}
 
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
