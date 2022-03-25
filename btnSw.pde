// EX01_REVH: Switches, Buttons & LEDs
// 9-27-2013
// Coach
//-------------------------------------------------------------------------
// Update: 9-26-2013: Noe, Anita & Yanyao corrected BTN3 & BTN4 pin numbers
//-------------------------------------------------------------------------
// Objectives:
//------------
// 1. define constants for Basic I/O board buttons, LEDs & Switches
// 2. Declare variables for all states for buttons and switches
// 3. Initialize LEDs as outputs
// 4. Initialize buttons & switches as inputs
// 5. Create a loop with System Operation LED blinks in background (50ms ON, 50ms OFF)
// 6. Read all buttons & switches and store in associated states variables
// 7. Control LEDs based on switches & buttons positions:
//    SW1,SW2,SW3,SW4 -> LD1,LD2,LD3,LD4
//    BTN1,BTN2,BTN3,BTN4 -> LD5,LD6,LD7,LD8
//--------------------------------------
// Tasks:
//-------
// 0. Works as team of 2
// 1. Review this code
// 2. Verify MAX32 does what it is supposed to do
// 3. Complete coding to have MAX32 works with all switches & buttons
// 4. provide optical report to Coach
//----------------------------------------------------------------

// constants won't change. They're used here to 
// set pin numbers:
const int BTN1 = 4;     // the number of the pushbutton pin
const int BTN2 = 78;    //***** Note: label on the board is for Uno32, this is MAX32, see MAX32 Reference Manual
const int BTN3 = 80;    // *** 9-26-2013: Corrected by Noe, Anita & Yanyao
const int BTN4 = 81;    // *** 9-26-2013: Corrected by Noe, Anita & Yanyao

const int ledPin =  13;      // System Operational LED
const int LD1 =  70;     //***** Note: label on the board is for Uno32, this is MAX32, see MAX32 Reference Manual
const int LD2 =  71;     //******** Reference manual is wrong! LD pins are corrected here.
const int LD3 =  72;
const int LD4 =  73;
const int LD5 =  74;
const int LD6 =  75;
const int LD7 =  76;
const int LD8 =  77;


const int SW1 = 2;
const int SW2 = 7;
const int SW3 = 8;
const int SW4 = 79;     //***** Note: label on the I/O board is 35 for uno32 only

// variables will change:
int BTN1_state = 0;         // variable for reading the pushbutton status
int BTN2_state = 0;
int BTN3_state = 0;
int BTN4_state = 0;
int SW1_state = 0;
int SW2_state = 0;
int SW3_state = 0;
int SW4_state = 0;

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


  
  // initialize the pushbutton pin as an input:
  pinMode(BTN1, INPUT); 
  pinMode(BTN2, INPUT);
  pinMode(BTN3, INPUT);
  pinMode(BTN4, INPUT);

  // initialize switches as inputs:
   pinMode(SW1, INPUT);  
   pinMode(SW2, INPUT);
   pinMode(SW3, INPUT);
   pinMode(SW4, INPUT); 
}

void loop(){
  // System Operation LED ON:
     digitalWrite(ledPin, HIGH); 
     delay(50);                  // wait for 50 ms
  //----------------------------------------------   
  // read the state of the pushbutton value:
  BTN1_state = digitalRead(BTN1);
  BTN2_state = digitalRead(BTN2);
  BTN3_state = digitalRead(BTN3);
  BTN4_state = digitalRead(BTN4);

  // read switches:
  SW1_state = digitalRead(SW1);
  SW2_state = digitalRead(SW2);
  SW3_state = digitalRead(SW3);
  SW4_state = digitalRead(SW4);
  
  // Control LEDs based on buttons & Switches:
  
  if (SW1_state == HIGH) {digitalWrite(LD1, HIGH);  }
  if (SW1_state == LOW) {digitalWrite(LD1, LOW);  }
  
  digitalWrite(LD2, digitalRead(SW2));
  digitalWrite(LD3, SW3_state);
  digitalWrite(LD4, SW4_state);
  
  
  if (BTN1_state == HIGH) { digitalWrite(LD5, HIGH);   } 
  if (BTN1_state == LOW) { digitalWrite(LD5, LOW);   } 
  
  digitalWrite(LD6, BTN2_state);
  digitalWrite(LD7, BTN3_state);
  digitalWrite(LD8, BTN4_state);
  
 
  //------------------------------------
   // System Operation LED OFF:
     digitalWrite(ledPin, LOW); 
     delay(50);                  // wait for 50 ms 
  
} // end loop
