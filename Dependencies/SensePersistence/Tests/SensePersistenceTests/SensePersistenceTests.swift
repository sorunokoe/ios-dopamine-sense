import Testing
@testable import SensePersistence

@Test
func stringSavedAndLoaded() throws {
    let persistence = SensePersistence()
    try #require(try persistence.save(data: "Hello World", by: "sense_string"))
    #expect(try persistence.load(key: "sense_string") == "Hello World")
}

@Test
func modelSavedAndLoaded() throws {
    let data = MockSenseData(title: "D1", number: 0)
    let persistence = SensePersistence()
    try #require(try persistence.save(data: data, by: "sense_data"))
    #expect(try persistence.load(key: "sense_data") == data)
}

@Test
func arraySavedAndLoaded() throws {
    let data = [MockSenseData(title: "D1", number: 0), MockSenseData(title: "D1", number: 0)]
    let persistence = SensePersistence()
    try #require(try persistence.save(data: data, by: "sense_array"))
    #expect(try persistence.load(key: "sense_array") == data)
}

@Test
func dataSavedAndLoadedAndCleaned() throws {
    let data = [MockSenseData(title: "D1", number: 0), MockSenseData(title: "D1", number: 0)]
    let persistence = SensePersistence()
    try #require(try persistence.save(data: data, by: "sense_tmp"))
    try #require(try persistence.clean(key: "sense_tmp"))
    let loadedData: [MockSenseData]? = try persistence.load(key: "sense_tmp")
    #expect(loadedData == nil)
}

private struct MockSenseData: Codable, Equatable {
    let title: String
    let number: Int
}
