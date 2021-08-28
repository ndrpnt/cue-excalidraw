package types

#Point: [number, number]
#FillStyle:       "hachure" | "cross-hatch" | "solid"
#FontFamily:      "Virgil" | "Helvetica" | "Cascadia"
#StrokeSharpness: "round" | "sharp"
#StrokeStyle:     "solid" | "dashed" | "dotted"
#TextAlign:       "left" | "center" | "right"
#VerticalAlign:   "top" | "middle"
#Arrowhead:       "arrow" | "bar" | "dot"

#PointBinding: {
	elementId: #ExcalidrawBindableElement.id
	focus:     number
	gap:       number
}

#ExcalidrawElementBase: {
	id:              string
	x:               number
	y:               number
	strokeColor:     string
	backgroundColor: string
	fillStyle:       #FillStyle
	strokeWidth:     number
	strokeStyle:     #StrokeStyle
	strokeSharpness: #StrokeSharpness
	roughness:       number
	opacity:         number
	width:           number
	height:          number
	angle:           number
	// Random integer used to seed shape generation so that the roughjs shape
	// doesn't differ across renders.
	seed: number
	// Integer that is sequentially incremented on each change. Used to reconcile
	// elements during collaboration or when saving to server.
	version: number
	// Random integer that is regenerated on each change.
	// Used for deterministic reconciliation of updates during collaboration,
	// in case the versions (see above) are identical.
	versionNonce: number
	isDeleted:    bool
	// List of groups the element belongs to.
	// Ordered from deepest to shallowest.
	groupIds: [...string]
	// Ids of (linear) elements that are bound to this element.
	boundElementIds: [...#ExcalidrawLinearElement.id] | *null
	...
}

#ExcalidrawSelectionElement: #ExcalidrawElementBase & {
	type: "selection"
}

#ExcalidrawRectangleElement: #ExcalidrawElementBase & {
	type: "rectangle"
}

#ExcalidrawDiamondElement: #ExcalidrawElementBase & {
	type: "diamond"
}

#ExcalidrawEllipseElement: #ExcalidrawElementBase & {
	type: "ellipse"
}

#ExcalidrawGenericElement: #ExcalidrawSelectionElement | #ExcalidrawRectangleElement | #ExcalidrawDiamondElement | #ExcalidrawEllipseElement

#ExcalidrawElement: #ExcalidrawGenericElement | #ExcalidrawTextElement | #ExcalidrawLinearElement | #ExcalidrawFreeDrawElement

#NonDeletedExcalidrawElement: #ExcalidrawElement & {
	isDeleted: false
}

#ExcalidrawTextElement: #ExcalidrawElementBase & {
	type:          "text"
	fontSize:      number
	fontFamily:    #FontFamily
	text:          string
	baseline:      number
	textAlign:     #TextAlign
	verticalAlign: #VerticalAlign
}

#ExcalidrawBindableElement: #ExcalidrawRectangleElement | #ExcalidrawDiamondElement | #ExcalidrawEllipseElement | #ExcalidrawTextElement

#ExcalidrawLinearElement: #ExcalidrawElementBase & {
	type: "line" | "arrow"
	points: [...#Point]
	lastCommittedPoint: #Point | null
	startBinding:       #PointBinding | null
	endBinding:         #PointBinding | null
	startArrowhead:     #Arrowhead | null
	endArrowhead:       #Arrowhead | null
}

#ExcalidrawFreeDrawElement: #ExcalidrawElementBase & {
	type: "freedraw"
	points: [...#Point]
	pressures: [...number]
	simulatePressure:   bool
	lastCommittedPoint: #Point | null
}

#ExportedDataState: {
	type:    string
	version: number
	source:  string
	elements: [...#ExcalidrawElement]
}

#ExportedLibraryData: {
	type:    string
	version: number
	source:  string
	library: [...#NonDeletedExcalidrawElement]
}
