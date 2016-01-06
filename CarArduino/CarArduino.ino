const int analogInPin = A0;  // Analog input pin that the potentiometer is attached to
const int analogOutPin = 9; // Analog output pin that the LED is attached to
int turnState=0, lastturnState = -1;
int sensorValue = 0;        // value read from the pot
int outputValue = 0;        // value output to the PWM (analog out)
int val = -1;
void setup() {
  // initialize serial communications at 9600 bps:
  Serial.begin(9600);
}

void loop() {
  // read the analog in value:
  sensorValue = analogRead(analogInPin);
  // map it to the range of the analog out:
  // outputValue = map(sensorValue, 0, 1023, 0, 255);
  // change the analog out value:
  // analogWrite(analogOutPin, outputValue);

  // print the results to the serial monitor:
  // Serial.print("sensor = ");
  //  Serial.println(sensorValue);

 
    if ( 610 < sensorValue && sensorValue < 700 && turnState != 2&&turnState!=1) { // If switch is ON,
      val = 1;
      turnState = 1;
      Serial.write(val);
    }
    if (sensorValue < 750 && sensorValue > 700&&turnState!=2) { // If switch is ON,
      val = 2;
      turnState = 2;
      Serial.write(val);
    }
    if (sensorValue < 470 && sensorValue > 380 && turnState != 4&&turnState!=3) { // If the switch is not ON,
      val = 3;
      turnState = 3;
         Serial.write(val);
    }
    if (sensorValue < 380&&turnState!=4) {
      val = 4;
      turnState = 4;
         Serial.write(val);
    }
    if (sensorValue < 610 && sensorValue > 510&&turnState!=0) {
      turnState = 0;
    }
    

  



  //Serial.println(val);

  // Serial.print("\t output = ");
  //  Serial.println(outputValue);

  // wait 2 milliseconds before the next loop
  // for the analog-to-digital converter to settle
  // after the last reading:
  delay(200);
}

