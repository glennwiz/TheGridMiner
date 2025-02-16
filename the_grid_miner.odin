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

			theNum := r.float64()
			c: Cell
			c.x = i
			c.y = ii

			//fmt.println("creating cell", theNum)
			if (theNum < 0.1) {
				c.type = .gold
				fmt.println("-")
			}

			if (theNum > 0.1 && theNum < 0.3) {
				c.type = .silver
				fmt.println("--")
			}

			if (theNum > 0.3 && theNum < 0.5) {
				c.type = .crystal
				fmt.println("---")
			}

			if (theNum > 0.5) {
				c.type = .rock
				fmt.println("----")
			}
			grid[i][ii] = c
		}
	}


	for !rl.WindowShouldClose() {

		rl.BeginDrawing()
		rl.ClearBackground(rl.DARKPURPLE)

		rl.SetTargetFPS(60)
		grid_x: i32 = CELL_SIZE
		grid_y: i32 = CELL_SIZE


		//the plan:
		// Draw a small circle for gold and silver, a small sqare for rock, an a polyline for a crystal
		// at loc for the cell
		for i in 0 ..< SCREEN_WIDTH {
			rl.DrawLine(grid_x, 0, grid_x, SCREEN_HEIGHT, rl.BLACK)

			grid_x += CELL_SIZE
		}

		for i in 0 ..< SCREEN_HEIGHT {
			rl.DrawLine(0, grid_y, SCREEN_WIDTH, grid_y, rl.BLACK)
			grid_y += CELL_SIZE
		}


		for x in 0 ..< SCREEN_WIDTH / CELL_SIZE {
			for y in 0 ..< SCREEN_HEIGHT / CELL_SIZE {
				cell := &grid[x][y]

				if (cell.type == .gold) {
					rl.DrawCircle(
						cell.x * 10 + (CELL_SIZE / 2),
						cell.y * 10 + (CELL_SIZE / 2),
						(CELL_SIZE / 2) / 2,
						rl.GOLD,
					)
				}
				if (cell.type == .silver) {
					rl.DrawCircle(
						cell.x * 10 + (CELL_SIZE / 2),
						cell.y * 10 + (CELL_SIZE / 2),
						(CELL_SIZE / 2) / 2,
						rl.GRAY,
					)
				}

				if (cell.type == .crystal) {
					rl.DrawCircle(
						cell.x * 10 + (CELL_SIZE / 2),
						cell.y * 10 + (CELL_SIZE / 2),
						(CELL_SIZE / 2) / 2,
						rl.SKYBLUE,
					)

				}
				if (cell.type == .rock) {
					rl.DrawCircle(
						cell.x * 10 + (CELL_SIZE / 2),
						cell.y * 10 + (CELL_SIZE / 2),
						(CELL_SIZE / 2) / 2,
						rl.DARKGRAY,
					)

				}
			}
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
