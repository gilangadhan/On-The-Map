//
//  HomePagesView.swift
//  OnTheMap
//
//  Created by Gilang Ramadhan on 19/06/22.
//

import Foundation
import SwiftUI

struct HomePageView: View {
  @ObservedObject var viewModel: HomePageViewModel
  @State var selection = 0
  @State var isReloading = false
  @State var isBackToHome = false

  var body: some View {
    TabView(selection: $selection) {
      OnTheMapRouter().showView()
        .tabItem {
          Label("Map", systemImage: "globe.asia.australia")
        }.tag(0)
        .onAppear() {
          self.selection = 0
        }
      OnTheListRouter().showView()
        .tabItem {
          Label("List", systemImage: "list.dash")
        }.tag(1)
        .onAppear() {
          self.selection = 1
        }
    }
      .toolbar {
      ToolbarItemGroup(placement: .navigationBarTrailing) {
        Button(action: {
          if selection == 0 {
            selection = 0
          } else {
            selection = 1
          }
        }, label: {
          Image(systemName: "arrow.clockwise")
        })

        NavigationLink {
          FindLocationRouter().showView()
        } label: {
          Image(systemName: "plus")
        }

      }
      ToolbarItem(placement: .navigationBarLeading) {
        Button("Logout") {
          self.viewModel.deleteSession()
        }.alert(
          viewModel.errorMessage,
          isPresented: $viewModel.showingAlert
        ) {
          Button("Ok", role: .cancel) { }
        }
      }
    }
  }
}
