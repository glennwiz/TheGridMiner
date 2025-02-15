package gnipahellir

import "core:fmt"
import rl "vendor:raylib"

main :: proc() {
	fmt.println("in the begining there was a void")

	rl.InitWindow(1000, 1000, "The Grid Miner")

	for !rl.WindowShouldClose() {
		rl.BeginDrawing()

		rl.ClearBackground(rl.BLACK)


		//the grid draw


		//the movments


		//the grid updates


		rl.EndDrawing()
	}


}
