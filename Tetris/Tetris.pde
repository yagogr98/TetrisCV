//Filas y columnas del tablero.
int filas, columnas;
//Objeto figura
Figura figura;
// Cada cuadrado del tablero será un objeto de tipo cuadrado
Cuadrado[][] cuadrados;

void setup()
{
    //se permiten distintos tañamos de pantalla sin problema
  size(400, 800);
  //Numero de filas que se pintan, 
  filas = height / 25;
  //Numero de columnas
  columnas = width / 25;
  //Array que contendrá todos los cuadrados del tablero.
  cuadrados = new Cuadrado[columnas][filas];
  for (int i = 0; i < cuadrados.length; i++)
  {
    for (int j = 0; j < cuadrados[i].length; j++)
    {
      cuadrados[i][j] = new Cuadrado(i, j, false);
    }
  }
  //Nueva forma
  figura = new Figura();
}

//Clase Cuadrado
class Cuadrado
{
  //Saber si hay figura en el cuadrado o no
  boolean isForma;
  //Poscion del cuadrado en el tablero
  int x, y;
  //rellenaremos todos los cuadrados del mismo color excepto los que tengan figura
  color col;


  Cuadrado(int x, int y, boolean isForma)
  {
    this.x = x;
    this.y = y;
    this.isForma = isForma;
    col = color(0);
  }

  void show()
  {
    strokeWeight(1);
    if (isForma == true)
    {
      strokeWeight(3);
    }
    stroke(0);
    fill(col);
    rect(x * 25, y * 25, 25, 25);
  }
}

//Clase forma, hay diversos tipos de forma todas requieren de al menos cuatro
//cuadrados del tablero.
class Figura
{
  Cuadrado[] cuadradosForma = new Cuadrado[4]; 
  //Constructor por defecto, devuelve una nueva forma ( aleatoria )
  Figura()
  {
    nuevaFormaAleatoria();
  }
  //Envía la forma al fondo
  boolean abajo()
  {
    //Si choca no se mueve mas
    boolean valido = true;
    for (int i = 0; i < 4; i++)
    {
      if (cuadradosForma[i].y >= filas-1 || cuadrados[cuadradosForma[i].x][cuadradosForma[i].y+1].isForma)
      {
        valido = false;
        break;
      }
    }

    for (int i = 0; i < 4 && valido; i++)
    {
      cuadradosForma[i].y++;
    }

    if (valido == false)
    {
      for (int i = 0; i < 4; i++)
      {
        int ejex = cuadradosForma[i].x;
        int ejey = cuadradosForma[i].y;
        cuadrados[ejex][ejey].isForma = true;
        cuadrados[ejex][ejey].col = cuadradosForma[i].col;
      }
      nuevaFormaAleatoria();
    }
    return valido;
  }

  void nuevaFormaAleatoria()
  {
    //Todas las formas tienen al menos un cuadrado lleno..
    cuadradosForma[0] = new Cuadrado(columnas/2, 0, true); 
    //Generamos aleatorio
    int type = floor(random(7));
    //Según el aleatorio se generará un tipo de forma
    switch(type)
    {
    case 0:  //Cuadrado
      cuadradosForma[1] = new Cuadrado(columnas/2 - 1, 0, true);
      cuadradosForma[2] = new Cuadrado(columnas/2 - 1, -1, true);
      cuadradosForma[3] = new Cuadrado(columnas/2, -1, true);
      break;
    case 1: //J
      cuadradosForma[1] = new Cuadrado(columnas/2 - 1, -1, true);
      cuadradosForma[2] = new Cuadrado(columnas/2 - 1, 0, true);
      cuadradosForma[3] = new Cuadrado(columnas/2 + 1, 0, true);
      break;
    case 2: //Forma de L
      cuadradosForma[1] = new Cuadrado(columnas/2 - 1, 0, true);
      cuadradosForma[2] = new Cuadrado(columnas/2 + 1, -1, true);
      cuadradosForma[3] = new Cuadrado(columnas/2 + 1, 0, true);
      break;
    case 3: //Forma de I
      cuadradosForma[1] = new Cuadrado(columnas/2 - 2, 0, true);
      cuadradosForma[2] = new Cuadrado(columnas/2 - 1, 0, true);
      cuadradosForma[3] = new Cuadrado(columnas/2 + 1, 0, true);
      break;
    case 4: //S
      cuadradosForma[1] = new Cuadrado(columnas/2 - 1, 0, true);
      cuadradosForma[2] = new Cuadrado(columnas/2, -1, true);
      cuadradosForma[3] = new Cuadrado(columnas/2 + 1, -1, true);
      break;
    case 5: //T
      cuadradosForma[1] = new Cuadrado(columnas/2, -1, true);
      cuadradosForma[2] = new Cuadrado(columnas/2 - 1, -1, true);
      cuadradosForma[3] = new Cuadrado(columnas/2 + 1, -1, true);
      break;
    case 6: //Parecida a la Z
      cuadradosForma[1] = new Cuadrado(columnas/2 + 1, 0, true);
      cuadradosForma[2] = new Cuadrado(columnas/2, -1, true);
      cuadradosForma[3] = new Cuadrado(columnas/2 - 1, -1, true);
      break;
    }
    for (int i = 0; i < 4; i++)
    {
      //Los nuevos son blancos
      cuadradosForma[i].col = color(255);
      //Ponemos los cuadrados a true porque hay forma
      cuadradosForma[i].isForma = true;
    }
  }

  void gira()
  {
    boolean valido = true;
    //Giramos a partir del 1 ya que siempre hay un cuadrado de cada figura que no se mueve
    for (int i = 1; i < 4; i++) 
    {
      int nuevox = (cuadradosForma[i].x - cuadradosForma[0].x); //Giro
      int nuevoy = (cuadradosForma[i].y - cuadradosForma[0].y); //Giro
      int x = cuadradosForma[0].x + nuevoy; 
      int y = cuadradosForma[0].y - nuevox;
      if (x < 0 || x >= columnas || y < 0 || y >= filas || cuadrados[x][y].isForma == true)
      {
        //choque
        valido = false;
      }
    }
    //Giramos a partir del 1 ya que siempre hay un cuadrado de cada figura que no se mueve
    for (int i = 1; i < 4 && valido; i++) 
    {
      int dx = (cuadradosForma[i].x - cuadradosForma[0].x); //Giro
      int dy = (cuadradosForma[i].y - cuadradosForma[0].y); //Giro
      int x = cuadradosForma[0].x + dy;
      int y = cuadradosForma[0].y - dx;
      cuadradosForma[i].x = x;
      cuadradosForma[i].y = y;
    }
  }

  void derecha()
  {
    boolean valido = true;
    for (int i = 0; i < 4; i++)
    {
      if (cuadradosForma[i].y >= 0 && (cuadradosForma[i].x >= columnas - 1 || cuadrados[cuadradosForma[i].x+1][cuadradosForma[i].y].isForma))
      {
        //choque
        valido = false;
        break;
      }
    }

    for (int i = 0; i < 4 && valido; i++)
    {
      //Movemos a la derecha
      cuadradosForma[i].x++;
    }
  }


  void izquierda()
  {
    boolean valido = true;
    for (int i = 0; i < 4; i++)
    {
      //choque
      if (cuadradosForma[i].y >= 0 && (cuadradosForma[i].x <= 0 || cuadrados[cuadradosForma[i].x-1][cuadradosForma[i].y].isForma))
      {
        valido = false;
        break;
      }
    }

    for (int i = 0; i < 4 && valido; i++)
    {
      //Movemos a la izquierda
      cuadradosForma[i].x--;
    }
  }



  void suelo()
  {
    boolean valido = true;
    while (valido)
    {
      valido = abajo();
    }
  }

  void show()
  {
    for (int i = 0; i<4; i++)
    {
      cuadradosForma[i].show();
    }
  }
}
