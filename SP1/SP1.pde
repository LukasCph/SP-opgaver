/**
 * Array 2D. 
 * 
 * Demonstrates the syntax for creating a two-dimensional (2D) array.
 * Values in a 2D array are accessed through two index values.  
 * 2D arrays are useful for storing images. In this example, each dot 
 * is colored in relation to its distance from the center of the image. 
 */

import java.util.Random;

// Smaller grid to fit my screen resolution
Game game = new Game(18, 18, 8, 100);
PFont font;
int num=1;

public void settings() {
  size(801, 821);
}

void setup()
{
  frameRate(12);
  font = createFont("Arial", 18, true);
  textFont(font, 18);
}

void keyReleased()
{
  game.onKeyReleased(key);
  game.onKeyTwoReleased();
}

void keyPressed()
{
  game.onKeyPressed(key);
  game.onKeyTwoPressed();
}

void draw()
{
  textAlign(CORNER);
  if (num==1) {
    game.update();
    background(0); //Black
    // This embedded loop skips over values in the arrays based on
    // the spacer variable, so there are more values in the array
    // than are drawn here. Change the value of the spacer variable
    // to change the density of the points
    int[][] board = game.getBoard();
    for (int y = 0; y < game.getHeight(); y++)
    {
      for (int x = 0; x < game.getWidth(); x++)
      {
        if (board[x][y] == 0)
        {
          fill(0, 0, 0);
        } else if (board[x][y] == 1)
        {
          fill(0, 0, 255);
        } else if (board[x][y] == 2)
        {
          fill(255, 0, 0);
        } else if (board[x][y] == 3)
        {
          fill(0, 255, 0);
        } else if (board[x][y]==4)
        {
          fill(255, 255, 0);
        }
        stroke(100, 100, 100);
        rect(x*40, y*40, 40, 40);
      }
    }
    fill(255);
    text("Player 1", 725, 25);
    text("\nLife: "+game.getPlayerLife(), 725, 30);
    text("\nScore: "+game.playerScore, 725, 50);

    text("Player 2", 725, 225);
    text("\nLife: "+game.getPlayerTwoLife(), 725, 230);
    text("\nScore: "+game.playerTwoScore, 725, 250);
  }
  playerGameOver();
  playerTwoGameOver();
  restartGame();
}

//player one runs out of life
void playerGameOver() {
  if (game.playerLife<=0) {
    background(0); 
    fill(255);
    textAlign(CENTER);
    font = createFont("Arial", 40, true);
    textFont(font, 40);
    text("Player 1 has died!", 400, 200);
    textFont(font, 20);
    text("\n Current score is: \n Player 1: "+ game.playerScore +"\n Player 2: " +game.playerTwoScore, 400, 250);
    textFont(font, 16);
    text("press 'r' to resume the game", 400, 450);

    //move enemies to corner
    for (int i = 0; i < game.enemies.length; ++i)
    {
      game.enemies[i].moveRight();
      game.enemies[i].moveDown();
      game.enemies[i].moveRight();
      game.enemies[i].moveDown();
    }
    num=0;
  }
}

//player two runs out of life
void playerTwoGameOver() {
  if (game.playerTwoLife<=0) {
    background(0); 
    fill(255);
    textAlign(CENTER);
    font = createFont("Arial", 40, true);
    textFont(font, 40);
    text("Player 2 has died!", 400, 200);
    textFont(font, 20);
    text("\n Current score is: \n Player 1: "+ game.playerScore +"\n Player 2: " +game.playerTwoScore, 400, 250);
    text("\n Current score is: \n Player 1: "+ game.playerScore +"\n Player 2: " +game.playerTwoScore, 400, 250);
    textFont(font, 16);
    text("press 'r' to resume the game", 400, 450);
    num=0;

    //move enemies to corner
    for (int i = 0; i < game.enemies.length; ++i)
    {
      game.enemies[i].moveRight();
      game.enemies[i].moveDown();
      game.enemies[i].moveRight();
      game.enemies[i].moveDown();
    }
  }
}

void restartGame() {
  if (key== 'r' && game.playerLife<=0 || key== 'r' && game.playerTwoLife<=0) {
    game.playerTwoLife=100;
    game.playerLife=100;
    game.populateBoard();
    num=1;
  }
}
