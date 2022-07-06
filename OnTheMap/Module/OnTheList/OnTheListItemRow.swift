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

    if let url = URL(string: studentLocation.mediaURL ?? "dicoding.com"), let map = studentLocation.mapString {
      Link(destination: url) {
        VStack(alignment: .leading, spacing: 10.0) {
          HStack {
            Text("\(studentLocation.firstName ?? "") \(studentLocation.lastName ?? "")")
              .font(.title)
              .bold()
              .foregroundColor(.black)
            Spacer()
          }

          Text(map)
            .font(.system(size: 14))
            .foregroundColor(.black)
            .lineLimit(2)
          Text(studentLocation.mediaURL ?? "dicoding.com")
            .font(.system(size: 14))
            .foregroundColor(.black)
            .lineLimit(2)
        } .padding(.all)
          .frame(width: UIScreen.main.bounds.width - 32)
          .background(Color.random.opacity(0.3))
          .cornerRadius(10)
      }
    } else {
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

      }.padding(.all)
        .frame(width: UIScreen.main.bounds.width - 32)
        .background(Color.random.opacity(0.3))
        .cornerRadius(10)
    }

  }

}
