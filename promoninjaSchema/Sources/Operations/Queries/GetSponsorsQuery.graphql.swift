// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class GetSponsorsQuery: GraphQLQuery {
  public static let operationName: String = "GetSponsors"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query GetSponsors($input: Pagination) { getSponsors(input: $input) { __typename sponsorCategory { __typename name } name imageUrl summary offer url } }"#
    ))

  public var input: GraphQLNullable<Pagination>

  public init(input: GraphQLNullable<Pagination>) {
    self.input = input
  }

  public var __variables: Variables? { ["input": input] }

  public struct Data: PromoninjaSchema.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { PromoninjaSchema.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("getSponsors", [GetSponsor?]?.self, arguments: ["input": .variable("input")]),
    ] }

    public var getSponsors: [GetSponsor?]? { __data["getSponsors"] }

    /// GetSponsor
    ///
    /// Parent Type: `Sponsor`
    public struct GetSponsor: PromoninjaSchema.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { PromoninjaSchema.Objects.Sponsor }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("sponsorCategory", [SponsorCategory?]?.self),
        .field("name", String?.self),
        .field("imageUrl", String?.self),
        .field("summary", String?.self),
        .field("offer", String?.self),
        .field("url", String?.self),
      ] }

      public var sponsorCategory: [SponsorCategory?]? { __data["sponsorCategory"] }
      public var name: String? { __data["name"] }
      public var imageUrl: String? { __data["imageUrl"] }
      public var summary: String? { __data["summary"] }
      public var offer: String? { __data["offer"] }
      public var url: String? { __data["url"] }

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
    }
  }
}
