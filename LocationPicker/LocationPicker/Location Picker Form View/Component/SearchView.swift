//
//  SearchView.swift
//  LocationPicker
//
//  Created by Habibur Rahman on 20/12/23.
//

import SwiftUI

struct SearchView: View {

    @Binding var searchText: String
    
    var body: some View {
        HStack(alignment: .center) {
            Button {
            } label: {
                Image(systemName: "magnifyingglass")
            }

            TextField("search", text: $searchText)
                .font(.subheadline)
                .foregroundColor(searchText.isEmpty ? .gray.opacity(0.5) : .black)
                .submitLabel(.search)
                .onSubmit {
                   // onClickedSearchBtn()
                }
        }
        .onAppear{
            searchText = ""
        }
        .padding(.leading, 24)
        .padding(.trailing, 6)
        .frame(height: 48)
        .background(.white)
        .cornerRadius(44)
      
        .overlay(RoundedRectangle(cornerRadius: 44)
            .inset(by: 0.5)
            .stroke(Color.gray.opacity(0.4), lineWidth: 0.5))

    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(searchText: .constant(""))
    }
}
