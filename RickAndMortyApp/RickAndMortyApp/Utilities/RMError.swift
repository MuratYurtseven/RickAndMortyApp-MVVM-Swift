//
//  RMError.swift
//  RickAndMortyApp
//
//  Created by Murat on 22.12.2023.
//

import Foundation

enum RMError : String,Error{
    case inavailedPage = "This page did not appear.Please try again."
    case unableToComplete = "Unable to complete this page.Please try again."
    case invailedResponse = "Invalied response from the server.Please try again"
    case invailedData = "The data reveived from  the server was invailed.Please try again."
    case unableToFavorited = "There was a error favoriting this user.Please try again."
    case alreadyInFavorites = "You have already favoritied this user."
    case emptyCharactersList = "Please favorited some characters😀."
}
