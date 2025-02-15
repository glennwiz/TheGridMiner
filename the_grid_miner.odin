package gnipahellir

import "core:fmt"
import "vendor:raylib"

main :: proc() {
	fmt.println("in the begining there was a void")

	raylib.InitWindow(1000, 1000, "The Grid Miner")

	for {
		raylib.BeginDrawing()
		raylib.ClearBackground(raylib.BLACK)
		raylib.EndDrawing()
	}
}
