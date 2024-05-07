import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var array = [0]
    var dataList = [MapData(index: 0, number: 0, type: .normal, mask: false)]
    var listOne = [MapData]()
    var listTwo = [MapData]()
    var listThree = [MapData]()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        fibonacci()
        tableView.dataSource = self
        tableView.delegate = self
        let nib = UINib(nibName: "CustomTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "CustomTableViewCell")
    }
    
    //mapping Data to Present
    func fibonacci() {
        var f = 0
        var s = 1
        var sum = 0
        for i in 0...39
        {
            sum = f + s
            f=s
            s=sum
            array.append(f)
            let new = MapData(index: i+1, number: f, type: .normal, mask: false)
            dataList.append(new)
        }
    }
    
    func showPopup(list: [MapData], index: Int) {
        let popupVC = self.storyboard?.instantiateViewController(identifier: "PopOverVC") as! PopOverVC
        popupVC.list = list
        popupVC.delegate = self
        popupVC.modalPresentationStyle = .overCurrentContext
        popupVC.providesPresentationContextTransitionStyle = true
        popupVC.definesPresentationContext = true
        popupVC.modalTransitionStyle = .crossDissolve
        self.present(popupVC, animated: true, completion: nil)
    }
    
    func mappingData(index: Int, data: [MapData]) {
        for i in data {
            if i.index == index {
                data[i.index].mask = true
            } else {
                data[i.index].mask = false
            }
        }
    }
}

extension ViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var list = [MapData]()
        let newEntry = dataList[indexPath.row]
        let type = newEntry.type
        var index = 0
        var indexPosition = 0
        mappingData(index: newEntry.index, data: dataList)
        switch type {
        case .normal:
            newEntry.type = .first
            listOne.append(newEntry)
            listThree = listThree.filter(){$0.index != newEntry.index}
            list = listOne
        case .first:
            newEntry.type = .second
            listTwo.append(newEntry)
            listOne = listOne.filter(){$0.index != newEntry.index}
            list = listTwo
        case .second:
            newEntry.type = .normal
            listThree.append(newEntry)
            listTwo = listTwo.filter(){$0.index != newEntry.index}
            list = listThree
        }
        for i in list {
            if i.index == newEntry.index {
                indexPosition = index
                i.mask = true
            } else {
                i.mask = false
            }
            index += 1
        }
        //SortData Before pass to Popup
        list.sort { ($0.index , $0.number) < ($1.index, $1.number) }
        tableView.reloadData()
        showPopup(list: list, index: indexPosition)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = dataList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier:
                                                        "CustomTableViewCell", for: indexPath) as! CustomTableViewCell
        cell.number.text = ("\(data.number)")
        cell.index.text = ("\(data.index)")
        cell.imageIcon.image = UIImage(named: data.type.rawValue)
        if data.mask {
            cell.bgView.backgroundColor = UIColor.red
            cell.bgView.alpha = 0.5
        } else {
            cell.bgView.backgroundColor = UIColor.clear
        }
        return cell
    }
}

//Protocol from Popup back Mapping Data and display
extension ViewController: PopOverDelegate {
    func selectinDex(index: Int) {
        mappingData(index: index,data: dataList)
        tableView.reloadData()
        let indexPath = IndexPath(row: index, section: 0)
        if let _ = self.tableView.cellForRow(at: indexPath) {
            self.tableView.scrollToRow(at: indexPath, at: UITableView.ScrollPosition.bottom, animated: true)
        }
    }
}
