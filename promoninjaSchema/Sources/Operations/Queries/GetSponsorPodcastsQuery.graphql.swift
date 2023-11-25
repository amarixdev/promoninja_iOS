// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class GetSponsorPodcastsQuery: GraphQLQuery {
  public static let operationName: String = "GetSponsorPodcasts"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query GetSponsorPodcasts($input: SponsorInput!) { getSponsorPodcasts(input: $input) { __typename title imageUrl publisher description backgroundColor offer { __typename sponsor promoCode url } category { __typename name } } }"#
    ))

  public var input: SponsorInput

  public init(input: SponsorInput) {
    self.input = input
  }

  public var __variables: Variables? { ["input": input] }

  public struct Data: PromoninjaSchema.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { PromoninjaSchema.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("getSponsorPodcasts", [GetSponsorPodcast?]?.self, arguments: ["input": .variable("input")]),
    ] }

    public var getSponsorPodcasts: [GetSponsorPodcast?]? { __data["getSponsorPodcasts"] }

    /// GetSponsorPodcast
    ///
    /// Parent Type: `Podcast`
    public struct GetSponsorPodcast: PromoninjaSchema.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { PromoninjaSchema.Objects.Podcast }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("title", String.self),
        .field("imageUrl", String?.self),
        .field("publisher", String?.self),
        .field("description", String?.self),
        .field("backgroundColor", String?.self),
        .field("offer", [Offer?]?.self),
        .field("category", [Category?]?.self),
      ] }

      public var title: String { __data["title"] }
      public var imageUrl: String? { __data["imageUrl"] }
      public var publisher: String? { __data["publisher"] }
      public var description: String? { __data["description"] }
      public var backgroundColor: String? { __data["backgroundColor"] }
      public var offer: [Offer?]? { __data["offer"] }
      public var category: [Category?]? { __data["category"] }

      /// GetSponsorPodcast.Offer
      ///
      /// Parent Type: `Offer`
      public struct Offer: PromoninjaSchema.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { PromoninjaSchema.Objects.Offer }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("sponsor", String.self),
          .field("promoCode", String.self),
          .field("url", String.self),
        ] }

        public var sponsor: String { __data["sponsor"] }
        public var promoCode: String { __data["promoCode"] }
        public var url: String { __data["url"] }
      }

      /// GetSponsorPodcast.Category
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
