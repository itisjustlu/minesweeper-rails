# Minesweeper Rails app

Demo: https://fast-brook-21909.herokuapp.com/

### Important notes
App consist in two specifics models, boards and cells.
We need to define rows and columns for boards, and we will trigger all cells we need in
order to build minesweeper game.

User have the ability to mark, flag and reveal cells, and each cell will store mines_around.

Board has multiple states: created, playing, lost, won. Each state represent the current status of the board.
We trigger finished_at after you lose or win.

Mines are randomly created, after we create cells, we make a random query in order to set mines.

web-app was done with create-react-app, we can spend more time improving auth, design, etc.

Let's play