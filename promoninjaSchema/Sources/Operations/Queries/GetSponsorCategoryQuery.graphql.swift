// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class GetSponsorCategoryQuery: GraphQLQuery {
  public static let operationName: String = "GetSponsorCategory"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query GetSponsorCategory($input: SponsorCategoryInput!) { getSponsorCategory(input: $input) { __typename name sponsor { __typename name imageUrl offer summary url podcast { __typename offer { __typename sponsor promoCode url } title imageUrl publisher description backgroundColor category { __typename name } } } } }"#
    ))

  public var input: SponsorCategoryInput

  public init(input: SponsorCategoryInput) {
    self.input = input
  }

  public var __variables: Variables? { ["input": input] }

  public struct Data: PromoninjaSchema.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { PromoninjaSchema.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("getSponsorCategory", GetSponsorCategory?.self, arguments: ["input": .variable("input")]),
    ] }

    public var getSponsorCategory: GetSponsorCategory? { __data["getSponsorCategory"] }

    /// GetSponsorCategory
    ///
    /// Parent Type: `SponsorCategory`
    public struct GetSponsorCategory: PromoninjaSchema.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { PromoninjaSchema.Objects.SponsorCategory }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("name", String.self),
        .field("sponsor", [Sponsor?]?.self),
      ] }

      public var name: String { __data["name"] }
      public var sponsor: [Sponsor?]? { __data["sponsor"] }

      /// GetSponsorCategory.Sponsor
      ///
      /// Parent Type: `Sponsor`
      public struct Sponsor: PromoninjaSchema.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { PromoninjaSchema.Objects.Sponsor }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("name", String?.self),
          .field("imageUrl", String?.self),
          .field("offer", String?.self),
          .field("summary", String?.self),
          .field("url", String?.self),
          .field("podcast", [Podcast?]?.self),
        ] }

        public var name: String? { __data["name"] }
        public var imageUrl: String? { __data["imageUrl"] }
        public var offer: String? { __data["offer"] }
        public var summary: String? { __data["summary"] }
        public var url: String? { __data["url"] }
        public var podcast: [Podcast?]? { __data["podcast"] }

        /// GetSponsorCategory.Sponsor.Podcast
        ///
        /// Parent Type: `Podcast`
        public struct Podcast: PromoninjaSchema.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { PromoninjaSchema.Objects.Podcast }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("offer", [Offer?]?.self),
            .field("title", String.self),
            .field("imageUrl", String?.self),
            .field("publisher", String?.self),
            .field("description", String?.self),
            .field("backgroundColor", String?.self),
            .field("category", [Category?]?.self),
          ] }

          public var offer: [Offer?]? { __data["offer"] }
          public var title: String { __data["title"] }
          public var imageUrl: String? { __data["imageUrl"] }
          public var publisher: String? { __data["publisher"] }
          public var description: String? { __data["description"] }
          public var backgroundColor: String? { __data["backgroundColor"] }
          public var category: [Category?]? { __data["category"] }

          /// GetSponsorCategory.Sponsor.Podcast.Offer
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

          /// GetSponsorCategory.Sponsor.Podcast.Category
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
}
