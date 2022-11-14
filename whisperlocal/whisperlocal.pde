/**
 * Testing Whisper locally – all prerequisites must be installed before this works.
 *
 * https://openai.com/blog/whisper/
 * https://github.com/openai/whisper
 */

import java.io.InputStreamReader;
import java.util.Map;
import ddf.minim.*;
import ddf.minim.ugens.*;
import java.io.File;

Minim minim;
// for recording
AudioInput in;
AudioRecorder recorder;
boolean recorded;
boolean saved;

// for playing back
AudioOutput out;
FilePlayer player;

String whisperPath = "/Users/kammer/opt/miniconda3/bin/";
String ffmpegPath = "/usr/local/bin/";
String dataFile = "data.wav";
String shellCommand = "/bin/zsh";
String dataPath;
String outputPath;

float pulse = 0;
boolean isWorking = false;
String text = "Click anywhere on the screen after recording";
String recordText = "";

void setup() {
  size(800, 600);

  dataPath = sketchPath() + "/data";
  outputPath = sketchPath() + "/data";

  minim = new Minim(this);
  // get a mono line-in: sample buffer length of 2048
  // default sample rate is 44100, default bit depth is 16
  in = minim.getLineIn(Minim.MONO, 2048);

  // create an AudioRecorder that will record from in to the filename specified.
  // the file will be located in the sketch's main folder.
  recorder = minim.createRecorder(in, dataPath(dataFile));

  // get an output we can playback the recording on
  out = minim.getLineOut( Minim.MONO );
}

void draw() {
  background(pulse);
  if (isWorking) pulse = (pulse + 1) % 150;
  textSize(18);
  text(text, 5, 25);

  stroke(255);
  // draw the waveforms
  // the values returned by left.get() and right.get() will be between -1 and 1,
  // so we need to scale them up to see the waveform
  for (int i = 0; i < in.left.size()-1; i++)
  {
    line(i, 150 + in.left.get(i)*50, i+1, 150 + in.left.get(i+1)*50);
    line(i, 250 + in.right.get(i)*50, i+1, 250 + in.right.get(i+1)*50);
  }

  if ( recorder.isRecording() ) {
    recordText = "Now recording, press the r key to stop recording.";
  } else if ( !recorded ) {
    recordText = "Press the r key to start recording.";
  } else {
    recordText = "Press the s key to save the recording to disk and play it back in the sketch.";
  }

  text(recordText, 5, 300);

  textSize(12);
  text("shellCommand: " + shellCommand, 5, 490);
  text("whisperPath: " + whisperPath, 5, 505);
  text("ffmpegPath: " + ffmpegPath, 5, 520);
  text("dataPath: " + dataPath, 5, 535);
  text("dataFile: " + dataFile, 5, 550);
  text("outputPath: " + outputPath, 5, 565);
}

void watch(final Process process) {
  // https://stackoverflow.com/questions/8496494/running-command-line-in-java
  new Thread() {
    public void run() {
      BufferedReader input = new BufferedReader(new InputStreamReader(process.getInputStream()));
      String line = null;
      try {
        while ((line = input.readLine()) != null) {
          println(line);
        }
      }
      catch (IOException e) {
        e.printStackTrace();
      }
      String[] lines = loadStrings(dataFile + ".txt");
      text = "";
      for (String l : lines) {
        text += l;
        text += "\n";
      }

      isWorking = false;
      pulse = 0;
    }
  }
  .start();
}

void printEnvironment() {
  Map<String, String> environment = System.getenv();

  for (String envName : environment.keySet()) {
    System.out.println(String.format("%s : %s", envName, environment.get(envName)));
  }
}

void mousePressed() {
  if (!recorded) {
    text = "Please record first.";
    return;
  }

  text = "Working ...";
  ProcessBuilder builder = new ProcessBuilder(shellCommand, "-c",
    whisperPath + "whisper "
    + dataPath(dataFile)
    + " --output_dir " + outputPath
    + " --model tiny --language en"
    + " --fp16 False");
  Map<String, String> env = builder.environment();
  String p = env.get("PATH");
  p = p + ":" + ffmpegPath;
  env.put("PATH", p);
  builder.redirectErrorStream(true);

  try {
    isWorking = true;
    final Process process = builder.start();
    // Watch the process
    watch(process);
  }
  catch(Exception e) {
    e.printStackTrace();
  }
}

void keyReleased()
{
  if ( !recorded && key == 'r' )
  {
    // to indicate that you want to start or stop capturing audio data,
    // you must callstartRecording() and stopRecording() on the AudioRecorder object.
    // You can start and stop as many times as you like, the audio data will
    // be appended to the end of to the end of the file.
    if ( recorder.isRecording() )
    {
      recorder.endRecord();
      recorded = true;
    } else
    {
      recorder.beginRecord();
    }
  }
  if ( recorded && key == 's' )
  {
    // we've filled the file out buffer,
    // now write it to a file of the type we specified in setup
    // in the case of buffered recording,
    // this will appear to freeze the sketch for sometime, if the buffer is large
    // in the case of streamed recording,
    // it will not freeze as the data is already in the file and all that is being done
    // is closing the file.
    // save returns the recorded audio in an AudioRecordingStream,
    // which we can then play with a FilePlayer
    if ( player != null )
    {
      player.unpatch( out );
      player.close();
    }
    player = new FilePlayer( recorder.save() );
    player.patch( out );
    saved = true;
  }
  if ( saved && key == 'p' ) {
    player.rewind();
    player.play();
  }
  if (key=='q') {
    exit();
  }
}
