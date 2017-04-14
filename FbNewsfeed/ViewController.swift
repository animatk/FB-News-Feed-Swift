//
//  ViewController.swift
//  FbNewsfeed
//
//  Created by Alejandro St on 6/25/16.
//  Copyright © 2016 Alejandro St. All rights reserved.
//

import UIKit

let cellId = "cellId"

class MainController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

	override func viewDidLoad() {
		super.viewDidLoad()
		//color de fondo de la vista de inicio
		collectionView?.backgroundColor = UIColor(white: 0.95, alpha: 1)
		
		//titulo de la barra de navegacion
		navigationItem.title = "Facebook Feed"
		
		//se crean los metodos que soportaran la collectionView que es como una especie de tabla que contiene
		// unos elementos que denominaremos celdas (filas)  que son un elemento que se puede repetir varias veces como una especie de simbolo
		// el primer metodo (numberOfItemsInSection) retorna el numero de elementos que se repetiran
		// el segundo (cellForItemAtIndexPath) define la numeracion o identificador de cada celda (fila)
		
		//en este paso se agrega las celdas (filas) a la colectionView (tabla)
		//para ello se crea la estructura de la celda, dicha estructura es una nueva clase que se instancia
		
		collectionView?.register(LaCelda.self, forCellWithReuseIdentifier: cellId)
		
		//agregar la capacidad para que la view se pudea arrastrar (scroll)
		collectionView?.alwaysBounceVertical = true;
		
	}
	// metodo numberOfItemsInSection
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 3
	}
	// metodo cellForItemAtIndexPath
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		return collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
	}
	
	//una vez creadas las celdas, estas tienen forma libre y se arman como un cuadro pequeño una al lado de la otra
	//lo que vamos a hacer es volverlas de un tamaño del 100% de la pantalla para eso esxtendemos el presente controller
	//trallendo la clase , UICollectionViewDelegateFlowLayout y le aplicamos el nuevo tamaño con el siguiente metodo
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout
	, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: view.frame.width, height: 320)
	}

}

/*
	Clase que representara la celda (fila) de la presente colectionView
*/

class LaCelda: UICollectionViewCell {
	//inicializar clase..
	override init(frame: CGRect){
		super.init(frame: frame)
		
		setupViews()
	}
	
	//en caso de error
	required init?(coder aDecoder: NSCoder){
		fatalError("init(coder:) no esta implementado")
	}
	
	//se crea un label de texto que se agregara a cada una de las celdas creadas
	//primero se declara con sus caracteristicas y luego dentro de la funcion setupViews se declara la posicion y alineacion 
	//mediante los constraints
	let nameLabel: UILabel = {
		let label = UILabel()
		//vamos a darle al label un formato de 2 lineas, ambas con caracteristicas diferentes (fuente, color, tamaño)
		//la primera el nombre de la persona, y la segunda los detalles de fecha y hora de publicacion
		label.numberOfLines = 2
        //primera parte del texto con tamaño 14
        let attributedText = NSMutableAttributedString(string: "Mark Zucaritas", attributes: [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 14)])
        //segundo bloque de texto con respectivos atributos tañano 12 color gris
        attributedText.append(NSAttributedString(string: "\nAgosto 18  •  Bogotá  •  "
		, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 12), NSForegroundColorAttributeName:
            UIColor.rgb(155, green: 161, blue: 171)]))
        //espacio entre lineas
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
		
        attributedText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, attributedText.string.characters.count))
        //agregar imagen en la linea de texto
        let attachment = NSTextAttachment()
        attachment.image = UIImage(named: "globe_small")
        attachment.bounds = CGRect(x: 0, y: -2, width: 12, height: 12)
        attributedText.append(NSAttributedString(attachment: attachment))
        
        label.attributedText = attributedText
		
		return label
	}()
	
	//agregaremos una imagen a la celda al lado del label de texto del mismo modo que el label ... declaramos y agregamos constraints para posicion
	let profileImageView : UIImageView = {
		let imageView = UIImageView()
		imageView.image = UIImage(named: "mark-zucaritas")
		imageView.contentMode = .scaleAspectFit //mantener proporcion
		imageView.backgroundColor = UIColor.gray
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
		
	}()
	
	//Label de texto que representa el post realizado por el usuuario
	let statusTextView: UITextView = {
		let textView = UITextView()
		textView.text = "Que Gran foto  tomada con mi iPhone!"
		textView.font = UIFont.systemFont(ofSize: 14)
		return textView
	}()
	
	//agregaremos una imagen  a modo de imagen de estado
	let statusImageView : UIImageView = {
		let imageView = UIImageView()
		imageView.image = UIImage(named: "playa-mar")
		imageView.contentMode = .scaleAspectFill //mantener proporcion, se adapta al 100 del la celda... para evitarlo se usa lo siguiente
		imageView.layer.masksToBounds = true
		return imageView
		
	}()
	
	let likesLabelView : UILabel = {
		let label = UILabel()
		label.text = "489 Likes   10.8K Comments"
		label.font = UIFont.systemFont(ofSize: 12)
		label.textColor = UIColor.rgb(155, green: 161, blue: 171)
		return label
	}()
	
	let dividerline : UIView = {
		let view = UIView()
		view.backgroundColor = UIColor.rgb(226, green: 228, blue: 232)
		return view
	}()
	
	let likeButton = LaCelda.buttonForView("Like", imageName: "like")
	let commentButton = LaCelda.buttonForView("Comments", imageName: "comment")
	let shareButton = LaCelda.buttonForView("Share", imageName: "share")
	
	//funcion creada para simplificar la creacion de botones...
	
	static func buttonForView(_ title: String, imageName : String) -> UIButton{
		let button = UIButton()
		button.setTitle(title, for: UIControlState())
		button.setTitleColor(UIColor.rgb(155, green: 161, blue: 171 ), for: UIControlState())
		
		button.setImage(UIImage(named: imageName), for: UIControlState()) //icono
		button.titleEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 0) // padding del texto en relacion a icono
		
		button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
		
		return button
	}
	
	
	
	//definicion del la celda, atributos
	func setupViews() {
    	backgroundColor = UIColor.white
		//agregando el label de texto (nameLabel) dentro de la celda
		addSubview(nameLabel)
		//agregando subview de la imagen a la celda
		addSubview(profileImageView)
		addSubview(statusTextView)
		addSubview(statusImageView)
		addSubview(likesLabelView)
		addSubview(dividerline)
		
		addSubview(likeButton)
		addSubview(commentButton)
		addSubview(shareButton)
		
		//llamado a la extencion que permite crear constraints segun formato
		addConstraintsWithFormat("H:|-8-[v0(44)]-8-[v1]|", views:  profileImageView, nameLabel)
		addConstraintsWithFormat("V:|-12-[v0]", views:  nameLabel)
		addConstraintsWithFormat("H:|-4-[v0]-4-|", views: statusTextView)
		addConstraintsWithFormat("H:|[v0]|", views: statusImageView)
		addConstraintsWithFormat("H:|-12-[v0]|", views: likesLabelView)
		addConstraintsWithFormat("H:|-12-[v0]-12-|", views: dividerline)
		addConstraintsWithFormat("H:|[v0(v2)][v1(v2)][v2]|", views: likeButton, commentButton, shareButton)
		addConstraintsWithFormat("V:|-8-[v0(44)]-4-[v1(30)]-4-[v2]-8-[v3(24)]-8-[v4(0.4)][v5(44)]|", views:
			profileImageView, statusTextView, statusImageView, likesLabelView, dividerline, likeButton)
		
		addConstraintsWithFormat("V:[v0(44)]|", views: commentButton)
		addConstraintsWithFormat("V:[v0(44)]|", views: shareButton)
		
		
	}
}

extension UIColor{
	//se crea esta extencion para facilitar la asignacion de colores a los textos
	static func rgb(_ red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor{
		return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1);
	}
}

extension UIView{
	//extersion creada para limpiar y optimizar el proceso de asignar constraints
	//cada UIview creada necesita adaptarse mediante constraints pero la creacion de estos puede simplificarse mendiante esta extension
	func addConstraintsWithFormat(_ format : String, views : UIView...){
		//como el listado de views es un listado separado por comas vamos a recorrerlo para crear un diccionario (arreglo) y declarar las keys 
		var viewsDictionary = [String: UIView]()
		for(index, view) in views.enumerated(){
			let key = "v\(index)"
			viewsDictionary[key] = view
			view.translatesAutoresizingMaskIntoConstraints = false
		}
		
		addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
	
	}
}
