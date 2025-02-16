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


Alive_Cells := [dynamic]Cell{}


main :: proc() {
	fmt.println("in the begining there was a void")

	rl.InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "The Grid Miner")

	for !rl.WindowShouldClose() {
		rl.BeginDrawing()

		rl.ClearBackground(rl.BLACK)
		fmt.println((SCREEN_HEIGHT / CELL_SIZE), "The Chunk size")

		//the plan:
		// 1 blue CELL_SIZE square top left corner that we 
		// can control with WSAD

		locx: i32 = 0
		locy: i32 = 0

		rl.DrawRectangle(locx, locy, 10, 10, rl.BLUE)

		rl.EndDrawing()
	}
}
