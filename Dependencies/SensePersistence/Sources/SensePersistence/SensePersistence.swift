import Foundation

public protocol PersistenceProtocol {
    func load<SenseData>(key: String) async throws -> SenseData? where SenseData: Decodable, SenseData: Sendable
    func save<SenseData>(data: SenseData, by key: String) async throws where SenseData: Encodable, SenseData: Sendable
    func clean(key: String) async throws
}

public final actor Persistence: PersistenceProtocol {
    
    public init() {}
    
    private static func fileURL(with name: String) throws -> URL {
        try FileManager.default.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: false
        )
        .appendingPathComponent("\(name).data")
    }

    public func load<SenseData>(key: String) async throws -> SenseData? where SenseData: Decodable, SenseData: Sendable {
        let fileURL = try Self.fileURL(with: key)
        guard let data = try? Data(contentsOf: fileURL) else {
            return nil
        }
        return try JSONDecoder().decode(SenseData.self, from: data)
    }

    public func save<SenseData>(data: SenseData, by key: String) async throws where SenseData: Encodable, SenseData: Sendable {
        let data = try JSONEncoder().encode(data)
        let outfile = try Self.fileURL(with: key)
        try data.write(to: outfile)
    }
    
    public func clean(key: String) async throws {
        let fileURL = try Self.fileURL(with: key)
        try FileManager.default.removeItem(at: fileURL)
    }
}
