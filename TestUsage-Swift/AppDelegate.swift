import Cocoa
import FsprgEmbeddedStore

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!

    let storeController = FsprgEmbeddedStoreController()

    func applicationDidFinishLaunching(_ aNotification: Notification) {

        storeController.delegate = self
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

}

extension AppDelegate: FsprgEmbeddedStoreDelegate {

    func didLoadStore(_ url: URL!) {

    }

    func didLoadPage(_ url: URL!, of pageType: FsprgPageType) {

    }

    func didReceive(_ order: FsprgOrder!) {

    }

    func view(withFrame frame: NSRect, for order: FsprgOrder!) -> NSView! {

        return NSView()
    }

    func webView(_ sender: WebView!, didFailProvisionalLoadWithError error: Error!, for frame: WebFrame!) {

    }

    func webView(_ sender: WebView!, didFailLoadWithError error: Error!, for frame: WebFrame!) {

    }
}
