// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class GetPodcastCategoriesQuery: GraphQLQuery {
  public static let operationName: String = "GetPodcastCategories"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query GetPodcastCategories { getPodcastCategories { __typename name podcastId podcast { __typename imageUrl title publisher sponsors { __typename name } category { __typename name } } } }"#
    ))

  public init() {}

  public struct Data: PromoninjaSchema.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { PromoninjaSchema.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("getPodcastCategories", [GetPodcastCategory?]?.self),
    ] }

    public var getPodcastCategories: [GetPodcastCategory?]? { __data["getPodcastCategories"] }

    /// GetPodcastCategory
    ///
    /// Parent Type: `Category`
    public struct GetPodcastCategory: PromoninjaSchema.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { PromoninjaSchema.Objects.Category }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("name", String?.self),
        .field("podcastId", [PromoninjaSchema.ID?]?.self),
        .field("podcast", [Podcast?]?.self),
      ] }

      public var name: String? { __data["name"] }
      public var podcastId: [PromoninjaSchema.ID?]? { __data["podcastId"] }
      public var podcast: [Podcast?]? { __data["podcast"] }

      /// GetPodcastCategory.Podcast
      ///
      /// Parent Type: `Podcast`
      public struct Podcast: PromoninjaSchema.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { PromoninjaSchema.Objects.Podcast }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("imageUrl", String?.self),
          .field("title", String.self),
          .field("publisher", String?.self),
          .field("sponsors", [Sponsor?]?.self),
          .field("category", [Category?]?.self),
        ] }

        public var imageUrl: String? { __data["imageUrl"] }
        public var title: String { __data["title"] }
        public var publisher: String? { __data["publisher"] }
        public var sponsors: [Sponsor?]? { __data["sponsors"] }
        public var category: [Category?]? { __data["category"] }

        /// GetPodcastCategory.Podcast.Sponsor
        ///
        /// Parent Type: `Sponsor`
        public struct Sponsor: PromoninjaSchema.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { PromoninjaSchema.Objects.Sponsor }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("name", String?.self),
          ] }

          public var name: String? { __data["name"] }
        }

        /// GetPodcastCategory.Podcast.Category
        ///
        /// Parent Type: `Category`
        public struct Category: PromoninjaSchema.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { PromoninjaSchema.Objects.Category }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("name", String?.self),
          ] }

          public var name: String? { __data["name"] }
        }
      }
    }
  }
}
