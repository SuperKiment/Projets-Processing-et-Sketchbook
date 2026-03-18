// ============================================
// InputManette.pde - Support manette natif Linux
// Lit directement /dev/input/js* via un thread
// Aucune bibliothèque externe requise.
// ============================================

import java.io.FileInputStream;
import java.io.File;

ArrayList<ManetteNative> manettesDetectees = new ArrayList<ManetteNative>();

class ManetteNative implements Runnable {
  FileInputStream fis;
  Thread thread;
  String chemin;
  String nom;
  volatile boolean connectee = false;

  volatile float[] axes = new float[10];
  volatile boolean[] boutons = new boolean[20];
  // Front montant boutons (pour one-shot)
  volatile boolean[] boutonsPresses = new boolean[20];

  ManetteNative(String cheminDevice) {
    chemin = cheminDevice;
    try {
      fis = new FileInputStream(cheminDevice);
      connectee = true;
      nom = new File(cheminDevice).getName();

      // Lire le nom réel du périphérique
      try {
        String sysName = "/sys/class/input/" + nom + "/device/name";
        File f = new File(sysName);
        if (f.exists()) {
          java.util.Scanner sc = new java.util.Scanner(f);
          if (sc.hasNextLine()) nom = sc.nextLine();
          sc.close();
        }
      } catch (Exception e) {}

      // Lancer le thread de lecture
      thread = new Thread(this);
      thread.setDaemon(true);
      thread.start();

      println("Manette detectee: " + nom + " (" + cheminDevice + ")");
    } catch (Exception e) {
      connectee = false;
      println("Impossible d'ouvrir " + cheminDevice + ": " + e.getMessage());
    }
  }

  void run() {
    byte[] buf = new byte[8];
    while (connectee) {
      try {
        int n = fis.read(buf);
        if (n != 8) continue;

        // Format Linux joystick :
        // [0-3] timestamp  [4-5] value (int16 LE)
        // [6] type         [7] number
        int value = (short)((buf[4] & 0xFF) | ((buf[5] & 0xFF) << 8));
        int type = buf[6] & 0x7F; // masquer flag init (0x80)
        int number = buf[7] & 0xFF;

        if (type == 2 && number < axes.length) {
          axes[number] = value / 32767.0;
        }
        if (type == 1 && number < boutons.length) {
          boolean pressed = (value == 1);
          if (pressed && !boutons[number]) {
            boutonsPresses[number] = true; // front montant
          }
          boutons[number] = pressed;
        }
      } catch (Exception e) {
        if (connectee) {
          connectee = false;
          println("Manette deconnectee: " + nom);
        }
        break;
      }
    }
  }

  void Fermer() {
    connectee = false;
    try {
      if (fis != null) fis.close(); // Débloque le read()
    } catch (Exception e) {}
  }

  boolean UnBoutonPresse() {
    for (int i = 0; i < boutons.length; i++) {
      if (boutonsPresses[i]) return true;
    }
    return false;
  }

  // Appelé chaque frame pour réinitialiser les fronts montants
  void FinFrame() {
    for (int i = 0; i < boutonsPresses.length; i++) {
      boutonsPresses[i] = false;
    }
  }
}

void InitManettes() {
  ScannerManettes();
}

void ScannerManettes() {
  for (ManetteNative m : manettesDetectees) {
    m.Fermer();
  }
  manettesDetectees.clear();

  for (int i = 0; i < 8; i++) {
    String chemin = "/dev/input/js" + i;
    File f = new File(chemin);
    if (f.exists() && f.canRead()) {
      ManetteNative m = new ManetteNative(chemin);
      if (m.connectee) {
        manettesDetectees.add(m);
      }
    }
  }

  if (manettesDetectees.size() == 0) {
    println("Aucune manette detectee.");
    println("  Verifiez: sudo usermod -aG input $USER (puis relogger)");
  } else {
    println(manettesDetectees.size() + " manette(s) detectee(s).");
  }
}

void LireManettes() {
  // Rien à faire ici, les threads lisent en continu
}

void FinFrameManettes() {
  for (ManetteNative m : manettesDetectees) {
    m.FinFrame();
  }
}

void AutoAssignerManettes() {
  int slotManette = 0;
  for (int i = 0; i < MAX_JOUEURS && slotManette < manettesDetectees.size(); i++) {
    PlayerInput pi = inputManager.joueurs[i];
    if (!pi.utiliseManette && pi.clavier == null) {
      pi.AssignerManette(manettesDetectees.get(slotManette));
      slotManette++;
    }
  }
}
