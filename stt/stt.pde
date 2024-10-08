import ddf.minim.*;
import ddf.minim.ugens.*;
import java.io.File;
import java.net.*;
import java.io.*;
import java.util.*;

// Goto: Sketch > Library importieren > Minim
Minim minim;
AudioInput in;
AudioRecorder recorder;

String whisperServer = "http://itv21.informatik.htw-dresden.de:5002";
String dataFile = "data.wav";
String info = "Press r to start and stop recording!";
List<String> recognized = new ArrayList<String>();
boolean recorded = false;
boolean shouldRecord = false;
int stopDelay;

void setup() {
  size(800, 600);

  minim = new Minim(this);
  // get a mono line-in: sample buffer length of 2048
  // default sample rate is 44100, default bit depth is 16
  in = minim.getLineIn(Minim.MONO, 1024); // , 22050, 16);

  // create an AudioRecorder that will record from in to the filename specified.
  // the file will be located in the sketch's main folder.
  recorder = minim.createRecorder(in, dataPath(dataFile));
}

void draw() {
  background(0);
  stroke(255);
  // draw the waveforms
  // the values returned by left.get() and right.get() will be between -1 and 1,
  // so we need to scale them up to see the waveform
  for (int i = 0; i < in.left.size()-1; i++)
  {
    line(i, 150 + in.left.get(i)*50, i+1, 150 + in.left.get(i+1)*50);
    line(i, 250 + in.right.get(i)*50, i+1, 250 + in.right.get(i+1)*50);
  }
  
  if(in.left.level() > 0.025 && !shouldRecord) {
    shouldRecord = true;
    stopDelay = 50;
    toggleRecording();
  }
  if(in.left.level() < 0.01 && shouldRecord) {    
    stopDelay--;
    if(stopDelay < 0) {
      shouldRecord = false;
      toggleRecording();
    }
  }

  textSize(18);
  text(String.join("\n", recognized), 5, 20);
  text(info, 5, 300);
}

void toggleRecording() {
  if (recorder == null) {
    recorded = false;
    if (recorder == null) recorder = minim.createRecorder(in, dataPath(dataFile));
  }
  if (!recorded) {
    // to indicate that you want to start or stop capturing audio data,
    // you must callstartRecording() and stopRecording() on the AudioRecorder object.
    // You can start and stop as many times as you like, the audio data will
    // be appended to the end of to the end of the file.
    if ( recorder.isRecording() )
    {
      recorder.endRecord();
      recorder.save();
      recorded = true;
      info = "End recording";
      recorder = null;
      whisperSTT(dataPath(dataFile), recognized);
    } else {
      recorder.beginRecord();
      info = "Begin recording";
    }
  }
}

void keyReleased() {
  if (key == 'r') toggleRecording();
}

void whisperSTT(String file, final List<String> res) {
  // String url = whisperServer + "/whisper";
  String url = whisperServer + "/google";
  File binaryFile = new File(file);  

  // We create a thread here in order to keep the program
  // from blocking while the request is sent to the server and is processed
  new Thread() {
    public void run() {
      try {
        info = "Wait for recognition ... ";
        // See the MultipartUtility class in a seperate file for information
        MultipartUtility utility = new MultipartUtility(url, "UTF-8");
        utility.addFilePart("uploaded_file", binaryFile);
        // For whisper we can choose different recognition  models: tiny, base, small, medium, large 
        utility.addFormField("model", "base");
        // For whisper we can recognize different languages, English (en) performs best, German (de) worse
        utility.addFormField("language", "en");
        List<String> response = utility.finish();
        for (String s : response)
          res.add(s);
        info = "Press r to start and stop recording!";
      }
      catch (IOException e) {
        e.printStackTrace();
      }
    }
  }
  .start();
}
