/** 
 * Sources for this file:
 *
 * https://amnonp5.wordpress.com/2011/11/26/text-to-speech/
 * http://code.compartmental.net/tools/minim/
 * https://stackoverflow.com/questions/35002003/how-to-use-google-translate-tts-with-the-new-v2-api
 */

import ddf.minim.*;
import java.net.*;
import java.io.*;
AudioPlayer player;
Minim minim;
 
String s = "Hier tippen";
String sSaved = "";
 
void setup() {
  size(1280, 720);
  minim = new Minim(this);
  textAlign(CENTER, CENTER);
  textSize(50);
  stroke(255);
}
 
void draw() {
  background(0);
  textSize(50);
  text(s, 0, 20, width, height - 20);
  textSize(20);
  text("ALT - Eingabe löschen | CTRL - Abspielen beenden", 0, 20, width, 50);
  if (player != null) {
    translate(0, 250);
    for(int i = 0; i < player.left.size()-1; i++) {
      line(i, 50 + player.left.get(i)*50, i+1, 50 + player.left.get(i+1)*50);
      line(i, 150 + player.right.get(i)*50, i+1, 150 + player.right.get(i+1)*50);
    }
  }
}
 
void keyPressed() {
  if (keyCode == BACKSPACE) {
    if (s.length() > 0) {
      s = s.substring(0, s.length()-1);
    }
  } else if (keyCode == DELETE) {
    s = "";
  } else if (keyCode == ENTER) {
    googleTTS(s, "de");
    if (player != null) { player.close(); } // comment this line to layer sounds
    player = minim.loadFile(s.replace(" ", "") + ".mp3", 2048);
    player.loop();
    sSaved = s;
    s = "";
  } else if (keyCode != SHIFT && keyCode != CONTROL && keyCode != ALT && s.length() < 100) {
    s += key;
  } else if (keyCode == ALT) {
    s = "";
  } else if (keyCode == CONTROL) {
    if (player != null) {
      player.pause();
      player = null;
      s = sSaved;
    }
  }
}
 
void googleTTS(String txt, String language) {
  String u = "https://translate.google.com/translate_tts?ie=UTF-8&client=tw-ob&tl=";
  String sketchPath = dataPath("");
  u = u + language + "&q=" + txt;
  u = u.replace(" ", "%20");
  try {
    URL url = new URL(u);
    try {
      URLConnection connection = url.openConnection();
      connection.setRequestProperty("User-Agent", "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; .NET CLR 1.0.3705; .NET CLR 1.1.4322; .NET CLR 1.2.30703)");
      connection.connect();
      InputStream is = connection.getInputStream();
      String filePath= sketchPath + "/" + txt.replace(" ", "") + ".mp3";
      System.out.println(filePath);
      File f = new File(filePath);
      OutputStream out = new FileOutputStream(f);
      byte buf[] = new byte[1024];
      int len;
      while ((len = is.read(buf)) > 0) {
        out.write(buf, 0, len);
      }
      out.close();
      is.close();
      println("File created: " + txt.replace(" ", "") + ".mp3");
    } catch (IOException e) {
      e.printStackTrace();
    }
  } catch (MalformedURLException e) {
    e.printStackTrace();
  }
}
 
void stop() {
  player.close();
  minim.stop();
  super.stop();
}
