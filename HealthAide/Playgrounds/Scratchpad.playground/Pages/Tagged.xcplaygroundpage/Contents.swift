import Foundation
import Tagged

struct User {
  typealias Id = Tagged<User, Int>

  let id: Id
  let email: String
  let address: String
  let subscriptionId: Subscription.Id?
}

struct Subscription {
  typealias Id = Tagged<Subscription, Int>

  let id: Id
}

let subscriptions = [
  Subscription(id: 1),
  Subscription(id: 2),
  Subscription(id: 3),
]

func fetchSubscription(byId id: Subscription.Id) -> Subscription? {
  return subscriptions.first(where: { $0.id == id })
}

fetchSubscription(byId: 1)
fetchSubscription(byId: 55)

