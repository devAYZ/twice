//
//  GithubUsersResponse.swift
//  twice
//
//  Created by Ayokunle Fatokimi on 26/05/2025.
//

import Foundation

struct GithubUsersResponse: Decodable {
    var login: String?
    var id: Int?
    var avatarUrl, htmlUrl, userViewType, nodeId, starredUrl, eventsUrl: String?
    var siteAdmin: Bool?
    var gravatarId, organizationsUrl, reposUrl, type, followersUrl: String?
    var followingUrl, gistsUrl, subscriptionsUrl, url, receivedEventsUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case userViewType = "user_view_type"
        case avatarUrl = "avatar_url"
        case htmlUrl = "html_url"
        case login = "login"
        case starredUrl = "starred_url"
        case nodeId = "node_id"
        case eventsUrl = "events_url"
        case id = "id"
        case gravatarId = "gravatar_id"
        case organizationsUrl = "organizations_url"
        case siteAdmin = "site_admin"
        case reposUrl = "repos_url"
        case type = "type"
        case followersUrl = "followers_url"
        case followingUrl = "following_url"
        case gistsUrl = "gists_url"
        case subscriptionsUrl = "subscriptions_url"
        case url = "url"
        case receivedEventsUrl = "received_events_url"
    }
}
