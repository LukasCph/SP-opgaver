class Keys
{
  private boolean wHeldDown = false;
  private boolean aHeldDown = false;
  private boolean sHeldDown = false;
  private boolean dHeldDown = false;

  private boolean upHeldDown = false;
  private boolean leftHeldDown = false;
  private boolean downHeldDown = false;
  private boolean rightHeldDown = false;

  public Keys() {
  }
  //player one
  public boolean wDown()
  {
    return wHeldDown;
  }

  public boolean aDown()
  {
    return aHeldDown;
  }

  public boolean sDown()
  {
    return sHeldDown;
  }

  public boolean dDown()
  {
    return dHeldDown;
  }

  //player two
  public boolean upHeldDown()
  {
    return upHeldDown;
  }

  public boolean leftHeldDown()
  {
    return leftHeldDown;
  }

  public boolean downHeldDown()
  {
    return downHeldDown;
  }

  public boolean rightHeldDown()
  {
    return rightHeldDown;
  }


  //player one 
  void onKeyPressed(char ch)
  {

    if (ch == 'W' | ch == 'w')
    {
      wHeldDown = true;
    } else if (ch == 'A' || ch == 'a')
    {
      aHeldDown = true;
    } else if (ch == 'S' || ch == 's')
    {
      sHeldDown = true;
    } else if (ch == 'D' || ch == 'd')
    {
      dHeldDown = true;
    }
  }
  
  //player two 
  void onKeyTwoPressed()
  {
    if (key == CODED)
    {
      if (keyCode==UP) {
        upHeldDown = true;
      }
    }

    if (key == CODED)
    {
      if (keyCode==LEFT) {
        leftHeldDown = true;
      }
    }   

    if (key == CODED)
    {
      if (keyCode==DOWN) {
        downHeldDown = true;
      }
    }

    if (key == CODED)
    {
      if (keyCode==RIGHT) {
        rightHeldDown = true;
      }
    }
  }


  void onKeyReleased(char ch)
  {
    if (ch == 'W' || ch == 'w')
    {
      wHeldDown = false;
    } else if (ch == 'A' || ch == 'a')
    {
      aHeldDown = false;
    } else if (ch == 'S' || ch == 's')
    {
      sHeldDown = false;
    } else if (ch == 'D' || ch == 'd')
    {
      dHeldDown = false;
    }
  }

  //player two 
  void onKeyTwoReleased()
  {

    if (key == CODED)
    {
      if (keyCode==UP) {
        upHeldDown = false;
      }
    }

    if (key == CODED)
    {
      if (keyCode==LEFT) {
        leftHeldDown = false;
      }
    }   

    if (key == CODED)
    {
      if (keyCode==DOWN) {
        downHeldDown = false;
      }
    }

    if (key == CODED)
    {
      if (keyCode==RIGHT) {
        rightHeldDown = false;
      }
    }
  }
}
