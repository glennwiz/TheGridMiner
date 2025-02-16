package gnipahellir

import "core:fmt"
import r "core:math/rand"
import rl "vendor:raylib"

CELL_SIZE :: 10
SCREEN_WIDTH :: 1000
SCREEN_HEIGHT :: 700

GRID :: [SCREEN_WIDTH / CELL_SIZE][SCREEN_HEIGHT / CELL_SIZE]Cell
grid: GRID
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

	for i: i32 = 0; i < SCREEN_WIDTH / CELL_SIZE; i += 1 {
		for ii: i32 = 0; ii < SCREEN_HEIGHT / CELL_SIZE; ii += 1 {

			fmt.println("cell loc", i, ii)

			theNum := r.float64()
			c: Cell
			c.x = i
			c.y = ii


			if (theNum < 0.1) {
				c.type = .gold
			}

			if (theNum > 0.1 && theNum < 0.3) {
				c.type = .silver
			}

			if (theNum > 0.3 && theNum < 0.5) {
				c.type = .crystal
			}

			if (theNum > 0.5) {
				c.type = .rock
			}
			fmt.println("cell type", c.type)
			grid[i][ii] = c
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
