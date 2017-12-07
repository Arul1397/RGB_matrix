// Simple strand test for Adafruit Dot Star RGB LED strip.
// This is a basic diagnostic tool, NOT a graphics demo...helps confirm
// correct wiring and tests each pixel's ability to display red, green
// and blue and to forward data down the line.  By limiting the number
// and color of LEDs, it's reasonably safe to power a couple meters off
// the Arduino's 5V pin.  DON'T try that with other code!

#include <Adafruit_DotStar.h>
// Because conditional #includes don't work w/Arduino sketches...
#include <SPI.h>         // COMMENT OUT THIS LINE FOR GEMMA OR TRINKET
//#include <avr/power.h> // ENABLE THIS LINE FOR GEMMA OR TRINKET

#define NUMPIXELS 49 // Number of LEDs in strip

// Here's how to control the LEDs from any two pins:
#define DATAPIN    11
#define CLOCKPIN   13
Adafruit_DotStar strip = Adafruit_DotStar(
                           NUMPIXELS, DATAPIN, CLOCKPIN, DOTSTAR_BRG);
// The last parameter is optional -- this is the color data order of the
// DotStar strip, which has changed over time in different production runs.
// Your code just uses R,G,B colors, the library then reassigns as needed.
// Default is DOTSTAR_BRG, so change this if you have an earlier strip.

// Hardware SPI is a little faster, but must be wired to specific pins
// (Arduino Uno = pin 11 for data, 13 for clock, other boards are different).
//Adafruit_DotStar strip = Adafruit_DotStar(NUMPIXELS, DOTSTAR_BRG);
int k = 0, in[4];

void setup() {

#if defined(__AVR_ATtiny85__) && (F_CPU == 16000000L)
  clock_prescale_set(clock_div_1); // Enable 16 MHz on Trinket
#endif
  Serial.begin(9600);
  strip.begin(); // Initialize pins for output
  strip.show();  // Turn all LEDs off ASAP
//  while (Serial.available() <= 0)
//  {
//    Serial.write('A');
//    delay(200);
//  }
  in[0] = 0;
  in[1] = 0;
  in[2] = 0;
  in[3] = 0;
}


// Runs 10 LEDs at a time along strip, cycling through red, green and blue.
// This requires about 200 mA for all the 'on' pixels + 1 mA per 'off' pixel.

uint32_t color = 0xFF0000;      // 'On' color (starts red)
void loop() {
  while (Serial.available() > 0)
  {
    int a = Serial.read();
    if (k == 0)
    {
      in[k] = a;
    }
    else if (k == 1) {
      in[k] = a;
    }
    else if (k == 2)
    {
      in[k] = a;
    }
    else if (k == 3)
    {
      in[k] = a;
      k = -1;
      display1(in[0], in[1], in[2], in[3]);
    }

    k++;
  }
  strip.show();
  delay(20);
}
void display1(int n, uint32_t r, uint32_t g, uint32_t b)
{
  uint32_t c = (g * 65536) + (r * 256) + b;
  strip.setPixelColor(n, c);
}

