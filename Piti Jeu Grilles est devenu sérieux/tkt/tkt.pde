import java.net.*;
import java.io.*;
import java.nio.*;

color backgroundColor = #6FE8FF;

int[] tweakmode_int = new int[256];
float[] tweakmode_float = new float[14];
TweakModeServer tweakmode_Server;

void tweakmode_initAllVars() {
  tweakmode_int[0] = 2;
  tweakmode_int[1] = 2;
  tweakmode_int[2] = 2;
  tweakmode_int[3] = 2;
  tweakmode_float[0] = 0.5;
  tweakmode_int[4] = 100;
  tweakmode_int[5] = 100;
  tweakmode_float[1] = 0.7;
  tweakmode_int[7] = 100;
  tweakmode_int[8] = 10;
  tweakmode_int[9] = 255;
  tweakmode_float[2] = 0.7;
  tweakmode_int[12] = 100;
  tweakmode_int[13] = 8;
  tweakmode_int[15] = 3;
  tweakmode_int[238] = #4D4D4D;
  tweakmode_int[16] = 1;
  tweakmode_int[239] = #6A6A6A;
  tweakmode_int[17] = 1;
  tweakmode_int[240] = #6A6A6A;
  tweakmode_int[18] = 1;
  tweakmode_int[241] = #6A6A6A;
  tweakmode_int[19] = 1;
  tweakmode_int[242] = #6A6A6A;
  tweakmode_int[20] = 125;
  tweakmode_int[21] = 50;
  tweakmode_int[243] = #C1943E;
  tweakmode_int[22] = 50;
  tweakmode_int[23] = 100;
  tweakmode_int[244] = #CB7533;
  tweakmode_int[24] = 100;
  tweakmode_int[25] = 200;
  tweakmode_int[245] = #B6C4C6;
  tweakmode_int[26] = 200;
  tweakmode_int[27] = 400;
  tweakmode_int[246] = #8E6666;
  tweakmode_int[28] = 400;
  tweakmode_int[29] = 800;
  tweakmode_int[247] = #554EB4;
  tweakmode_int[30] = 800;
  tweakmode_int[248] = #FF15F4;
  tweakmode_int[35] = 50;
  tweakmode_int[37] = 1;
  tweakmode_int[249] = #FF5E00;
  tweakmode_int[38] = 8;
  tweakmode_int[39] = 5;
  tweakmode_int[41] = 60;
  tweakmode_int[42] = 5000;
  tweakmode_int[45] = 2;
  tweakmode_int[46] = 2;
  tweakmode_int[49] = 3;
  tweakmode_int[51] = 50;
  tweakmode_int[53] = 1;
  tweakmode_int[54] = 255;
  tweakmode_int[55] = 20;
  tweakmode_int[56] = 2;
  tweakmode_int[57] = 2;
  tweakmode_int[58] = 5;
  tweakmode_int[62] = 10;
  tweakmode_int[65] = 100;
  tweakmode_int[66] = 500;
  tweakmode_int[67] = 7;
  tweakmode_int[68] = 7;
  tweakmode_int[69] = 50;
  tweakmode_int[70] = 10;
  tweakmode_int[71] = 10;
  tweakmode_int[72] = 50;
  tweakmode_int[73] = 50;
  tweakmode_int[74] = 50;
  tweakmode_int[75] = 10;
  tweakmode_int[76] = 1;
  tweakmode_int[77] = 1;
  tweakmode_int[78] = -1;
  tweakmode_int[83] = 2;
  tweakmode_int[84] = 7;
  tweakmode_int[85] = 8;
  tweakmode_int[86] = 100;
  tweakmode_int[87] = 20;
  tweakmode_int[91] = 100;
  tweakmode_int[92] = 50;
  tweakmode_int[93] = 255;
  tweakmode_int[95] = 20;
  tweakmode_int[96] = 9;
  tweakmode_int[97] = 40;
  tweakmode_int[100] = 1;
  tweakmode_int[101] = 2;
  tweakmode_int[102] = 3;
  tweakmode_int[103] = 2;
  tweakmode_int[104] = 15;
  tweakmode_int[105] = 16;
  tweakmode_int[106] = 50;
  tweakmode_int[107] = 50;
  tweakmode_int[108] = 50;
  tweakmode_int[109] = 125;
  tweakmode_int[110] = 2;
  tweakmode_int[112] = 2;
  tweakmode_int[113] = 4;
  tweakmode_int[114] = 125;
  tweakmode_int[115] = 2;
  tweakmode_int[116] = 255;
  tweakmode_int[117] = 10;
  tweakmode_int[119] = 2;
  tweakmode_int[120] = 17;
  tweakmode_int[122] = 1;
  tweakmode_int[123] = 2;
  tweakmode_int[124] = 3;
  tweakmode_int[125] = 4;
  tweakmode_int[126] = 5;
  tweakmode_int[127] = 6;
  tweakmode_int[128] = 7;
  tweakmode_int[129] = 8;
  tweakmode_int[130] = 100;
  tweakmode_int[131] = 1;
  tweakmode_int[132] = 1000;
  tweakmode_int[133] = 100;
  tweakmode_int[134] = 999;
  tweakmode_float[3] = 0.4;
  tweakmode_float[4] = 0.1;
  tweakmode_int[136] = 1;
  tweakmode_int[137] = 1;
  tweakmode_int[138] = 1;
  tweakmode_int[140] = 1;
  tweakmode_int[144] = 1;
  tweakmode_int[148] = -1;
  tweakmode_int[151] = 1;
  tweakmode_int[155] = -1;
  tweakmode_int[156] = 1;
  tweakmode_float[5] = 0.4;
  tweakmode_int[157] = 2;
  tweakmode_int[158] = 1;
  tweakmode_float[6] = 0.5;
  tweakmode_int[159] = 2;
  tweakmode_int[161] = 100;
  tweakmode_int[163] = 1;
  tweakmode_int[167] = 1;
  tweakmode_int[168] = 5;
  tweakmode_int[170] = 5;
  tweakmode_int[172] = 10;
  tweakmode_int[173] = 500;
  tweakmode_int[174] = 100;
  tweakmode_int[175] = 20;
  tweakmode_int[176] = 40;
  tweakmode_int[178] = 8;
  tweakmode_int[179] = 10;
  tweakmode_int[180] = 20;
  tweakmode_int[181] = 16;
  tweakmode_int[182] = 0;
  tweakmode_int[183] = 80;
  tweakmode_int[184] = 50;
  tweakmode_float[7] = 0.4;
  tweakmode_int[188] = 200;
  tweakmode_int[191] = 3;
  tweakmode_int[192] = 50;
  tweakmode_int[193] = 2;
  tweakmode_int[196] = 20;
  tweakmode_int[198] = 20;
  tweakmode_int[199] = 100;
  tweakmode_int[200] = 100;
  tweakmode_float[8] = 0.4;
  tweakmode_int[203] = 1000;
  tweakmode_int[250] = #D1B737;
  tweakmode_int[204] = 2;
  tweakmode_float[9] = 0.7;
  tweakmode_int[206] = 100;
  tweakmode_int[207] = 10;
  tweakmode_int[208] = 255;
  tweakmode_float[10] = 0.7;
  tweakmode_int[211] = 100;
  tweakmode_int[212] = 8;
  tweakmode_float[11] = 0.7;
  tweakmode_int[217] = 50;
  tweakmode_int[218] = 20;
  tweakmode_int[219] = 255;
  tweakmode_int[220] = 20;
  tweakmode_float[12] = 0.7;
  tweakmode_int[221] = 20;
  tweakmode_float[13] = 0.7;
  tweakmode_int[222] = 10;
  tweakmode_int[251] = #11AD49;
  tweakmode_int[228] = 1;
  tweakmode_int[229] = 1;
  tweakmode_int[230] = 1;
  tweakmode_int[231] = 1;
  tweakmode_int[232] = 255;
  tweakmode_int[233] = 1;
  tweakmode_int[235] = 5;
  tweakmode_int[236] = 5;
  tweakmode_int[252] = #11AD49;
  tweakmode_int[253] = #C64C4C;
  tweakmode_int[254] = #C64C4C;
  tweakmode_int[255] = #11AD49;
}

void tweakmode_initCommunication() {
  tweakmode_Server = new TweakModeServer();
  tweakmode_Server.setup();
  tweakmode_Server.start();
}





ArrayList<Grille> ToutesGrilles = new ArrayList<Grille>();
ArrayList<Joueur> TousJoueurs = new ArrayList<Joueur>();
ArrayList<Bloc> TousBlocs = new ArrayList<Bloc>();
ArrayList<Explosion> AllExplosions = new ArrayList<Explosion>();
ArrayList<Pantin> AllPantins = new ArrayList<Pantin>();

int noGrilleActive = 0;
Grille grilleActive;

Joueur joueur = new Joueur(5, 1);

float translateX, translateY;

void setup() {
  size(1000, 1000);


  /* TWEAKMODE */
  tweakmode_initAllVars();
  tweakmode_initCommunication();
  /* TWEAKMODE */


  CreationGrilles();
  AjouterBloc(3, 4, 100);
  AjouterPantin(5.5, 5, 40);
}


void draw() {
  grilleActive = ToutesGrilles.get(noGrilleActive);
  background(backgroundColor);

  push();

  translateX = width/tweakmode_int[0]-(grilleActive.taillex*grilleActive.tailleRect)/tweakmode_int[1];
  translateY = height/tweakmode_int[2]-(grilleActive.taillex*grilleActive.tailleRect)/tweakmode_int[3]; 
  translate(translateX, translateY);  //Translate pour tout avoir au milieu de l'écran

  GrilleFonctions();
  JoueurFonctions();
  PantinFonctions();   //Fonctions perm des objets
  BlocFonctions();
  Explosions();
  pointeurDev.PointeurDevFonctions();

  pop();

  Interface();
  /*
  DebugBloc();
   joueur.Debug();
   pointeurDev.Debug();
   println("Fin frame --------------------------------------------------------");*/
}

//----------------------------------------------------------------------------------------------

float ConvPixelGrille(float x) {
  x = x/grilleActive.tailleRect;  //Convertisseur Pixel -> Grille
  return x;
}
float ConvGrillePixel(float x) {
  x = x*grilleActive.tailleRect;  //Convertisseur Grille -> Pixel
  return x;
}

int Arrondir(float x1) {
  int posx;

  if (x1 < int(x1)+tweakmode_float[0])           //Arrondisseur made by Kiment
    posx = int(x1);               //Utilisé pour trouver une valeur de grille
  else posx = ceil(x1);

  return posx;
}

class TweakModeServer extends Thread
{
  protected DatagramSocket socket = null;
  protected boolean running = true;
  final int INT_VAR = 0;
  final int FLOAT_VAR = 1;
  final int SHUTDOWN = 0xffffffff;
  public TweakModeServer() {
    this("TweakModeServer");
  }
  public TweakModeServer(String name) {
    super(name);
  }
  public void setup()
  {
    try {
      socket = new DatagramSocket(53819);
      socket.setSoTimeout(250);
    } 
    catch (IOException e) {
      println("error: could not create TweakMode server socket");
    }
  }
  public void run()
  {
    byte[] buf = new byte[256];
    while (running)
    {
      try {
        DatagramPacket packet = new DatagramPacket(buf, buf.length);
        socket.receive(packet);
        ByteBuffer bb = ByteBuffer.wrap(buf);
        int type = bb.getInt(0);
        int index = bb.getInt(4);
        if (type == INT_VAR) {
          int val = bb.getInt(8);
          tweakmode_int[index] = val;
        } else          if (type == FLOAT_VAR) {
          float val = bb.getFloat(8);
          tweakmode_float[index] = val;
        } else        if (type == SHUTDOWN) {
          running = false;
        }
      } 
      catch (SocketTimeoutException e) {
        // nothing to do here just try receiving again
      } 
      catch (Exception e) {
      }
    }
    socket.close();
  }
}
