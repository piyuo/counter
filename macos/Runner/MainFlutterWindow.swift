import Cocoa
import FlutterMacOS

class MainFlutterWindow: NSWindow {
  override func awakeFromNib() {
    let flutterViewController = FlutterViewController()
    let windowFrame = self.frame
    self.contentViewController = flutterViewController
    self.setFrame(windowFrame, display: true)

    RegisterGeneratedPlugins(registry: flutterViewController)

    //self.title = Bundle.main.localizedString(forKey: "CFBundleDisplayName", value: nil, table: nil)
    self.title = "你的App名稱"

    super.awakeFromNib()
  }
}
