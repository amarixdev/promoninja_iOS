// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class GetSponsorQuery: GraphQLQuery {
  public static let operationName: String = "GetSponsor"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query GetSponsor($input: SponsorInput!) { getSponsor(input: $input) { __typename name imageUrl url summary offer sponsorCategory { __typename name } podcast { __typename offer { __typename sponsor promoCode url } category { __typename name } title imageUrl publisher description backgroundColor } } }"#
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
      .field("getSponsor", GetSponsor?.self, arguments: ["input": .variable("input")]),
    ] }

    public var getSponsor: GetSponsor? { __data["getSponsor"] }

    /// GetSponsor
    ///
    /// Parent Type: `Sponsor`
    public struct GetSponsor: PromoninjaSchema.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { PromoninjaSchema.Objects.Sponsor }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("name", String?.self),
        .field("imageUrl", String?.self),
        .field("url", String?.self),
        .field("summary", String?.self),
        .field("offer", String?.self),
        .field("sponsorCategory", [SponsorCategory?]?.self),
        .field("podcast", [Podcast?]?.self),
      ] }

      public var name: String? { __data["name"] }
      public var imageUrl: String? { __data["imageUrl"] }
      public var url: String? { __data["url"] }
      public var summary: String? { __data["summary"] }
      public var offer: String? { __data["offer"] }
      public var sponsorCategory: [SponsorCategory?]? { __data["sponsorCategory"] }
      public var podcast: [Podcast?]? { __data["podcast"] }

      /// GetSponsor.SponsorCategory
      ///
      /// Parent Type: `Category`
      public struct SponsorCategory: PromoninjaSchema.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { PromoninjaSchema.Objects.Category }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("name", String?.self),
        ] }

        public var name: String? { __data["name"] }
      }

      /// GetSponsor.Podcast
      ///
      /// Parent Type: `Podcast`
      public struct Podcast: PromoninjaSchema.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { PromoninjaSchema.Objects.Podcast }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("offer", [Offer?]?.self),
          .field("category", [Category?]?.self),
          .field("title", String.self),
          .field("imageUrl", String?.self),
          .field("publisher", String?.self),
          .field("description", String?.self),
          .field("backgroundColor", String?.self),
        ] }

        public var offer: [Offer?]? { __data["offer"] }
        public var category: [Category?]? { __data["category"] }
        public var title: String { __data["title"] }
        public var imageUrl: String? { __data["imageUrl"] }
        public var publisher: String? { __data["publisher"] }
        public var description: String? { __data["description"] }
        public var backgroundColor: String? { __data["backgroundColor"] }

        /// GetSponsor.Podcast.Offer
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

        /// GetSponsor.Podcast.Category
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
