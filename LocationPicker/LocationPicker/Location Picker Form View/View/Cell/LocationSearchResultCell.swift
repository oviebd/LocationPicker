//
//  LocationSearchResultCell.swift
//  LocationPicker
//
//  Created by Habibur Rahman on 20/12/23.
//

import SwiftUI

struct LocationSearchResultCell: View {
    var title : String = "asd"
    var subTitle : String = "asdasd"
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.body)
                .foregroundColor(Color.black)

            Text(subTitle)
                .font(.subheadline)
                .foregroundColor(.gray)

            Divider()
        }
        .padding(.leading, 5)
    }
}

struct LocationSearchResultCell_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchResultCell()
    }
}
