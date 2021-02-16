// Generated using Sourcery 1.0.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT



// Generated with SwiftyMocky 4.0.1

import SwiftyMocky
import XCTest
import Combine
import Foundation
import Logging
import SDWebImage
import UIKit
@testable import Movies


// MARK: - APIServiceProtocol

open class APIServiceProtocolMock: APIServiceProtocol, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }

    public var baseUrl: String {
		get {	invocations.append(.p_baseUrl_get); return __p_baseUrl ?? givenGetterValue(.p_baseUrl_get, "APIServiceProtocolMock - stub value for baseUrl was not defined") }
	}
	private var __p_baseUrl: (String)?

    public var pagination: Pagination? {
		get {	invocations.append(.p_pagination_get); return __p_pagination ?? optionalGivenGetterValue(.p_pagination_get, "APIServiceProtocolMock - stub value for pagination was not defined") }
		set {	invocations.append(.p_pagination_set(.value(newValue))); __p_pagination = newValue }
	}
	private var __p_pagination: (Pagination)?





    open func fullUrl(for endpoint: Endpoint) -> URL? {
        addInvocation(.m_fullUrl__for_endpoint(Parameter<Endpoint>.value(`endpoint`)))
		let perform = methodPerformValue(.m_fullUrl__for_endpoint(Parameter<Endpoint>.value(`endpoint`))) as? (Endpoint) -> Void
		perform?(`endpoint`)
		var __value: URL? = nil
		do {
		    __value = try methodReturnValue(.m_fullUrl__for_endpoint(Parameter<Endpoint>.value(`endpoint`))).casted()
		} catch {
			// do nothing
		}
		return __value
    }

    open func performRequest<Response: Decodable, APIError: Decodable>(to endpoint: Endpoint, responseErrorType: APIError.Type) -> AnyPublisher<Response, ApiError>? {
        addInvocation(.m_performRequest__to_endpointresponseErrorType_responseErrorType(Parameter<Endpoint>.value(`endpoint`), Parameter<APIError.Type>.value(`responseErrorType`).wrapAsGeneric()))
		let perform = methodPerformValue(.m_performRequest__to_endpointresponseErrorType_responseErrorType(Parameter<Endpoint>.value(`endpoint`), Parameter<APIError.Type>.value(`responseErrorType`).wrapAsGeneric())) as? (Endpoint, APIError.Type) -> Void
		perform?(`endpoint`, `responseErrorType`)
		var __value: AnyPublisher<Response, ApiError>? = nil
		do {
		    __value = try methodReturnValue(.m_performRequest__to_endpointresponseErrorType_responseErrorType(Parameter<Endpoint>.value(`endpoint`), Parameter<APIError.Type>.value(`responseErrorType`).wrapAsGeneric())).casted()
		} catch {
			// do nothing
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_fullUrl__for_endpoint(Parameter<Endpoint>)
        case m_performRequest__to_endpointresponseErrorType_responseErrorType(Parameter<Endpoint>, Parameter<GenericAttribute>)
        case p_baseUrl_get
        case p_pagination_get
		case p_pagination_set(Parameter<Pagination?>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_fullUrl__for_endpoint(let lhsEndpoint), .m_fullUrl__for_endpoint(let rhsEndpoint)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsEndpoint, rhs: rhsEndpoint, with: matcher), lhsEndpoint, rhsEndpoint, "for endpoint"))
				return Matcher.ComparisonResult(results)

            case (.m_performRequest__to_endpointresponseErrorType_responseErrorType(let lhsEndpoint, let lhsResponseerrortype), .m_performRequest__to_endpointresponseErrorType_responseErrorType(let rhsEndpoint, let rhsResponseerrortype)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsEndpoint, rhs: rhsEndpoint, with: matcher), lhsEndpoint, rhsEndpoint, "to endpoint"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsResponseerrortype, rhs: rhsResponseerrortype, with: matcher), lhsResponseerrortype, rhsResponseerrortype, "responseErrorType"))
				return Matcher.ComparisonResult(results)
            case (.p_baseUrl_get,.p_baseUrl_get): return Matcher.ComparisonResult.match
            case (.p_pagination_get,.p_pagination_get): return Matcher.ComparisonResult.match
			case (.p_pagination_set(let left),.p_pagination_set(let right)): return Matcher.ComparisonResult([Matcher.ParameterComparisonResult(Parameter<Pagination?>.compare(lhs: left, rhs: right, with: matcher), left, right, "newValue")])
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_fullUrl__for_endpoint(p0): return p0.intValue
            case let .m_performRequest__to_endpointresponseErrorType_responseErrorType(p0, p1): return p0.intValue + p1.intValue
            case .p_baseUrl_get: return 0
            case .p_pagination_get: return 0
			case .p_pagination_set(let newValue): return newValue.intValue
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_fullUrl__for_endpoint: return ".fullUrl(for:)"
            case .m_performRequest__to_endpointresponseErrorType_responseErrorType: return ".performRequest(to:responseErrorType:)"
            case .p_baseUrl_get: return "[get] .baseUrl"
            case .p_pagination_get: return "[get] .pagination"
			case .p_pagination_set: return "[set] .pagination"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }

        public static func baseUrl(getter defaultValue: String...) -> PropertyStub {
            return Given(method: .p_baseUrl_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }
        public static func pagination(getter defaultValue: Pagination?...) -> PropertyStub {
            return Given(method: .p_pagination_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }

        public static func fullUrl(for endpoint: Parameter<Endpoint>, willReturn: URL?...) -> MethodStub {
            return Given(method: .m_fullUrl__for_endpoint(`endpoint`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func performRequest<Response: Decodable, APIError: Decodable>(to endpoint: Parameter<Endpoint>, responseErrorType: Parameter<APIError.Type>, willReturn: AnyPublisher<Response, ApiError>?...) -> MethodStub {
            return Given(method: .m_performRequest__to_endpointresponseErrorType_responseErrorType(`endpoint`, `responseErrorType`.wrapAsGeneric()), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func fullUrl(for endpoint: Parameter<Endpoint>, willProduce: (Stubber<URL?>) -> Void) -> MethodStub {
            let willReturn: [URL?] = []
			let given: Given = { return Given(method: .m_fullUrl__for_endpoint(`endpoint`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (URL?).self)
			willProduce(stubber)
			return given
        }
        public static func performRequest<Response: Decodable, APIError: Decodable>(to endpoint: Parameter<Endpoint>, responseErrorType: Parameter<APIError.Type>, willProduce: (Stubber<AnyPublisher<Response, ApiError>?>) -> Void) -> MethodStub {
            let willReturn: [AnyPublisher<Response, ApiError>?] = []
			let given: Given = { return Given(method: .m_performRequest__to_endpointresponseErrorType_responseErrorType(`endpoint`, `responseErrorType`.wrapAsGeneric()), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (AnyPublisher<Response, ApiError>?).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func fullUrl(for endpoint: Parameter<Endpoint>) -> Verify { return Verify(method: .m_fullUrl__for_endpoint(`endpoint`))}
        public static func performRequest<APIError>(to endpoint: Parameter<Endpoint>, responseErrorType: Parameter<APIError.Type>) -> Verify where APIError:Decodable { return Verify(method: .m_performRequest__to_endpointresponseErrorType_responseErrorType(`endpoint`, `responseErrorType`.wrapAsGeneric()))}
        public static var baseUrl: Verify { return Verify(method: .p_baseUrl_get) }
        public static var pagination: Verify { return Verify(method: .p_pagination_get) }
		public static func pagination(set newValue: Parameter<Pagination?>) -> Verify { return Verify(method: .p_pagination_set(newValue)) }
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func fullUrl(for endpoint: Parameter<Endpoint>, perform: @escaping (Endpoint) -> Void) -> Perform {
            return Perform(method: .m_fullUrl__for_endpoint(`endpoint`), performs: perform)
        }
        public static func performRequest<APIError>(to endpoint: Parameter<Endpoint>, responseErrorType: Parameter<APIError.Type>, perform: @escaping (Endpoint, APIError.Type) -> Void) -> Perform where APIError:Decodable {
            return Perform(method: .m_performRequest__to_endpointresponseErrorType_responseErrorType(`endpoint`, `responseErrorType`.wrapAsGeneric()), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }
    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        return matchingCalls(method.method, file: file, line: line).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

// MARK: - Endpoint

open class EndpointMock: Endpoint, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }

    public var path: String {
		get {	invocations.append(.p_path_get); return __p_path ?? givenGetterValue(.p_path_get, "EndpointMock - stub value for path was not defined") }
	}
	private var __p_path: (String)?

    public var queryItems: [URLQueryItem] {
		get {	invocations.append(.p_queryItems_get); return __p_queryItems ?? givenGetterValue(.p_queryItems_get, "EndpointMock - stub value for queryItems was not defined") }
	}
	private var __p_queryItems: ([URLQueryItem])?






    fileprivate enum MethodType {
        case p_path_get
        case p_queryItems_get

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {            case (.p_path_get,.p_path_get): return Matcher.ComparisonResult.match
            case (.p_queryItems_get,.p_queryItems_get): return Matcher.ComparisonResult.match
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case .p_path_get: return 0
            case .p_queryItems_get: return 0
            }
        }
        func assertionName() -> String {
            switch self {
            case .p_path_get: return "[get] .path"
            case .p_queryItems_get: return "[get] .queryItems"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }

        public static func path(getter defaultValue: String...) -> PropertyStub {
            return Given(method: .p_path_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }
        public static func queryItems(getter defaultValue: [URLQueryItem]...) -> PropertyStub {
            return Given(method: .p_queryItems_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }

    }

    public struct Verify {
        fileprivate var method: MethodType

        public static var path: Verify { return Verify(method: .p_path_get) }
        public static var queryItems: Verify { return Verify(method: .p_queryItems_get) }
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }
    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        return matchingCalls(method.method, file: file, line: line).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

// MARK: - ErrorData

open class ErrorDataMock: ErrorData, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }

    public var imageName: String {
		get {	invocations.append(.p_imageName_get); return __p_imageName ?? givenGetterValue(.p_imageName_get, "ErrorDataMock - stub value for imageName was not defined") }
	}
	private var __p_imageName: (String)?

    public var errorDescription: String {
		get {	invocations.append(.p_errorDescription_get); return __p_errorDescription ?? givenGetterValue(.p_errorDescription_get, "ErrorDataMock - stub value for errorDescription was not defined") }
	}
	private var __p_errorDescription: (String)?






    fileprivate enum MethodType {
        case p_imageName_get
        case p_errorDescription_get

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {            case (.p_imageName_get,.p_imageName_get): return Matcher.ComparisonResult.match
            case (.p_errorDescription_get,.p_errorDescription_get): return Matcher.ComparisonResult.match
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case .p_imageName_get: return 0
            case .p_errorDescription_get: return 0
            }
        }
        func assertionName() -> String {
            switch self {
            case .p_imageName_get: return "[get] .imageName"
            case .p_errorDescription_get: return "[get] .errorDescription"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }

        public static func imageName(getter defaultValue: String...) -> PropertyStub {
            return Given(method: .p_imageName_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }
        public static func errorDescription(getter defaultValue: String...) -> PropertyStub {
            return Given(method: .p_errorDescription_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }

    }

    public struct Verify {
        fileprivate var method: MethodType

        public static var imageName: Verify { return Verify(method: .p_imageName_get) }
        public static var errorDescription: Verify { return Verify(method: .p_errorDescription_get) }
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }
    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        return matchingCalls(method.method, file: file, line: line).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

// MARK: - MovieDetailViewModelProtocol

open class MovieDetailViewModelProtocolMock: MovieDetailViewModelProtocol, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }

    public var apiService: APIServiceProtocol? {
		get {	invocations.append(.p_apiService_get); return __p_apiService ?? optionalGivenGetterValue(.p_apiService_get, "MovieDetailViewModelProtocolMock - stub value for apiService was not defined") }
	}
	private var __p_apiService: (APIServiceProtocol)?

    public var movieLoaded: ((MovieDetailsViewModelDataTuple) -> Void)? {
		get {	invocations.append(.p_movieLoaded_get); return __p_movieLoaded ?? optionalGivenGetterValue(.p_movieLoaded_get, "MovieDetailViewModelProtocolMock - stub value for movieLoaded was not defined") }
		set {	invocations.append(.p_movieLoaded_set(.value(newValue))); __p_movieLoaded = newValue }
	}
	private var __p_movieLoaded: ((MovieDetailsViewModelDataTuple) -> Void)?

    public var errorHandler: ((ErrorData) -> Void)? {
		get {	invocations.append(.p_errorHandler_get); return __p_errorHandler ?? optionalGivenGetterValue(.p_errorHandler_get, "MovieDetailViewModelProtocolMock - stub value for errorHandler was not defined") }
		set {	invocations.append(.p_errorHandler_set(.value(newValue))); __p_errorHandler = newValue }
	}
	private var __p_errorHandler: ((ErrorData) -> Void)?

    public var currentMovie: Movie? {
		get {	invocations.append(.p_currentMovie_get); return __p_currentMovie ?? optionalGivenGetterValue(.p_currentMovie_get, "MovieDetailViewModelProtocolMock - stub value for currentMovie was not defined") }
		set {	invocations.append(.p_currentMovie_set(.value(newValue))); __p_currentMovie = newValue }
	}
	private var __p_currentMovie: (Movie)?





    open func fetchMovie(imdbID: String) {
        addInvocation(.m_fetchMovie__imdbID_imdbID(Parameter<String>.value(`imdbID`)))
		let perform = methodPerformValue(.m_fetchMovie__imdbID_imdbID(Parameter<String>.value(`imdbID`))) as? (String) -> Void
		perform?(`imdbID`)
    }


    fileprivate enum MethodType {
        case m_fetchMovie__imdbID_imdbID(Parameter<String>)
        case p_apiService_get
        case p_movieLoaded_get
		case p_movieLoaded_set(Parameter<((MovieDetailsViewModelDataTuple) -> Void)?>)
        case p_errorHandler_get
		case p_errorHandler_set(Parameter<((ErrorData) -> Void)?>)
        case p_currentMovie_get
		case p_currentMovie_set(Parameter<Movie?>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_fetchMovie__imdbID_imdbID(let lhsImdbid), .m_fetchMovie__imdbID_imdbID(let rhsImdbid)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsImdbid, rhs: rhsImdbid, with: matcher), lhsImdbid, rhsImdbid, "imdbID"))
				return Matcher.ComparisonResult(results)
            case (.p_apiService_get,.p_apiService_get): return Matcher.ComparisonResult.match
            case (.p_movieLoaded_get,.p_movieLoaded_get): return Matcher.ComparisonResult.match
			case (.p_movieLoaded_set(let left),.p_movieLoaded_set(let right)): return Matcher.ComparisonResult([Matcher.ParameterComparisonResult(Parameter<((MovieDetailsViewModelDataTuple) -> Void)?>.compare(lhs: left, rhs: right, with: matcher), left, right, "newValue")])
            case (.p_errorHandler_get,.p_errorHandler_get): return Matcher.ComparisonResult.match
			case (.p_errorHandler_set(let left),.p_errorHandler_set(let right)): return Matcher.ComparisonResult([Matcher.ParameterComparisonResult(Parameter<((ErrorData) -> Void)?>.compare(lhs: left, rhs: right, with: matcher), left, right, "newValue")])
            case (.p_currentMovie_get,.p_currentMovie_get): return Matcher.ComparisonResult.match
			case (.p_currentMovie_set(let left),.p_currentMovie_set(let right)): return Matcher.ComparisonResult([Matcher.ParameterComparisonResult(Parameter<Movie?>.compare(lhs: left, rhs: right, with: matcher), left, right, "newValue")])
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_fetchMovie__imdbID_imdbID(p0): return p0.intValue
            case .p_apiService_get: return 0
            case .p_movieLoaded_get: return 0
			case .p_movieLoaded_set(let newValue): return newValue.intValue
            case .p_errorHandler_get: return 0
			case .p_errorHandler_set(let newValue): return newValue.intValue
            case .p_currentMovie_get: return 0
			case .p_currentMovie_set(let newValue): return newValue.intValue
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_fetchMovie__imdbID_imdbID: return ".fetchMovie(imdbID:)"
            case .p_apiService_get: return "[get] .apiService"
            case .p_movieLoaded_get: return "[get] .movieLoaded"
			case .p_movieLoaded_set: return "[set] .movieLoaded"
            case .p_errorHandler_get: return "[get] .errorHandler"
			case .p_errorHandler_set: return "[set] .errorHandler"
            case .p_currentMovie_get: return "[get] .currentMovie"
			case .p_currentMovie_set: return "[set] .currentMovie"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }

        public static func apiService(getter defaultValue: APIServiceProtocol?...) -> PropertyStub {
            return Given(method: .p_apiService_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }
        public static func movieLoaded(getter defaultValue: ((MovieDetailsViewModelDataTuple) -> Void)?...) -> PropertyStub {
            return Given(method: .p_movieLoaded_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }
        public static func errorHandler(getter defaultValue: ((ErrorData) -> Void)?...) -> PropertyStub {
            return Given(method: .p_errorHandler_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }
        public static func currentMovie(getter defaultValue: Movie?...) -> PropertyStub {
            return Given(method: .p_currentMovie_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }

    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func fetchMovie(imdbID: Parameter<String>) -> Verify { return Verify(method: .m_fetchMovie__imdbID_imdbID(`imdbID`))}
        public static var apiService: Verify { return Verify(method: .p_apiService_get) }
        public static var movieLoaded: Verify { return Verify(method: .p_movieLoaded_get) }
		public static func movieLoaded(set newValue: Parameter<((MovieDetailsViewModelDataTuple) -> Void)?>) -> Verify { return Verify(method: .p_movieLoaded_set(newValue)) }
        public static var errorHandler: Verify { return Verify(method: .p_errorHandler_get) }
		public static func errorHandler(set newValue: Parameter<((ErrorData) -> Void)?>) -> Verify { return Verify(method: .p_errorHandler_set(newValue)) }
        public static var currentMovie: Verify { return Verify(method: .p_currentMovie_get) }
		public static func currentMovie(set newValue: Parameter<Movie?>) -> Verify { return Verify(method: .p_currentMovie_set(newValue)) }
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func fetchMovie(imdbID: Parameter<String>, perform: @escaping (String) -> Void) -> Perform {
            return Perform(method: .m_fetchMovie__imdbID_imdbID(`imdbID`), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }
    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        return matchingCalls(method.method, file: file, line: line).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

// MARK: - MoviesListViewModelProtocol

open class MoviesListViewModelProtocolMock: MoviesListViewModelProtocol, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }

    public var dataSource: MoviesDataSource? {
		get {	invocations.append(.p_dataSource_get); return __p_dataSource ?? optionalGivenGetterValue(.p_dataSource_get, "MoviesListViewModelProtocolMock - stub value for dataSource was not defined") }
	}
	private var __p_dataSource: (MoviesDataSource)?

    public var apiService: APIServiceProtocol? {
		get {	invocations.append(.p_apiService_get); return __p_apiService ?? optionalGivenGetterValue(.p_apiService_get, "MoviesListViewModelProtocolMock - stub value for apiService was not defined") }
	}
	private var __p_apiService: (APIServiceProtocol)?

    public var moviesLoaded: (([MovieMetadata]) -> Void)? {
		get {	invocations.append(.p_moviesLoaded_get); return __p_moviesLoaded ?? optionalGivenGetterValue(.p_moviesLoaded_get, "MoviesListViewModelProtocolMock - stub value for moviesLoaded was not defined") }
		set {	invocations.append(.p_moviesLoaded_set(.value(newValue))); __p_moviesLoaded = newValue }
	}
	private var __p_moviesLoaded: (([MovieMetadata]) -> Void)?

    public var errorHandler: ((ErrorData) -> Void)? {
		get {	invocations.append(.p_errorHandler_get); return __p_errorHandler ?? optionalGivenGetterValue(.p_errorHandler_get, "MoviesListViewModelProtocolMock - stub value for errorHandler was not defined") }
		set {	invocations.append(.p_errorHandler_set(.value(newValue))); __p_errorHandler = newValue }
	}
	private var __p_errorHandler: ((ErrorData) -> Void)?

    public var currentMovies: [MovieMetadata] {
		get {	invocations.append(.p_currentMovies_get); return __p_currentMovies ?? givenGetterValue(.p_currentMovies_get, "MoviesListViewModelProtocolMock - stub value for currentMovies was not defined") }
	}
	private var __p_currentMovies: ([MovieMetadata])?





    open func setupDataSource(for collectionView: UICollectionView) {
        addInvocation(.m_setupDataSource__for_collectionView(Parameter<UICollectionView>.value(`collectionView`)))
		let perform = methodPerformValue(.m_setupDataSource__for_collectionView(Parameter<UICollectionView>.value(`collectionView`))) as? (UICollectionView) -> Void
		perform?(`collectionView`)
    }

    open func clearData(generateError: Bool) {
        addInvocation(.m_clearData__generateError_generateError(Parameter<Bool>.value(`generateError`)))
		let perform = methodPerformValue(.m_clearData__generateError_generateError(Parameter<Bool>.value(`generateError`))) as? (Bool) -> Void
		perform?(`generateError`)
    }

    open func fetchMovies(searchedTitle: String, forced: Bool) {
        addInvocation(.m_fetchMovies__searchedTitle_searchedTitleforced_forced(Parameter<String>.value(`searchedTitle`), Parameter<Bool>.value(`forced`)))
		let perform = methodPerformValue(.m_fetchMovies__searchedTitle_searchedTitleforced_forced(Parameter<String>.value(`searchedTitle`), Parameter<Bool>.value(`forced`))) as? (String, Bool) -> Void
		perform?(`searchedTitle`, `forced`)
    }

    open func fetchMoreMovies() {
        addInvocation(.m_fetchMoreMovies)
		let perform = methodPerformValue(.m_fetchMoreMovies) as? () -> Void
		perform?()
    }


    fileprivate enum MethodType {
        case m_setupDataSource__for_collectionView(Parameter<UICollectionView>)
        case m_clearData__generateError_generateError(Parameter<Bool>)
        case m_fetchMovies__searchedTitle_searchedTitleforced_forced(Parameter<String>, Parameter<Bool>)
        case m_fetchMoreMovies
        case p_dataSource_get
        case p_apiService_get
        case p_moviesLoaded_get
		case p_moviesLoaded_set(Parameter<(([MovieMetadata]) -> Void)?>)
        case p_errorHandler_get
		case p_errorHandler_set(Parameter<((ErrorData) -> Void)?>)
        case p_currentMovies_get

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_setupDataSource__for_collectionView(let lhsCollectionview), .m_setupDataSource__for_collectionView(let rhsCollectionview)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsCollectionview, rhs: rhsCollectionview, with: matcher), lhsCollectionview, rhsCollectionview, "for collectionView"))
				return Matcher.ComparisonResult(results)

            case (.m_clearData__generateError_generateError(let lhsGenerateerror), .m_clearData__generateError_generateError(let rhsGenerateerror)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsGenerateerror, rhs: rhsGenerateerror, with: matcher), lhsGenerateerror, rhsGenerateerror, "generateError"))
				return Matcher.ComparisonResult(results)

            case (.m_fetchMovies__searchedTitle_searchedTitleforced_forced(let lhsSearchedtitle, let lhsForced), .m_fetchMovies__searchedTitle_searchedTitleforced_forced(let rhsSearchedtitle, let rhsForced)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsSearchedtitle, rhs: rhsSearchedtitle, with: matcher), lhsSearchedtitle, rhsSearchedtitle, "searchedTitle"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsForced, rhs: rhsForced, with: matcher), lhsForced, rhsForced, "forced"))
				return Matcher.ComparisonResult(results)

            case (.m_fetchMoreMovies, .m_fetchMoreMovies): return .match
            case (.p_dataSource_get,.p_dataSource_get): return Matcher.ComparisonResult.match
            case (.p_apiService_get,.p_apiService_get): return Matcher.ComparisonResult.match
            case (.p_moviesLoaded_get,.p_moviesLoaded_get): return Matcher.ComparisonResult.match
			case (.p_moviesLoaded_set(let left),.p_moviesLoaded_set(let right)): return Matcher.ComparisonResult([Matcher.ParameterComparisonResult(Parameter<(([MovieMetadata]) -> Void)?>.compare(lhs: left, rhs: right, with: matcher), left, right, "newValue")])
            case (.p_errorHandler_get,.p_errorHandler_get): return Matcher.ComparisonResult.match
			case (.p_errorHandler_set(let left),.p_errorHandler_set(let right)): return Matcher.ComparisonResult([Matcher.ParameterComparisonResult(Parameter<((ErrorData) -> Void)?>.compare(lhs: left, rhs: right, with: matcher), left, right, "newValue")])
            case (.p_currentMovies_get,.p_currentMovies_get): return Matcher.ComparisonResult.match
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_setupDataSource__for_collectionView(p0): return p0.intValue
            case let .m_clearData__generateError_generateError(p0): return p0.intValue
            case let .m_fetchMovies__searchedTitle_searchedTitleforced_forced(p0, p1): return p0.intValue + p1.intValue
            case .m_fetchMoreMovies: return 0
            case .p_dataSource_get: return 0
            case .p_apiService_get: return 0
            case .p_moviesLoaded_get: return 0
			case .p_moviesLoaded_set(let newValue): return newValue.intValue
            case .p_errorHandler_get: return 0
			case .p_errorHandler_set(let newValue): return newValue.intValue
            case .p_currentMovies_get: return 0
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_setupDataSource__for_collectionView: return ".setupDataSource(for:)"
            case .m_clearData__generateError_generateError: return ".clearData(generateError:)"
            case .m_fetchMovies__searchedTitle_searchedTitleforced_forced: return ".fetchMovies(searchedTitle:forced:)"
            case .m_fetchMoreMovies: return ".fetchMoreMovies()"
            case .p_dataSource_get: return "[get] .dataSource"
            case .p_apiService_get: return "[get] .apiService"
            case .p_moviesLoaded_get: return "[get] .moviesLoaded"
			case .p_moviesLoaded_set: return "[set] .moviesLoaded"
            case .p_errorHandler_get: return "[get] .errorHandler"
			case .p_errorHandler_set: return "[set] .errorHandler"
            case .p_currentMovies_get: return "[get] .currentMovies"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }

        public static func dataSource(getter defaultValue: MoviesDataSource?...) -> PropertyStub {
            return Given(method: .p_dataSource_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }
        public static func apiService(getter defaultValue: APIServiceProtocol?...) -> PropertyStub {
            return Given(method: .p_apiService_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }
        public static func moviesLoaded(getter defaultValue: (([MovieMetadata]) -> Void)?...) -> PropertyStub {
            return Given(method: .p_moviesLoaded_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }
        public static func errorHandler(getter defaultValue: ((ErrorData) -> Void)?...) -> PropertyStub {
            return Given(method: .p_errorHandler_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }
        public static func currentMovies(getter defaultValue: [MovieMetadata]...) -> PropertyStub {
            return Given(method: .p_currentMovies_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }

    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func setupDataSource(for collectionView: Parameter<UICollectionView>) -> Verify { return Verify(method: .m_setupDataSource__for_collectionView(`collectionView`))}
        public static func clearData(generateError: Parameter<Bool>) -> Verify { return Verify(method: .m_clearData__generateError_generateError(`generateError`))}
        public static func fetchMovies(searchedTitle: Parameter<String>, forced: Parameter<Bool>) -> Verify { return Verify(method: .m_fetchMovies__searchedTitle_searchedTitleforced_forced(`searchedTitle`, `forced`))}
        public static func fetchMoreMovies() -> Verify { return Verify(method: .m_fetchMoreMovies)}
        public static var dataSource: Verify { return Verify(method: .p_dataSource_get) }
        public static var apiService: Verify { return Verify(method: .p_apiService_get) }
        public static var moviesLoaded: Verify { return Verify(method: .p_moviesLoaded_get) }
		public static func moviesLoaded(set newValue: Parameter<(([MovieMetadata]) -> Void)?>) -> Verify { return Verify(method: .p_moviesLoaded_set(newValue)) }
        public static var errorHandler: Verify { return Verify(method: .p_errorHandler_get) }
		public static func errorHandler(set newValue: Parameter<((ErrorData) -> Void)?>) -> Verify { return Verify(method: .p_errorHandler_set(newValue)) }
        public static var currentMovies: Verify { return Verify(method: .p_currentMovies_get) }
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func setupDataSource(for collectionView: Parameter<UICollectionView>, perform: @escaping (UICollectionView) -> Void) -> Perform {
            return Perform(method: .m_setupDataSource__for_collectionView(`collectionView`), performs: perform)
        }
        public static func clearData(generateError: Parameter<Bool>, perform: @escaping (Bool) -> Void) -> Perform {
            return Perform(method: .m_clearData__generateError_generateError(`generateError`), performs: perform)
        }
        public static func fetchMovies(searchedTitle: Parameter<String>, forced: Parameter<Bool>, perform: @escaping (String, Bool) -> Void) -> Perform {
            return Perform(method: .m_fetchMovies__searchedTitle_searchedTitleforced_forced(`searchedTitle`, `forced`), performs: perform)
        }
        public static func fetchMoreMovies(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_fetchMoreMovies, performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }
    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        return matchingCalls(method.method, file: file, line: line).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

// MARK: - Pagination

open class PaginationMock: Pagination, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }

    public var queryItem: String {
		get {	invocations.append(.p_queryItem_get); return __p_queryItem ?? givenGetterValue(.p_queryItem_get, "PaginationMock - stub value for queryItem was not defined") }
	}
	private var __p_queryItem: (String)?

    public var currentPage: Int {
		get {	invocations.append(.p_currentPage_get); return __p_currentPage ?? givenGetterValue(.p_currentPage_get, "PaginationMock - stub value for currentPage was not defined") }
	}
	private var __p_currentPage: (Int)?

    public var savedItems: Int {
		get {	invocations.append(.p_savedItems_get); return __p_savedItems ?? givenGetterValue(.p_savedItems_get, "PaginationMock - stub value for savedItems was not defined") }
	}
	private var __p_savedItems: (Int)?

    public var totalItems: Int {
		get {	invocations.append(.p_totalItems_get); return __p_totalItems ?? givenGetterValue(.p_totalItems_get, "PaginationMock - stub value for totalItems was not defined") }
	}
	private var __p_totalItems: (Int)?

    public var dataUpdated: Bool {
		get {	invocations.append(.p_dataUpdated_get); return __p_dataUpdated ?? givenGetterValue(.p_dataUpdated_get, "PaginationMock - stub value for dataUpdated was not defined") }
	}
	private var __p_dataUpdated: (Bool)?





    open func update(savedItems: Int, totalItems: Int) -> Pagination {
        addInvocation(.m_update__savedItems_savedItemstotalItems_totalItems(Parameter<Int>.value(`savedItems`), Parameter<Int>.value(`totalItems`)))
		let perform = methodPerformValue(.m_update__savedItems_savedItemstotalItems_totalItems(Parameter<Int>.value(`savedItems`), Parameter<Int>.value(`totalItems`))) as? (Int, Int) -> Void
		perform?(`savedItems`, `totalItems`)
		var __value: Pagination
		do {
		    __value = try methodReturnValue(.m_update__savedItems_savedItemstotalItems_totalItems(Parameter<Int>.value(`savedItems`), Parameter<Int>.value(`totalItems`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for update(savedItems: Int, totalItems: Int). Use given")
			Failure("Stub return value not specified for update(savedItems: Int, totalItems: Int). Use given")
		}
		return __value
    }

    open func hasMoreData() -> Bool {
        addInvocation(.m_hasMoreData)
		let perform = methodPerformValue(.m_hasMoreData) as? () -> Void
		perform?()
		var __value: Bool
		do {
		    __value = try methodReturnValue(.m_hasMoreData).casted()
		} catch {
			onFatalFailure("Stub return value not specified for hasMoreData(). Use given")
			Failure("Stub return value not specified for hasMoreData(). Use given")
		}
		return __value
    }

    open func nextPagination() -> Pagination {
        addInvocation(.m_nextPagination)
		let perform = methodPerformValue(.m_nextPagination) as? () -> Void
		perform?()
		var __value: Pagination
		do {
		    __value = try methodReturnValue(.m_nextPagination).casted()
		} catch {
			onFatalFailure("Stub return value not specified for nextPagination(). Use given")
			Failure("Stub return value not specified for nextPagination(). Use given")
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_update__savedItems_savedItemstotalItems_totalItems(Parameter<Int>, Parameter<Int>)
        case m_hasMoreData
        case m_nextPagination
        case p_queryItem_get
        case p_currentPage_get
        case p_savedItems_get
        case p_totalItems_get
        case p_dataUpdated_get

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_update__savedItems_savedItemstotalItems_totalItems(let lhsSaveditems, let lhsTotalitems), .m_update__savedItems_savedItemstotalItems_totalItems(let rhsSaveditems, let rhsTotalitems)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsSaveditems, rhs: rhsSaveditems, with: matcher), lhsSaveditems, rhsSaveditems, "savedItems"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsTotalitems, rhs: rhsTotalitems, with: matcher), lhsTotalitems, rhsTotalitems, "totalItems"))
				return Matcher.ComparisonResult(results)

            case (.m_hasMoreData, .m_hasMoreData): return .match

            case (.m_nextPagination, .m_nextPagination): return .match
            case (.p_queryItem_get,.p_queryItem_get): return Matcher.ComparisonResult.match
            case (.p_currentPage_get,.p_currentPage_get): return Matcher.ComparisonResult.match
            case (.p_savedItems_get,.p_savedItems_get): return Matcher.ComparisonResult.match
            case (.p_totalItems_get,.p_totalItems_get): return Matcher.ComparisonResult.match
            case (.p_dataUpdated_get,.p_dataUpdated_get): return Matcher.ComparisonResult.match
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_update__savedItems_savedItemstotalItems_totalItems(p0, p1): return p0.intValue + p1.intValue
            case .m_hasMoreData: return 0
            case .m_nextPagination: return 0
            case .p_queryItem_get: return 0
            case .p_currentPage_get: return 0
            case .p_savedItems_get: return 0
            case .p_totalItems_get: return 0
            case .p_dataUpdated_get: return 0
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_update__savedItems_savedItemstotalItems_totalItems: return ".update(savedItems:totalItems:)"
            case .m_hasMoreData: return ".hasMoreData()"
            case .m_nextPagination: return ".nextPagination()"
            case .p_queryItem_get: return "[get] .queryItem"
            case .p_currentPage_get: return "[get] .currentPage"
            case .p_savedItems_get: return "[get] .savedItems"
            case .p_totalItems_get: return "[get] .totalItems"
            case .p_dataUpdated_get: return "[get] .dataUpdated"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }

        public static func queryItem(getter defaultValue: String...) -> PropertyStub {
            return Given(method: .p_queryItem_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }
        public static func currentPage(getter defaultValue: Int...) -> PropertyStub {
            return Given(method: .p_currentPage_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }
        public static func savedItems(getter defaultValue: Int...) -> PropertyStub {
            return Given(method: .p_savedItems_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }
        public static func totalItems(getter defaultValue: Int...) -> PropertyStub {
            return Given(method: .p_totalItems_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }
        public static func dataUpdated(getter defaultValue: Bool...) -> PropertyStub {
            return Given(method: .p_dataUpdated_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }

        public static func update(savedItems: Parameter<Int>, totalItems: Parameter<Int>, willReturn: Pagination...) -> MethodStub {
            return Given(method: .m_update__savedItems_savedItemstotalItems_totalItems(`savedItems`, `totalItems`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func hasMoreData(willReturn: Bool...) -> MethodStub {
            return Given(method: .m_hasMoreData, products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func nextPagination(willReturn: Pagination...) -> MethodStub {
            return Given(method: .m_nextPagination, products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func update(savedItems: Parameter<Int>, totalItems: Parameter<Int>, willProduce: (Stubber<Pagination>) -> Void) -> MethodStub {
            let willReturn: [Pagination] = []
			let given: Given = { return Given(method: .m_update__savedItems_savedItemstotalItems_totalItems(`savedItems`, `totalItems`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Pagination).self)
			willProduce(stubber)
			return given
        }
        public static func hasMoreData(willProduce: (Stubber<Bool>) -> Void) -> MethodStub {
            let willReturn: [Bool] = []
			let given: Given = { return Given(method: .m_hasMoreData, products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Bool).self)
			willProduce(stubber)
			return given
        }
        public static func nextPagination(willProduce: (Stubber<Pagination>) -> Void) -> MethodStub {
            let willReturn: [Pagination] = []
			let given: Given = { return Given(method: .m_nextPagination, products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Pagination).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func update(savedItems: Parameter<Int>, totalItems: Parameter<Int>) -> Verify { return Verify(method: .m_update__savedItems_savedItemstotalItems_totalItems(`savedItems`, `totalItems`))}
        public static func hasMoreData() -> Verify { return Verify(method: .m_hasMoreData)}
        public static func nextPagination() -> Verify { return Verify(method: .m_nextPagination)}
        public static var queryItem: Verify { return Verify(method: .p_queryItem_get) }
        public static var currentPage: Verify { return Verify(method: .p_currentPage_get) }
        public static var savedItems: Verify { return Verify(method: .p_savedItems_get) }
        public static var totalItems: Verify { return Verify(method: .p_totalItems_get) }
        public static var dataUpdated: Verify { return Verify(method: .p_dataUpdated_get) }
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func update(savedItems: Parameter<Int>, totalItems: Parameter<Int>, perform: @escaping (Int, Int) -> Void) -> Perform {
            return Perform(method: .m_update__savedItems_savedItemstotalItems_totalItems(`savedItems`, `totalItems`), performs: perform)
        }
        public static func hasMoreData(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_hasMoreData, performs: perform)
        }
        public static func nextPagination(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_nextPagination, performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }
    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        return matchingCalls(method.method, file: file, line: line).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

