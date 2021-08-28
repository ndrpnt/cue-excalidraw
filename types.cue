package types

#Point: [number, number]
#FillStyle:       "hachure" | "cross-hatch" | "solid"
#StrokeSharpness: "round" | "sharp"
#StrokeStyle:     "solid" | "dashed" | "dotted"
#TextAlign:       "left" | "center" | "right"
#VerticalAlign:   "top" | "middle"
#Arrowhead:       "arrow" | "bar" | "dot"
#PointBinding: {
	elementId: string
	focus:     number
	gap:       number
}

#ExcalidrawElementBase: {
	id:              string
	x:               number
	y:               number
	strokeColor:     string | *"#000000"
	backgroundColor: string | *"transparent"
	fillStyle:       #FillStyle | *"hachure"
	strokeWidth:     number | *1 // Thin = 1, Bold = 2, Extra Bold = 4
	strokeStyle:     #StrokeStyle | *"solid"
	strokeSharpness: #StrokeSharpness
	roughness:       number | *1 // Architect = 0, Artist = 1, Cartoonist = 2
	opacity:         number | *100
	width:           number
	height:          number
	angle:           number | *0
	// Random integer used to seed shape generation so that the roughjs shape
	// doesn't differ across renders.
	seed: number | *42
	// Integer that is sequentially incremented on each change. Used to reconcile
	// elements during collaboration or when saving to server.
	version?: number
	// Random integer that is regenerated on each change.
	// Used for deterministic reconciliation of updates during collaboration,
	// in case the versions (see above) are identical.
	versionNonce?: number
	isDeleted:     bool | *false
	// List of groups the element belongs to.
	// Ordered from deepest to shallowest.
	groupIds: [...string]
	// Ids of (linear) elements that are bound to this element.
	boundElementIds: [...string] | *null
	...
}

#ExcalidrawRectangleElement: #ExcalidrawElementBase & {
	type:            "rectangle"
	strokeSharpness: _ | *"sharp"
}

#ExcalidrawDiamondElement: #ExcalidrawElementBase & {
	type:            "diamond"
	strokeSharpness: _ | *"sharp"
}

#ExcalidrawEllipseElement: #ExcalidrawElementBase & {
	type:            "ellipse"
	strokeSharpness: _ | *"sharp"
}

#ExcalidrawTextElement: #ExcalidrawElementBase & {
	type:            "text"
	fontSize:        number | *20
	// Virgil = 1, Helvetica = 2, Cascadia = 3
	fontFamily:      int & >=1 & <=3 | *1
	text:            string
	baseline:        number | *18
	textAlign:       #TextAlign | *"left"
	verticalAlign:   #VerticalAlign | *"top"
	strokeSharpness: _ | *"sharp"
}

#ExcalidrawLineElement: #ExcalidrawElementBase & {
	type: "line"
	points: [#Point, #Point, ...#Point]
	lastCommittedPoint: #Point | *null
	startBinding:       #PointBinding | *null
	endBinding:         #PointBinding | *null
	startArrowhead:     null
	endArrowhead:       null
	strokeSharpness:    _ | *"round"
}

#ExcalidrawArrowElement: #ExcalidrawElementBase & {
	type: "arrow"
	points: [#Point, #Point, ...#Point]
	lastCommittedPoint: #Point | *null
	startBinding:       #PointBinding | *null
	endBinding:         #PointBinding | *null
	startArrowhead:     #Arrowhead | *null
	endArrowhead:       #Arrowhead | null | *"arrow"
	strokeSharpness:    _ | *"round"
}

#ExcalidrawFreeDrawElement: #ExcalidrawElementBase & {
	type: "freedraw"
	points: [...#Point]
	pressures: [...number]
	simulatePressure:   bool
	lastCommittedPoint: #Point | null
	strokeSharpness:    _ | *"round"
}

#ExcalidrawElement: #ExcalidrawRectangleElement | #ExcalidrawDiamondElement | #ExcalidrawEllipseElement | #ExcalidrawTextElement | #ExcalidrawLineElement | #ExcalidrawArrowElement | #ExcalidrawFreeDrawElement

#NonDeletedExcalidrawElement: #ExcalidrawElement & {
	isDeleted: false
}

#ExportedDataState: {
	type:    string | *"excalidraw"
	version: number | *2
	source:  string | *"github.com/ndrpnt/cue-excalidraw"
	elements: [...#ExcalidrawElement]
}

#ExportedLibraryData: {
	type:    string
	version: number
	source:  string
	library: [...#NonDeletedExcalidrawElement]
}
