/*
	EX12_ReadPOT_DisplayOled_blink.pde

	Status:							2013-04-25: Operation verified

	Version:						1.0 Released 2013-04-25
	Authors:						David Cuartielles
	Modified By:					Tom Igoe, Coach, William Seaton, Robin Messenger
	Compiler:						MPIDE 0023-20111221
	Target Hardware:				chipKIT Max32
	Development Platform:			Windows 7 (64 bit) / Linux (32 bit)

	This example code is in the public domain.

	Analog Input
	Demonstrates analog input by reading an analog sensor on analog pin 0 and
	turning on and off a light emitting diode(LED)  connected to digital pin 13. 
	The amount of time the LED will be on and off depends on
	the value obtained by analogRead(). 

	Modified to make use of the OLED screen on the Max32 to display
	the 10 bit POT position integer.

	The circuit:
		* Potentiometer attached to analog input 0
		* center pin of the potentiometer to the analog pin
		* one side pin (either one) to ground
		* the other side pin to +5V
		* LED anode (long leg) attached to digital output 13
		* LED cathode (short leg) attached to ground

	* Note: because most Arduinos have a built-in LED attached 
	to pin 13 on the board, the LED is optional.

	http://arduino.cc/en/Tutorial/AnalogInput
*/

#include <IOShieldOled.h>

int sensorPin = A0;    // select the input pin for the potentiometer
int ledPin = 13;      // select the pin for the LED
int sensorValue = 0;  // variable to store the value coming from the sensor
String displayString;
char displayCharArray[50];

// Note: for 10-bit A/D, the range of sensorValue = 0 to 1023

void setup() {
	// declare the ledPin as an OUTPUT:
	pinMode(ledPin, OUTPUT);  
	IOShieldOled.begin();
	IOShieldOled.displayOn();
}

void loop() {
	// read the value from the sensor:
		sensorValue = analogRead(sensorPin);   
  	// turn the ledPin on
  		digitalWrite(ledPin, HIGH);  
  	// time delay for <sensorValue> milliseconds:
  		delay(sensorValue);          
  	// turn the ledPin off:        
  		digitalWrite(ledPin, LOW);   
  	// time delay for <sensorValue> milliseconds:
  		delay(sensorValue);                  

	// Display sensorValue at OLED:

	//create a string to display the output on the OLED screen
	displayString="Pot Value: ";
	displayString+=sensorValue;

	//convert the string to an array of characters
        char displayCharArray[] = displayString;
        
//	displayString.toCharArray(displayCharArray,50);

	//clear the display and reset the cursor to zero
	IOShieldOled.clearBuffer();
	IOShieldOled.setCursor(0,0);

	//print the string to the display
	IOShieldOled.putString(displayCharArray);
	IOShieldOled.updateDisplay();                 
}

