import java.util.Random;

class Game
{
  private Random rnd;
  private int width;
  private int height;
  private int[][] board;
  private Keys keys;
  private int playerLife;
  private Dot player;
  private Dot playerTwo;
  private int playerTwoLife;
  private Dot[] healthPacks;
  private Dot[] enemies;
  private int healthPackCount=0;
  private int playerScore=0;
  private int playerTwoScore=0;


  Game(int width, int height, int numberOfEnemies, int numberOfHealthPacks)
  {
    if (width < 10 || height < 10)
    {
      throw new IllegalArgumentException("Width and height must be at least 10");
    }
    if (numberOfEnemies < 0)
    {
      throw new IllegalArgumentException("Number of enemies must be positive");
    } 
    this.rnd = new Random();
    this.board = new int[width][height];
    this.width = width;
    this.height = height;
    keys = new Keys();
    player = new Dot(6, 0, width-1, height-1);
    playerTwo = new Dot(0, 6, width-1, height-1);

    //healthpacks
    healthPacks = new Dot[numberOfHealthPacks];
    for (int i = 0; i < numberOfHealthPacks; ++i)
    {
      healthPacks[i] = new Dot(int(random(18)), int(random(18)), width-1, height-1);
    }

    //enemies
    enemies = new Dot[numberOfEnemies];
    for (int i = 0; i < numberOfEnemies; ++i)
    {
      enemies[i] = new Dot(width-1, height-1, width-1, height-1);
    }
    this.playerLife = 100;
    this.playerTwoLife = 100;
  }

  public int getWidth()
  {
    return width;
  }

  public int getHeight()
  {
    return height;
  }

  public int getPlayerLife()
  {
    return playerLife;
  }

  public int getPlayerTwoLife()
  {
    return playerTwoLife;
  }

  public void onKeyPressed(char ch)
  {
    keys.onKeyPressed(ch);
  }

  public void onKeyReleased(char ch)
  {
    keys.onKeyReleased(ch);
  }

  public void onKeyTwoPressed()
  {
    keys.onKeyTwoPressed();
  }

  public void onKeyTwoReleased()
  {
    keys.onKeyTwoReleased();
  }

  public void update()
  {
    updatePlayer();
    updatePlayerTwo();
    updateEnemies();
    updateHealthPacks();
    checkForCollisions();
    clearBoard();
    populateBoard();
  }

  public int[][] getBoard()
  {
    //ToDo: Defensive copy?
    return board;
  }

  private void clearBoard()
  {
    for (int y = 0; y < height; ++y)
    {
      for (int x = 0; x < width; ++x)
      {
        board[x][y]=0;
      }
    }
  }

  private void updatePlayer()
  {
    //Update player one
    if (keys.wDown() && !keys.sDown())
    {
      player.moveUp();
    }
    if (keys.aDown() && !keys.dDown())
    {
      player.moveLeft();
    }
    if (keys.sDown() && !keys.wDown())
    {
      player.moveDown();
    }
    if (keys.dDown() && !keys.aDown())
    {
      player.moveRight();
    }
  }
  private void updatePlayerTwo() {
    //update player two
    if (keys.upHeldDown() && !keys.downHeldDown())
    {
      playerTwo.moveUp();
    }
    if (keys.leftHeldDown() && !keys.rightHeldDown())
    {
      playerTwo.moveLeft();
    }
    if (keys.downHeldDown() && !keys.upHeldDown())
    {
      playerTwo.moveDown();
    }
    if (keys.rightHeldDown && !keys.leftHeldDown())
    {
      playerTwo.moveRight();
    }
  }
  
//move healthpacks
private void updateHealthPacks()
  {for (int i = 0; i < healthPacks.length; ++i)
    {
      //Should we run or move randomly?
      //2 out of 3 we will follow..
      if (rnd.nextInt(4) < 3)
      {
        //We run
        int dx = player.getX() - healthPacks[i].getX();
        int dy = player.getY() - healthPacks[i].getY();
        int dxTwo = playerTwo.getX() - healthPacks[i].getX();
        int dyTwo = playerTwo.getY() - healthPacks[i].getY();

        if (abs(dx) > abs(dy)||abs(dxTwo) > abs(dyTwo))
        {
          if (dx > 0 || dxTwo > 0 || dx > 0 && dxTwo > 0 )
          {
            //Players are to the right
            healthPacks[i].moveLeft();
          } else
          {
            //Players are to the left
            healthPacks[i].moveRight();
          }
        } else if (dy > 0 || dyTwo > 0 || dy > 0 && dyTwo > 0)
        {
          //Players are down;
          healthPacks[i].moveUp();
        } else
        {//Player are up;
          healthPacks[i].moveDown();
        }
      } else
      {
        //We move randomly
        int move = rnd.nextInt(4);
        if (move == 0)
        {
          //Move right
          healthPacks[i].moveRight();
        } else if (move == 1)
        {
          //Move left
          healthPacks[i].moveLeft();
        } else if (move == 2)
        {
          //Move up
          healthPacks[i].moveUp();
        } else if (move == 3)
        {
          //Move down
          healthPacks[i].moveDown();
        }
      }
    }
  }

//move enemies
  private void updateEnemies()
  {
    for (int i = 0; i < enemies.length; ++i)
    {
      //Should we follow or move randomly?
      //2 out of 3 we will follow..
      if (rnd.nextInt(4) < 3)
      {
        //We follow
        int dx = player.getX() - enemies[i].getX();
        int dy = player.getY() - enemies[i].getY();
        int dxTwo = playerTwo.getX() - enemies[i].getX();
        int dyTwo = playerTwo.getY() - enemies[i].getY();

        if (abs(dx) > abs(dy)||abs(dxTwo) > abs(dyTwo))
        {
          if (dx > 0 || dxTwo > 0 || dx > 0 && dxTwo > 0 )
          {
            //Players are to the right
            enemies[i].moveRight();
          } else
          {
            //Players are to the left
            enemies[i].moveLeft();
          }
        } else if (dy > 0 || dyTwo > 0 || dy > 0 && dyTwo > 0)
        {
          //Players are down;
          enemies[i].moveDown();
        } else
        {//Player are up;
          enemies[i].moveUp();
        }
      } else
      {
        //We move randomly
        int move = rnd.nextInt(4);
        if (move == 0)
        {
          //Move right
          enemies[i].moveRight();
        } else if (move == 1)
        {
          //Move left
          enemies[i].moveLeft();
        } else if (move == 2)
        {
          //Move up
          enemies[i].moveUp();
        } else if (move == 3)
        {
          //Move down
          enemies[i].moveDown();
        }
      }
    }
  }

  private void populateBoard()
  {
    //Insert player
    board[player.getX()][player.getY()] = 1;
    board[playerTwo.getX()][playerTwo.getY()] = 4;

    //Insert healthpacks
    for (int i = 0; i < healthPacks.length; ++i) 
    {
      board[healthPacks[healthPackCount].getX()][healthPacks[healthPackCount].getY()] = 3;
    }
    //Insert enemies
    for (int i = 0; i < enemies.length; ++i)
    {
      board[enemies[i].getX()][enemies[i].getY()] = 2;
    }
  }
  private void checkForCollisions()
  {
    //Check enemy collisions
    for (int i = 0; i < enemies.length; ++i)
    {
      if (enemies[i].getX() == player.getX() && enemies[i].getY() == player.getY())
      {
        //We have a collision (player one)
        --playerLife;
      }
      if (enemies[i].getX() == playerTwo.getX() && enemies[i].getY() == playerTwo.getY())
      {
        //We have a collision (player two)
        --playerTwoLife;
      }
    }

    if (healthPacks[healthPackCount].getX() == player.getX() && healthPacks[healthPackCount].getY() == player.getY())
    {
      playerLife+=10;
      playerScore++;
      healthPackCount++;
    }

    if (healthPacks[healthPackCount].getX() == playerTwo.getX() && healthPacks[healthPackCount].getY() == playerTwo.getY())
    {
      playerTwoLife+=10;
      playerTwoScore++;
      healthPackCount++;
    }
    
  if (playerLife<=0) {
    playerTwoScore+=10;
  }

  if (playerTwoLife<=0) {
    playerScore+=10;
  }
  
  if (playerLife>100){
    playerLife=100;
  }
  
  if (playerTwoLife>100){
    playerTwoLife=100;
  }
  }
}
