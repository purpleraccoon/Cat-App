//
//  ContentView.swift
//  Cat App
//
//  Created by Jeremy Kemery on 5/19/20.
//  Copyright © 2020 Jeremy Kemery. All rights reserved.
//

import SwiftUI

struct CatView: View {
    let breakfast = 4
    let dinner = 16
    @State var meal: String = "Sandwich"
    @State var portion: Double = 0
    @State var lastFed = Date()
    let formatter = DateFormatter()
    var body: some View {
        VStack {
            Text("Has Bella Had \(meal)?")
                .font(.title)

            Text(portion > 0 ? portion == 1 ? "Yes" : "\(Int(self.portion * 100))%" : "No")
                .font(Font.system(size: 300)).bold()

            // Text(formatter.string(from: lastFed))
            // .font(.largeTitle)

            HStack {
                Spacer()

                Button(action: {
                    self.lastFed = Date()
                    self.portion = 0
                }) {
                    Text("😿🤮")
                        .font(Font.system(size: 80)).bold()
                }

                Spacer()

                Button(action: {
                    self.lastFed = Date()
                    self.portion += 1.0 / 3.0
                    self.portion = min(self.portion, 1.0)
                }) {
                    Text("Third")
                        .font(Font.system(size: 80)).bold()
                }
                .disabled(portion >= 1)

                Spacer()

                Button(action: {
                    self.lastFed = Date()
                    self.portion += 0.5
                    self.portion = min(self.portion, 1.0)
                }) {
                    Text("Half")
                        .font(Font.system(size: 80)).bold()
                }
                .disabled(portion >= 1)

                Spacer()

                Button(action: {
                    self.lastFed = Date()
                    self.portion = 1
                }) {
                    Text("Full")
                        .font(Font.system(size: 80)).bold()
                }
                .disabled(portion >= 1)

                Spacer()
            }

            Slider(value: $portion)
                .padding()
        }
        .onAppear() {
            self.formatter.dateStyle = .short
            self.formatter.timeStyle = .short

            DispatchQueue.global().async {
                while true {
                    let hour = Calendar.current.component(.hour, from: Date())
                    if hour >= self.breakfast && hour < self.dinner && self.meal != "Breakfast" {
                        self.meal = "Breakfast"
                        self.portion = 0
                    } else if (hour < self.breakfast || hour >= self.dinner) && self.meal != "Dinner" {
                        self.meal = "Dinner"
                        self.portion = 0
                    }
                    sleep(60)
                }

            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CatView()
    }
}
