import XCTest
@testable import DopamineInfo

final class DataSourceTests: XCTestCase {
    
    var sut: DataSource!
    var senseInfoService: MockSenseInfoService!
    var persistence: MockPersistence!
    
    override func setUpWithError() throws {
        senseInfoService = MockSenseInfoService()
        persistence = MockPersistence()
        sut = DataSource(senseInfoService: senseInfoService, persistence: persistence)
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testGetSummarize() async throws {
        await senseInfoService.add(answer: "Hello, world!")
        let answer = try await sut.getSummary()
        XCTAssertEqual(answer, ["Hello, world!"])
    }
    
    func testGetSummarizeNoAnswer() async throws {
        let answer = try? await sut.getSummary()
        XCTAssertEqual(answer, nil)
    }
    
    func testGetSummarizeCachedAnswer() async throws {
        await senseInfoService.add(answer: "Hello, world from the Cache!")
        let answer1 = try? await sut.getSummary()
        let answer2 = try? await sut.getSummary()
        XCTAssertEqual(answer1, ["Hello, world from the Cache!"])
        XCTAssertEqual(answer1, answer2)
        let isLoaded = await persistence.isDataLoaded()
        XCTAssertEqual(isLoaded, true)
    }
}
