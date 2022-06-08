//
//  TabItem.swift
//  OnTheMap
//
//  Created by Gilang Ramadhan on 05/06/22.
//

import SwiftUI

struct TabItem: View {

  var imageName: String
  var title: String
  var body: some View {
    VStack {
      Image(systemName: imageName)
      Text(title)
    }
  }
}
