//
//  Model.swift
//  Little Oven V3
//
//  Created by MacPro on 12/2/20.
//

import Foundation
enum Gender {
    case male, female
}

struct user{
    let username: String
    let bio: String
    let name: (first: String, last: String)
    let birthDate: Date
    let gender: Gender
    let counts: UserCount
    let joinedDate: Date
}
struct UserCount {
    let followers: Int
    let following: Int
    let posts: Int
}

public enum UserPostType{
    case photo, video
}
///user post
public struct UserPost {
    let identifier: String
    let postType: UserPostType
    let thumbnailImage: URL
    let postURL: URL
    let caption: String?
    let likeCount: [PostLikes]
    let comments: [PostComment]
    let createdDate: Date
    let taggedUsers: [String]
}
struct PostLikes{
    let username : String
    let postIdentifier: String
}
struct CommentLikes{
    let username : String
    let commentIdentifier: String
}
struct PostComment {
    let identifier: String
    let username: String
    let text: String
    let createdDate: Date
    let likes: [CommentLikes]
}
