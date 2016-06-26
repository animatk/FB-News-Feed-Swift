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
		
		collectionView?.registerClass(LaCelda.self, forCellWithReuseIdentifier: cellId)
		
		//agregar la capacidad para que la view se pudea arrastrar (scroll)
		collectionView?.alwaysBounceVertical = true;
		
	}
	// metodo numberOfItemsInSection
	override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 3
	}
	// metodo cellForItemAtIndexPath
	override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
		return collectionView.dequeueReusableCellWithReuseIdentifier(cellId, forIndexPath: indexPath)
	}
	
	//una vez creadas las celdas, estas tienen forma libre y se arman como un cuadro pequeño una al lado de la otra
	//lo que vamos a hacer es volverlas de un tamaño del 100% de la pantalla para eso esxtendemos el presente controller
	//trallendo la clase , UICollectionViewDelegateFlowLayout y le aplicamos el nuevo tamaño con el siguiente metodo
	
	func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout
	, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
		return CGSizeMake(view.frame.width, 50)
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
		label.text = "Ejemplo nombre"
		label.font = UIFont.boldSystemFontOfSize(14)
		label.translatesAutoresizingMaskIntoConstraints = false //esto permique que el elmento se adapte a los constrains que se declararan dentro del constructor de la celda
		return label
	}()
	
	
	//definicion del la celda, atributos
	func setupViews() {
    	backgroundColor = UIColor.whiteColor()
		
		//agregando el label de texto (nameLabel) dentro de la celda
		addSubview(nameLabel)
		//modificando la posicion del label mediante los constraints
		addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": nameLabel]))
		addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": nameLabel]))
		
		
	}
}
