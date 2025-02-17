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
	life:    rune,
	x:       i32,
	y:       i32,
	type:    Type,
	visible: bool,
}
list_of_voids: [dynamic]^Cell

Type :: enum {
	gold,
	silver,
	rock,
	crystal,
	void,
}

debug_vals :: struct {
	x:    i32,
	y:    i32,
	type: Type,
}

vector2 :: struct {
	x: i32,
	y: i32,
}

locations :: struct {
	range: [3]vector2,
}

loc_data: locations

locx: i32 = 0
locy: i32 = 0

main :: proc() {
	fmt.println("void closed")

	rl.SetTraceLogLevel(.WARNING)
	rl.InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "The Grid Miner")
	rl.SetTargetFPS(60)

	locx = SCREEN_WIDTH / 2
	locy = SCREEN_HEIGHT / 2
	//init the grid
	for i: i32 = 0; i < SCREEN_WIDTH / CELL_SIZE; i += 1 {
		for ii: i32 = 0; ii < SCREEN_HEIGHT / CELL_SIZE; ii += 1 {


			valx := (locx / 10) - i
			valy := (locy / 10) - ii

			//if we are close to the controled sqare we skip creating cell there
			if valx < 4 && math.abs(valy) < 4 {
				if valy < 4 && math.abs(valx) < 4 {

					c: Cell
					c.x = i
					c.y = ii
					c.life = 0
					c.type = .void
					c.visible = true


					grid[i][ii] = c

					append(&list_of_voids, &grid[i][ii])
					continue
				}
			}

			theNum := r.float64()

			c: Cell
			c.x = i
			c.y = ii
			c.visible = false

			if (theNum < 0.03) {
				c.type = .gold
				c.life = 200
			} else if (theNum < 0.1) {
				c.type = .silver
				c.life = 100
			} else if (theNum < 0.2) {
				c.type = .crystal
				c.life = 20
			} else {
				c.type = .rock
				c.life = 10
			}
			grid[i][ii] = c
		}
	}

	for !rl.WindowShouldClose() {

		rl.BeginDrawing()
		rl.ClearBackground(rl.BLACK)

		grid_x: i32 = CELL_SIZE
		grid_y: i32 = CELL_SIZE

		// The plan: ???

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

				if cell.visible == false {

					rl.DrawRectangle(cell.x * 10, cell.y * 10, CELL_SIZE, CELL_SIZE, rl.DARKGRAY)

					continue

				}

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
				if (cell.type == .void) {
					rl.DrawRectangle(
						cell.x * 10,
						cell.y * 10,
						CELL_SIZE - 2,
						CELL_SIZE - 2,
						rl.BLACK,
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
		set_visible_cells()


		rl.DrawRectangle(locx, locy, CELL_SIZE, CELL_SIZE, {40, 85, 120, 255})
		rl.EndDrawing()
	}
}

d: debug_vals
check_player_cell_bounds :: proc() {

	//player loc
	x := locx / 10
	y := locy / 10

	c := &grid[x][y]

	if d.x != x || d.y != y {
		fmt.println("player loc", x, y)

		d.x = x
		d.y = y
		fmt.println("type", c.type)

	}

	xz: i32 = check_for_the_mined_cell()

	if (xz <= 0) {
		append(&list_of_voids, c)
		c.type = .void
	}
}

set_visible_cells :: proc() {

	//cells that are next to void should always be visible
	for c in 0 ..< len(list_of_voids) {

		cc := list_of_voids[c]

		(grid[cc.x - 1][cc.y]).visible = true
		(grid[cc.x][cc.y - 1]).visible = true
		(grid[cc.x + 1][cc.y]).visible = true

		(grid[cc.x][cc.y + 1]).visible = true

	}
}


check_for_the_mined_cell :: proc() -> i32 {

	//the plan: we want to keep track of last location before we touch a rock, if we touch a rock we should 'hit' maybe move back to the last known loc and yello flash?
	//player loc
	x := locx / 10
	y := locy / 10

	//keep track of 3 last pos
	loc_data.range[2] = loc_data.range[1]
	loc_data.range[1] = loc_data.range[0]
	loc_data.range[0] = {x, y}

	return 0

}
