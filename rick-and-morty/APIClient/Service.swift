import Foundation

final class Service {
	static let share = Service()
	private init() {}
	
	public func execute(_ request: Request, completion: @escapint () -> Void) {
	
	}
}
