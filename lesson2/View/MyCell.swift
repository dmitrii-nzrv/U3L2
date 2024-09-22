
import UIKit

class MyCell: UICollectionViewCell {
    
    static var reuseID = "ItemCell"
    
    lazy var profileImg: UIImageView = {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.translatesAutoresizingMaskIntoConstraints = false
    
        return $0
    }(UIImageView())

    lazy var cellHeader: UILabel = CustomLabel(labelFont: .systemFont(ofSize: 14, weight: .black))
    lazy var celltext: UILabel = CustomLabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        [profileImg, cellHeader, celltext].forEach{
            contentView.addSubview($0)
        }
        
        contentView.backgroundColor = .gray
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(item: Character){
        cellHeader.text = item.name
        celltext.text = item.species
        
        if let url = URL(string: item.image) {
                profileImg.load(url: url) // Загружаем изображение
            } else {
                // В случае неверного URL можно задать изображение по умолчанию
                profileImg.image = UIImage(named: "defaultProfileImage")
            }
        
        profileImg.image = UIImage()
        setConstraints()
    }
    
    private func setConstraints(){
        NSLayoutConstraint.activate([
            profileImg.topAnchor.constraint(equalTo: contentView.topAnchor),
            profileImg.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            profileImg.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            profileImg.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.7),
            
            cellHeader.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            cellHeader.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            cellHeader.topAnchor.constraint(equalTo: profileImg.bottomAnchor, constant: 10),
            
            celltext.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            celltext.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            celltext.topAnchor.constraint(equalTo: cellHeader.bottomAnchor, constant: 5),
        ])
    }
}

extension UIImageView{
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

class CustomLabel: UILabel{
    
    init(labelFont: UIFont = UIFont.systemFont(ofSize: 12, weight: .light)) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        font = labelFont
        numberOfLines = 0
        textAlignment = .center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
