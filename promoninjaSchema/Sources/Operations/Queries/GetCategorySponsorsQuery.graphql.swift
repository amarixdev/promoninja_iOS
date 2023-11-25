// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class GetCategorySponsorsQuery: GraphQLQuery {
  public static let operationName: String = "GetCategorySponsors"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query GetCategorySponsors($input: SponsorCategoryInput!) { getCategorySponsors(input: $input) { __typename name imageUrl url summary offer } }"#
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
      .field("getCategorySponsors", [GetCategorySponsor?]?.self, arguments: ["input": .variable("input")]),
    ] }

    public var getCategorySponsors: [GetCategorySponsor?]? { __data["getCategorySponsors"] }

    /// GetCategorySponsor
    ///
    /// Parent Type: `Sponsor`
    public struct GetCategorySponsor: PromoninjaSchema.SelectionSet {
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
      ] }

      public var name: String? { __data["name"] }
      public var imageUrl: String? { __data["imageUrl"] }
      public var url: String? { __data["url"] }
      public var summary: String? { __data["summary"] }
      public var offer: String? { __data["offer"] }
    }
  }
}
