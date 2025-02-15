package gnipahellir

import "core:fmt"
import rl "vendor:raylib"

CELL_SIZE :: 10
SCREEN_WIDTH :: 1000
SCREEN_HEIGHT :: 700

main :: proc() {
	fmt.println("in the begining there was a void")

	rl.InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "The Grid Miner")

	for !rl.WindowShouldClose() {
		rl.BeginDrawing()

		rl.ClearBackground(rl.BLACK)
		fmt.println((SCREEN_HEIGHT / CELL_SIZE), "The Chunk size")

		rl.EndDrawing()
	}
}
