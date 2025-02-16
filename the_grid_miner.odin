package gnipahellir

import "core:fmt"
import rl "vendor:raylib"

CELL_SIZE :: 10
SCREEN_WIDTH :: 1000
SCREEN_HEIGHT :: 700

GRID :: [100][100]Cell

Cell :: struct {
	x: [10]i32,
	y: [10]i32,
}


locx: i32 = 0
locy: i32 = 0


Alive_Cells := [dynamic]Cell{}


main :: proc() {
	fmt.println("in the begining there was a void")

	rl.InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "The Grid Miner")

	for !rl.WindowShouldClose() {

		rl.BeginDrawing()

		rl.ClearBackground(rl.DARKPURPLE)

		//the plan:
		// 1 blue CELL_SIZE square top left corner that we 
		// can control with WSAD

		if (rl.IsKeyPressed(.W)) {
			fmt.println("W pressed")
			locy -= 1
		}

		if (rl.IsKeyPressed(.A)) {
			fmt.println("A pressed")
			locx -= 1
		}

		if (rl.IsKeyPressed(.S)) {
			fmt.println("S pressed")
			locy += 1
		}

		if (rl.IsKeyPressed(.D)) {
			fmt.println("D pressed")
			locx += 1
		}


		rl.DrawRectangle(locx, locy, CELL_SIZE, CELL_SIZE, rl.BLUE)

		rl.EndDrawing()
	}
}
