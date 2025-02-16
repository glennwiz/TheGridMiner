package gnipahellir

import "core:fmt"
import "core:math"
import r "core:math/rand"
import rl "vendor:raylib"

CELL_SIZE :: 10
SCREEN_WIDTH :: 1000
SCREEN_HEIGHT :: 700

GRID :: [SCREEN_WIDTH / CELL_SIZE][SCREEN_HEIGHT / CELL_SIZE]Cell
grid: GRID
Cell :: struct {
	life: rune,
	x:    i32,
	y:    i32,
	type: Type,
}

Type :: enum {
	gold,
	silver,
	rock,
	crystal,
	void,
}

locx: i32 = 0
locy: i32 = 0

debug_vals :: struct {
	x: i32,
	y: i32,
}

main :: proc() {
	fmt.println("void closed")

	rl.SetTraceLogLevel(.WARNING)
	rl.InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "The Grid Miner")


	locx = SCREEN_WIDTH / 2
	locy = SCREEN_HEIGHT / 2
	//init the grid
	for i: i32 = 0; i < SCREEN_WIDTH / CELL_SIZE; i += 1 {
		for ii: i32 = 0; ii < SCREEN_HEIGHT / CELL_SIZE; ii += 1 {

			valx := (locx / 10) - i
			valy := (locy / 10) - ii
			//			fmt.println("----------------------------------------", valx)
			//			fmt.println("----------------------------------------_", valy)

			//if we are close to the controled sqare we skip creating cell there
			if valx < 4 && math.abs(valy) < 4 {
				if valy < 4 && math.abs(valx) < 4 {

					fmt.println("---------------------------------------- x", valx)
					fmt.println("---------------------------------------- y", valy)

					c: Cell
					c.x = i
					c.y = ii
					c.life = 0
					c.type = .void
					grid[i][ii] = c

					continue
				}
			}


			theNum := r.float64()
			c: Cell
			c.x = i
			c.y = ii


			if (theNum < 0.1) {
				c.type = .gold
				c.life = 200
			}

			if (theNum > 0.1 && theNum < 0.3) {
				c.type = .silver
				c.life = 100
			}

			if (theNum > 0.3 && theNum < 0.5) {
				c.type = .crystal
				c.life = 20
			}

			if (theNum > 0.5) {
				c.type = .rock
				c.life = 10
			}

			grid[i][ii] = c
		}
	}


	for !rl.WindowShouldClose() {

		rl.BeginDrawing()
		rl.ClearBackground(rl.BLACK)

		rl.SetTargetFPS(60)
		grid_x: i32 = CELL_SIZE
		grid_y: i32 = CELL_SIZE


		// The plan:


		// the X grid draw
		for i in 0 ..< SCREEN_WIDTH {
			rl.DrawLine(grid_x, 0, grid_x, SCREEN_HEIGHT, rl.BLACK)

			grid_x += CELL_SIZE
		}
		// the Y grid draw
		for i in 0 ..< SCREEN_HEIGHT {
			rl.DrawLine(0, grid_y, SCREEN_WIDTH, grid_y, rl.BLACK)
			grid_y += CELL_SIZE
		}

		// cell drawing
		for x in 0 ..< SCREEN_WIDTH / CELL_SIZE {
			for y in 0 ..< SCREEN_HEIGHT / CELL_SIZE {
				cell := &grid[x][y]

				if (cell.type == .gold) {
					rl.DrawCircle(
						cell.x * 10 + (CELL_SIZE / 2) - 1,
						cell.y * 10 + (CELL_SIZE / 2) - 1,
						(CELL_SIZE / 2) / 2,
						rl.GOLD,
					)
				}
				if (cell.type == .silver) {
					rl.DrawCircle(
						cell.x * 10 + (CELL_SIZE / 2) - 1,
						cell.y * 10 + (CELL_SIZE / 2) - 1,
						(CELL_SIZE / 2) / 2,
						rl.GRAY,
					)
				}

				if (cell.type == .crystal) {
					rl.DrawCircle(
						cell.x * 10 + (CELL_SIZE / 2) - 1,
						cell.y * 10 + (CELL_SIZE / 2) - 1,
						(CELL_SIZE / 2) / 2,
						rl.SKYBLUE,
					)
				}

				if (cell.type == .rock) {
					rl.DrawRectangle(
						cell.x * 10,
						cell.y * 10,
						CELL_SIZE - 2,
						CELL_SIZE - 2,
						rl.DARKGRAY,
					)
				}
			}
		}

		if (rl.IsKeyDown(.W)) {
			locy -= 1
		}

		if (rl.IsKeyDown(.A)) {
			locx -= 1
		}

		if (rl.IsKeyDown(.S)) {
			locy += 1
		}

		if (rl.IsKeyDown(.D)) {
			locx += 1
		}

		check_player_cell_bounds()

		rl.DrawRectangle(locx, locy, CELL_SIZE, CELL_SIZE, {40, 85, 120, 255})
		rl.EndDrawing()
	}
}

check_player_cell_bounds :: proc() {

	//player loc
	x := locx / 10
	y := locy / 10

	fmt.println("player loc", x, y)

	c := grid[x][y]
	fmt.println("type", c.type)

}
