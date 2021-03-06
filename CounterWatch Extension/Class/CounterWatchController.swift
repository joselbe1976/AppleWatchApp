import WatchKit
import Foundation




/// This controller handles counter status between the watch and its counterpart.
class CounterWatchController: WKInterfaceController
{
    // MARK: Attributes
    
    private var count: Int = 10 {
        didSet {
            counter.setText( String(count) )
            steeper.setValue( Float(count) )
        }
    }
    
    @IBOutlet weak var counter: WKInterfaceLabel! {
        didSet { counter.setText( String(count) ) }
    }
    @IBOutlet weak var steeper: WKInterfaceSlider! {
        didSet { steeper.setValue( Float(count) ) }
    }
    
    
    
    
    // MARK: Init
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        NotificationsManager.subscribeToStatusChanges(object: self, selector: #selector(statusChanged))
        
        guard let count = context as? Int else {
            return
        }
        self.count = count
    }
    
    
    func statusChanged(notification: NSNotification) {
        guard let count = notification.object as? CountType
            else { return }
        self.count = count
    }
    
    
    
    
    // MARK: Events
    
    @IBAction func steeperValueChanged(value: Float) {
        self.count = Int(value)
    }
    
    @IBAction func updateButtonTapped(_ sender: WKInterfaceButton) {
        NotificationsManager.sendStatus(status: self.count)
    }
}
