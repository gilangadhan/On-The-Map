//
//  OnTheListRow.swift
//  OnTheMap
//
//  Created by Gilang Ramadhan on 05/06/22.
//

import Foundation
import SwiftUI

struct OnTheListItemRow: View {

  var studentLocation: StudentLocationModel

  var body: some View {
    VStack(alignment: .leading, spacing: 10.0) {

      HStack {
        Text("\(studentLocation.firstName ?? "") \(studentLocation.lastName ?? "")")
        .font(.title)
        .bold()
        Spacer()
      }

      Text(studentLocation.mapString ?? "")
        .font(.system(size: 14))
        .lineLimit(2)
    }
    .padding(.all)
    .frame(width: UIScreen.main.bounds.width - 32)
    .background(Color.random.opacity(0.3))
    .cornerRadius(10)
  }

}
