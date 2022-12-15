
import processing.net.*; 

Client ordiclient; 
Client ordiclient1;
Client c;
Server ordiserver;

String HTTP_GET_REQUEST = "GET /";
String HTTP_HEADER = "HTTP/1.0 200 OK\r\nContent-Type: text/html\r\n\r\n";

String liredata;
String envoie1;
String envoie2;
Table table;

int data1[];
int data2[];
String datas[];
int pvert;

int i;

String input;
int fact = 40;

PrintWriter output = null;
String cheminAbsoluFichier="d:/dataoasis/dataoasis.txt";
import java.io.BufferedWriter;
import java.io.FileWriter;


PrintWriter ouvreFichier( String cheminAbsoluFichier) {

// ouvre le fichier existant dans un PrintWriter- le fichier doit exister - chemin entier obligatoire
// adapté de la source suivante : http://processing.org/discourse/yabb2/YaBB.pl?num=1267767630

       PrintWriter pw=null;
       try 
       {
       // ouvre le fichier existant - le fichier doit exister - chemin entier obligatoire
       pw = new PrintWriter(new BufferedWriter(new FileWriter(cheminAbsoluFichier, true))); // true means: "append"
       }

       catch (IOException e)
       {
       // Report problem or handle it
       }

       return (pw); // renvoie l'objet pw

}




void setup() { 
  size(600, 600); 
  background(50); 
  fill(200);
  textSize(32);

  ordiserver=new Server(this,8080);

  output=ouvreFichier(cheminAbsoluFichier);    


} 

void draw() {
  
  
  
  // interoge le l'arduino en 22
   ordiclient1 = new Client(this, "192.168.1.22", 4200);  // Connect to server on port 4200
  delay (1000);
    ordiclient1.write("GET / HTTP/1.0\n");  // Use the HTTP "GET" command to ask for a webpage
    delay (3000);
  
  //if (ordiclient.available() > 0) {    // If there's incoming data from the client...
    while(ordiclient1.available()>0) {
    
    liredata = ordiclient1.readString();  
    envoie1=liredata;
    print("Données 1 :");     
    println(liredata);
       
    datas = (split(liredata, ' '));  // Split values into an array
    data1 = int(datas);
    
    fill(50);
    rect(1,1,220,450);
    fill(200);
      textSize(20);
    text (hour(),10,30);
    text(":",38,30);
    text (minute(),42,30);
    text(":",70,30);
    text (second(),76,30);
      textSize(32);
    text("Nous ",20,290);
    text("bas S2",20,100);
    for (i=0;i<data1.length;i=i+1) {
      if (data1[i]<0) data1[i]=0;
      print(data1[i]);
      print("  ");
      print(datas[i]);
      print("  ");
      println(datas[i].length());
      if (i==5) pvert=data1[i];
      if (i<3) text(data1[i]*fact,20,150+40*i);
      if (i>2) text(data1[i]*fact,20,150+40*i+50);
      if (data1.length==6) 
            { textSize(25);
              text((data1[0]+data1[1]+data1[2])*fact,100,250);
              textSize(32);
              
            }

      
       output.print(day()+"/"+month()+"/"+year()+";"); //Ecrit la date dans le fichier suivi ;
       output.print(hour()+":"+minute()+":"+second()+";"); // Ecrit l'heure dans le fichier
       if (i==0) output.print("bas s2 phase1 "+";"+data1[i]*fact); // Ecrit la valeur dans le fichier
       if (i==1) output.print("bas s2 phase2 "+";"+data1[i]*fact); // Ecrit la valeur dans le fichier
       if (i==2) output.print("bas s2 phase3 "+";"+data1[i]*fact); // Ecrit la valeur dans le fichier
       if (i==3) output.print("Nous phase1 "+";"+data1[i]*fact); // Ecrit la valeur dans le fichier
       if (i==4) output.print("Nous phase2 "+";"+data1[i]*fact); // Ecrit la valeur dans le fichier
       if (i==5) output.print("Nous phase3"+";"+data1[i]*fact); // Ecrit la valeur dans le fichier
       output.println(); // Ajoute saut de ligne

       output.flush();
  
  
      }
  
  }
  // interoge l'arduino en 20
  ordiclient = new Client(this, "192.168.1.20", 4200);  // Connect to server on port 4200
   delay (1000);
    ordiclient.write("GET / HTTP/1.0\n");  // Use the HTTP "GET" command to ask for a webpage
    delay (3000);
  
  // if (ordiclient.available() > 0) {    // If there's incoming data from the client...
    while(ordiclient.available()>0) {
    
    
    
    liredata = ordiclient.readString();  
    envoie2=liredata;
         
    print("Données 2 : ");
    println(liredata);
    
     
    datas = split(liredata, ' ');  // Split values into an array
    data2 = int(datas);        
    
    fill(50);
    rect(220,1,500,450);
    fill(200);
      textSize(20);
    text (hour(),310,30);
    text(":",338,30);
    text (minute(),342,30);
    text(":",370,30);
    text (second(),376,30);
      textSize(32);

    text("Bas tout ",225,100);
   
    for (i=0;i<data2.length;i=i+1) {
      print(data2[i]);
      print("  ");
      println(datas[i]);
      if (i<3) text(data2[i]*fact/2,225,150+40*i);
      if (i==3) text("P red : ",225,320);
      if (i==3) text(data2[i]/2,355,320);
      if (i==4) {
        text("P bleu : ",225,360);
        text(data2[i],355,360);
        text("P vert : ",225,400);
        text(pvert,355,400);
        }
      
     
  
      if ((data2.length==5)&&(data1.length==6)) 
            { textSize(25);
              text((data2[0]+data2[1]+data2[2])*fact/2+data1[5]*fact+data2[3]/2+data2[4],260,450);
              
              if ((((data2[0])*fact/2+data2[3]/2)<10)) {
                text("EXPORT rouge",400,140);
                text(((data2[0])*fact/2+data2[3]/2),400,170);
                }
              if ((((data2[1])*fact/2+data2[4])<10)) {
                text("EXPORT bleu",400,220);
                text(((data2[1])*fact/2+data2[4]),400,250);
                }
    
              textSize(32);
            }
         
  
  
       output.print(day()+"/"+month()+"/"+year()+";"); //Ecrit la date dans le fichier suivi ;
       output.print(hour()+":"+minute()+":"+second()+";"); // Ecrit l'heure dans le fichier
       if (i==0) output.print("bas phase1"+";"+data2[i]*fact/2); // Ecrit la valeur dans le fichier
       if (i==1) output.print("bas phase2"+";"+data2[i]*fact/2); // Ecrit la valeur dans le fichier
       if (i==2) output.print("bas phase3"+";"+data2[i]*fact/2); // Ecrit la valeur dans le fichier
       if (i==3) output.print("Puissance vert"+";"+(data2[i])); // Ecrit la valeur dans le fichier
       if (i==4) output.print("Puissance bleu"+";"+(data2[i])); // Ecrit la valeur dans le fichier
       
       output.println(); // Ajoute saut de ligne

       output.flush();
  
      }
  }
   
   // envoyer les data sur serveur Web
   
   
   
    // Receive data from client
  c = ordiserver.available();
  if (c != null) {
    input = c.readString();
    input = input.substring(0, input.indexOf("\n")); // Only up to the newline
    
    if (input.indexOf(HTTP_GET_REQUEST) == 0) // starts with ...
    {
    c.write(HTTP_HEADER);  // answer that we're ok with the request and are gonna send html
    
  
    c.write("<html><head><title>Oasis DATABASE'</title></head><body><h3>coucou");
    c.write("</h3></body></html>");
    c.write("Temps en millis  : ");

    c.write(str(millis()));
 
    c.write("<br>");    
    c.write("Heure relevée : ");
    c.write(str(hour()));
    c.write(" : ");
    c.write(str(minute()));
    c.write(" : ");
    c.write(str(second()));
    
    c.write("<br>");
    c.write("<br>");
    c.write("Puissance vers bas du camping ");
    c.write("<br>");

    for (i=0;i<data2.length;i=i+1) {
      if (i<3) {
        c.write("Phase ");
        c.write(str(i));
        c.write(" : ");
        c.write(str((data2[i]*fact)));
        c.write(" w");
      }
      if (i==3) {
        c.write("<br>");
        c.write("Température in boite : ");
        c.write(str((data2[i]/10-5)));
        c.write(" °c");
      }
      c.write("<br>");
      }
 

    
    c.write("<br>");    
    c.write("Puissance vers bas du camping section 2 seule ");
    
    c.write("<br>");
    
    for (i=0;i<data1.length;i=i+1) {
      if (data1[i]<0) data1[i]=0;
      c.write(str((data1[i]*fact)));
      if (i==2) {
          c.write("<br><br>Puissance vers Chalet seul : ");
          }
      c.write("<br>");
      }
    c.write("<br>");
    
         if (data2.length==4) 
            {  c.write("<br>");
          c.write("Puissance TOTAL vers bas du camping : ");
          c.write(str((data2[0]+data2[1]+data2[2])*fact));
          c.write(" w");
          c.write("<br>");
            }
    
    
        if (data1.length==6) 
            {  c.write("<br>");
          c.write("Puissance TOTAL chez nous : ");
          c.write(str((data1[3]+data1[4]+data1[5])*fact));
          c.write(" w");
          c.write("<br>");
             
 
            }
   
    if (data1.length==6&&data2.length==4) {
       c.write("<br>");
          c.write("Puissance TOTAL : ");
          c.write(str((data1[3]+data1[4]+data1[5])*fact+(data2[0]+data2[1]+data2[2])*fact));
          c.write(" w");
          c.write("<br>");
    }
     

    // close connection to client, otherwise it's gonna wait forever
    c.stop();
    }
  }

    
           
  
  
}
