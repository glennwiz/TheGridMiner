package gnipahellir

import "core:fmt"
import r "core:math/rand"
import rl "vendor:raylib"

CELL_SIZE :: 10
SCREEN_WIDTH :: 1000
SCREEN_HEIGHT :: 700

GRID :: [SCREEN_WIDTH / CELL_SIZE][SCREEN_HEIGHT / CELL_SIZE]Cell

Cell :: struct {
	x:    i32,
	y:    i32,
	type: Type,
}

Type :: enum {
	gold,
	silver,
	rock,
	crystal,
}

locx: i32 = 0
locy: i32 = 0

main :: proc() {
	fmt.println("the void is starting to close")

	rl.SetTraceLogLevel(.WARNING)
	rl.InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "The Grid Miner")


	//init the grid

	for i := 0; i < SCREEN_WIDTH; i += CELL_SIZE {
		for ii := 0; ii < SCREEN_HEIGHT; ii += CELL_SIZE {

			fmt.println("cell loc", i, ii)

			if (r.float64() < 0.1) {
				//gold cell
			}

			if (r.float64() > 0.1 && r.float64() < 0.3) {
				//silver cell
			}

			if (r.float64() > 0.3 && r.float64() < 0.5) {
				//crystal
			}

			if (r.float64() > 0.5) {
				//rock
			}
		}
	}


	for !rl.WindowShouldClose() {

		rl.BeginDrawing()
		rl.ClearBackground(rl.DARKPURPLE)

		rl.SetTargetFPS(60)

		//the plan:
		//fill the grid with diffrent kind og cell types, like gold, rock, crystals m.m

		grid_x: i32 = CELL_SIZE
		grid_y: i32 = CELL_SIZE

		for i in 0 ..< SCREEN_WIDTH {
			rl.DrawLine(grid_x, 0, grid_x, SCREEN_HEIGHT, rl.BLACK)

			grid_x += CELL_SIZE
		}

		for i in 0 ..< SCREEN_HEIGHT {
			rl.DrawLine(0, grid_y, SCREEN_WIDTH, grid_y, rl.BLACK)
			grid_y += CELL_SIZE
		}


		if (rl.IsKeyDown(.W)) {
			fmt.println("W pressed")
			locy -= 1
		}

		if (rl.IsKeyDown(.A)) {
			fmt.println("A pressed")
			locx -= 1
		}

		if (rl.IsKeyDown(.S)) {
			fmt.println("S pressed")
			locy += 1
		}

		if (rl.IsKeyDown(.D)) {
			fmt.println("D pressed")
			locx += 1
		}

		rl.DrawRectangle(locx, locy, CELL_SIZE, CELL_SIZE, rl.BLUE)
		rl.EndDrawing()
	}
}
