import MacrosInterface

public extension Block {
    @PublicInit
    @CodingKeys
    struct Equation: Codable, Equatable {
        let expression: String
    }
}
