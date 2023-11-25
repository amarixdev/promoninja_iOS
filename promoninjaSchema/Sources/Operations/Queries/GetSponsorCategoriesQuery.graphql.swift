// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class GetSponsorCategoriesQuery: GraphQLQuery {
  public static let operationName: String = "GetSponsorCategories"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query GetSponsorCategories { getSponsorCategories { __typename name } }"#
    ))

  public init() {}

  public struct Data: PromoninjaSchema.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { PromoninjaSchema.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("getSponsorCategories", [GetSponsorCategory?]?.self),
    ] }

    public var getSponsorCategories: [GetSponsorCategory?]? { __data["getSponsorCategories"] }

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
      ] }

      public var name: String { __data["name"] }
    }
  }
}
