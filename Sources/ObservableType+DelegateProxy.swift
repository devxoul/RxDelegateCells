//
//  ObservableType+DelegateProxy.swift
//  SimpleTableViewController
//
//  Created by Suyeol Jeon on 6/29/16.
//  Copyright © 2016 Suyeol Jeon. All rights reserved.
//

import RxCocoa
import RxSwift

extension ObservableType {

    func subscribeProxyDelegateForObject<P: DelegateProxyType>(object: AnyObject,
                                                               delegate: AnyObject,
                                                               retainDelegate: Bool,
                                                               binding: (P, E) -> Void) -> Disposable {
        let proxy = P.proxyForObject(object)

        let disposable: Disposable
        if delegate !== proxy.forwardToDelegate() {
            disposable = P.installForwardDelegate(delegate, retainDelegate: retainDelegate, onProxyForObject: object)
        } else {
            disposable = AnonymousDisposable {
                proxy.setForwardToDelegate(nil, retainDelegate: retainDelegate)
            }
        }

        let subscription = self.asObservable()
            .concat(Observable.never()) // prevents delegate from being deallocated
            .subscribe { [weak object] event in
                MainScheduler.ensureExecutingOnScheduler()

                if let object = object {
                    assert(proxy === P.currentDelegateFor(object),
                           "Proxy changed from the time it was first set.\n" +
                           "Original: \(proxy)\n" +
                           "Existing: \(P.currentDelegateFor(object))")
                }

                switch event {
                case .Next(let element):
                    binding(proxy, element)

                case .Error(let error):
                    let message = "UI binding error: \(error)"
                    #if DEBUG
                        fatalError(message)
                    #else
                        print(message)
                    #endif
                    disposable.dispose()

                case .Completed:
                    disposable.dispose()
                }
        }
        return StableCompositeDisposable.create(subscription, disposable)
    }

}
