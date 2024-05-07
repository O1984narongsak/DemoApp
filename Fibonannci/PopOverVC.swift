import UIKit

protocol PopOverDelegate {
    func selectinDex(index: Int)
}


class PopOverVC: UIViewController {
    
    @IBOutlet weak var listTableView: UITableView!
    var list = [MapData]()
    var index = 0
    var delegate: PopOverDelegate? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        listTableView.dataSource = self
        listTableView.delegate = self
        let nib = UINib(nibName: "CustomTableViewCell", bundle: nil)
        listTableView.register(nib, forCellReuseIdentifier: "CustomTableViewCell")
    }
    
    func scrollToIndex(index: Int) {
        let indexPath = IndexPath(row: index, section: 0)
        if let _ = self.listTableView.cellForRow(at: indexPath) {
            self.listTableView.scrollToRow(at: indexPath, at: UITableView.ScrollPosition.bottom, animated: true)
        }
    }
}

extension PopOverVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.selectinDex(index: list[indexPath.row].index)
        self.dismiss(animated: true, completion: nil)
    }
}

extension PopOverVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = list[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier:
                                                        "CustomTableViewCell", for: indexPath) as! CustomTableViewCell
        cell.number.text = ("\(data.number)")
        cell.index.text = ("\(data.index)")
        cell.imageIcon.image = UIImage(named:data.type.rawValue)
        if data.mask {
            cell.bgView.backgroundColor = UIColor.green
            cell.bgView.alpha = 0.5
        } else {
            cell.bgView.backgroundColor = UIColor.clear
        }
        return cell
    }
}
