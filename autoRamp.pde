// EX-PWM-1B-Starter.txt
// 3-28-2016
// Coach

// Status: 
// * (Given) POT Control Operation verified with Max32 microcontroller + Basic I/O board & 12V DC Fan
// * Auto Ramping 3 cycles to be developed by the audience	

// Objective: 
// =========
// Demonstrate the concept of Pulse Width Modulation (PWM)

// Functional Description:
// ======================

// 0. Read SW1:
//        SW1 = 0: POT control
//        SW1 = 1: Auto Ramping

// 1. (Given) POT Control mode (Given)
//   1.1 Read POT input, scale input by factor of 10:
//        tON = sensorValue / 10;   (unit in ms)
//        Limit tON to max value of 100

//   1.2. Display tON @ OLED

//   1.3. Drive LD8 & RD0 using PWM:
//	* period = 100 ms
//	* tOFF = period - tON

// 2. (Your codes) Auto Ramping Mode
//    2.1 Ramp Up tON from 0 to 100 then
//    2.2 Ramp Down from 100 to 0 & repeat for 3 cycles then turn OFF DC Fan.
//=============================================================================

// Tasks:

// 1. Review Pulse Width Modulation (PWM) concept

// 2. Read & verify this Starter Template is working (without adding any code)

// 3. Check DC Fan speed operation at System Test Bench

// 4. Add your Auto Ramping codes

// 5. Verify your codes work as prescribed

// 6. Verify DC Fan operations at System Bench

// 7. Submit Optical report to Coach for lab credit

//=============================================================================
#include <IOShieldOled.h>

// set pin numbers:
const int BTN1 = 4;     // the number of the pushbutton pin
const int BTN2 = 78;    //***** Note: label on the board is for Uno32, this is MAX32, see MAX32 Reference Manual

const int ledPin =  13;     
const int LD1 =  70;     //***** Note: label on the board is for Uno32, this is MAX32, see MAX32 Reference Manual
const int LD2 =  71;     // ******** LD pins are corrected here.
			
const int LD3 =  72;
const int LD4 =  73;
const int LD5 =  74;
const int LD6 =  75;
const int LD7 =  76;
const int LD8 =  77;	 // visual feedback for PWM

//***
const int RD0 = 3;      //*** Note: RD0 controls Power FET driver at J7-3

const int SW1 = 2;
const int SW2 = 7;
const int SW3 = 8;
const int SW4 = 79;     //***** Note: label on the I/O board is 35 for uno32 only

// variables:
int BTN1_state = 0;         // variable for reading the pushbutton status
int SW1_state = 0; 
int SW2_state = 0; 
int SW3_state = 0; 
int SW4_state = 0; 

int sensorPin = A0;    // select the input pin for the potentiometer

int sensorValue = 0;  // variable to store the value coming from the sensor
// Note: for 10-bit A/D, the range of sensorValue = 0 to 1023

//====================================
int tON = 0;   		// unit in ms
int period = 100;  	// unit in ms
int tOFF = 0;           // unit in ms
//====================================

int display_refresh=0;
String displayString;
char displayCharArray[50];

int count = 0;
boolean inc = true;

void setup() {
  
  // initialize the LED pin as an output:
  pinMode(ledPin, OUTPUT);  
  pinMode(LD1, OUTPUT);  
  pinMode(LD2, OUTPUT);    
  pinMode(LD3, OUTPUT);  
  pinMode(LD4, OUTPUT);     
  pinMode(LD5, OUTPUT);  
  pinMode(LD6, OUTPUT);    
  pinMode(LD7, OUTPUT);  
  pinMode(LD8, OUTPUT);     

  pinMode(RD0, OUTPUT);   // *** Controls DC Fan
   
  // initialize the pushbutton pin as an input:
  pinMode(BTN1, INPUT);  

  // initialize switches as inputs:
   pinMode(SW1, INPUT);  
   pinMode(SW2, INPUT);
   pinMode(SW3, INPUT);
   pinMode(SW4, INPUT); 
   
  // Turn OFF all LEDs
 digitalWrite(LD1, LOW); 
 digitalWrite(LD2, LOW); 
 digitalWrite(LD3, LOW); 
 digitalWrite(LD4, LOW);  

 digitalWrite(LD5, LOW); 
 digitalWrite(LD6, LOW); 
 digitalWrite(LD7, LOW); 
 digitalWrite(LD8, LOW); 
  
	// Initialize OLED:
	IOShieldOled.begin();
	IOShieldOled.displayOn();

}  // end setup()

void loop() {

// Read Switch inputs:
SW1_state = digitalRead(SW1);

// Echo swith input to LED indicator:
if (SW1_state == HIGH) {digitalWrite(LD1, HIGH);}
if (SW1_state == LOW) {digitalWrite(LD1, LOW);}

// Display tON @ OLED:
// -------------------------------------
        IOShieldOled.updateDisplay(); 
        
	//clear the display and reset the cursor to zero
	IOShieldOled.clearBuffer();

	IOShieldOled.setCursor(0,0);
        IOShieldOled.putString("Nathan - Nick");
        
        // Display Date & Your Name:
	IOShieldOled.setCursor(0,1);
	displayString="3-28-16/Coach";
	//convert the string to an array of characters
	displayString.toCharArray(displayCharArray,50);
    	//Display it @ OLED:
	IOShieldOled.putString(displayCharArray); 
        
	IOShieldOled.setCursor(0,3);
	//create a string to display tON at OLED screen
	displayString="tON(ms) = ";
	displayString += tON;
	//convert the string to an array of characters
	displayString.toCharArray(displayCharArray,50);
        //Display it @OLED:
        IOShieldOled.putString(displayCharArray);  

	IOShieldOled.updateDisplay();  

switch (SW1_state)
{
  
case 0:
 // Indicate POT Mode at OLED
        IOShieldOled.setCursor(0,2);
        IOShieldOled.putString("*** Using POT"); 
  
// Read POT input, scale input tON to Maximum of 100 ms:
// -----------------------------------------------------

	// read the value from the POT sensor:
	sensorValue = analogRead(sensorPin);

        // Scale tON to ms with limit of 100ms:
        tON = sensorValue/10;
	if (tON>100) {tON = 100;}

// PWM Logic:
//-----------

  	// Turn on LD8 & RD0:
     	digitalWrite(LD8, HIGH);    // LD8 for visual feedback
     	digitalWrite(RD0, HIGH);    // RD0 run DC Fan 
     	delay(tON);           // wait for tON ms 
    
	tOFF = period - tON;

	// Turn OFF LD8 & RD0:
     	digitalWrite(LD8, LOW);
     	digitalWrite(RD0, LOW);     
     	delay(tOFF);           // wait for tOFF ms 

 break; // end of case 0

//===================================================
case 1:
 // Indicate Auto Ramp Mode at OLED
        IOShieldOled.setCursor(0,2);
        IOShieldOled.putString("*** Auto Ramp"); 

// *** Your Auto Ramping codes
if (count < 3)
{
  if (count == 0 && inc)
  {
    tON = 0;
  }
  if(inc)
  {
    tON++;
  }
  else
  {
    tON--;
  }
  if (tON == 100)
  {
    inc=false;
  }
  if (tON == 1)
  {
    inc=true;
    count++;
  }
  // Turn on LD8 & RD0:
  digitalWrite(LD8, HIGH);    // LD8 for visual feedback
  digitalWrite(RD0, HIGH);    // RD0 run DC Fan 
  delay(tON);           // wait for tON ms 
    
  tOFF = period - tON;

  // Turn OFF LD8 & RD0:
  digitalWrite(LD8, LOW);
  digitalWrite(RD0, LOW);     
  delay(tOFF);  

}
else
{
  tON = 0;
}



break; // end of case 1 

} // End of Switch

} // end void loop()



