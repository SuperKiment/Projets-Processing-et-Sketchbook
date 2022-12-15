package processing.test.jeu_rageant;
        
import processing.android.PWallpaper;
import processing.core.PApplet;
        
public class MainService extends PWallpaper {  
  @Override
  public PApplet createSketch() {
    PApplet sketch = new Jeu_Rageant();
    
    return sketch;
  }
}
