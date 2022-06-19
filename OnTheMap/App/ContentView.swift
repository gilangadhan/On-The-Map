//
//  ContentView.swift
//  OnTheMap
//
//  Created by Gilang Ramadhan on 05/06/22.
//

import SwiftUI

struct ContentView: View {
  @ObservedObject var session: OnTheMapSession

  var body: some View {
    NavigationView {
      VStack {
        if session.stateLogin {
          HomePageRouter().showView().transition(.opacity)
        } else {
          LoginRouter().showView().transition(.opacity)
        }
      }
    }
  }
}

class ContentViewRouter {

  func showView() -> some View {
    let session = Injection.init().provideSession()
    return ContentView(session: session)
  }

}
