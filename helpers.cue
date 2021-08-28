package helpers

import (
	"list"

	"github.com/ndrpnt/cue-excalidraw:types"
)

// #BoundingBox returns a pair of types.#Point from which a rectangle
// encompassing all the types.#Point given in #ps can be created.
//
// Example:
// points: [[-1, 7], [2, -3], [1, 5], [-7, 0]]
// box: #BoundingBox & {_, #ps: points}
// box: [[-7, -3], [2, 7]]
#BoundingBox: {
	#ps: [types.#Point, ...types.#Point]
	#xs: [ for p in #ps {p[0]}]
	#ys: [ for p in #ps {p[1]}]
	[
		[list.Min(#xs), list.Min(#ys)],
		[list.Max(#xs), list.Max(#ys)],
	]
} & [types.#Point, types.#Point]
