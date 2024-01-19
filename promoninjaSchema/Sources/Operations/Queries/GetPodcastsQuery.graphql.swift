// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class GetPodcastsQuery: GraphQLQuery {
  public static let operationName: String = "GetPodcasts"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query GetPodcasts { getPodcasts { __typename category { __typename name } externalUrl imageUrl offer { __typename url } publisher sponsors { __typename name } title } }"#
    ))

  public init() {}

  public struct Data: PromoninjaSchema.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { PromoninjaSchema.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("getPodcasts", [GetPodcast?]?.self),
    ] }

    public var getPodcasts: [GetPodcast?]? { __data["getPodcasts"] }

    /// GetPodcast
    ///
    /// Parent Type: `Podcast`
    public struct GetPodcast: PromoninjaSchema.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { PromoninjaSchema.Objects.Podcast }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("category", [Category?]?.self),
        .field("externalUrl", String?.self),
        .field("imageUrl", String?.self),
        .field("offer", [Offer?]?.self),
        .field("publisher", String?.self),
        .field("sponsors", [Sponsor?]?.self),
        .field("title", String.self),
      ] }

      public var category: [Category?]? { __data["category"] }
      public var externalUrl: String? { __data["externalUrl"] }
      public var imageUrl: String? { __data["imageUrl"] }
      public var offer: [Offer?]? { __data["offer"] }
      public var publisher: String? { __data["publisher"] }
      public var sponsors: [Sponsor?]? { __data["sponsors"] }
      public var title: String { __data["title"] }

      /// GetPodcast.Category
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

      /// GetPodcast.Offer
      ///
      /// Parent Type: `Offer`
      public struct Offer: PromoninjaSchema.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { PromoninjaSchema.Objects.Offer }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("url", String.self),
        ] }

        public var url: String { __data["url"] }
      }

      /// GetPodcast.Sponsor
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
    }
  }
}
