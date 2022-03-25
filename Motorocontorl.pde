// EX03_Starter_StepperMotorControl_REVB
// 10-3-2013
//------------------------------------------------
// Status:
//   * REVB Starter Template created
//------------------------------------------------                                 
// Author:         	  Coach 
// Target Hardware:       Digilent chipKITMax32 board + Basic I/O Board
// Development Platform:  mpide-0023-windows-20120903
//---------------------------------------------------
// Objective: Provide control logic for stepper motor control
//		*** This code can be adapted for chipKITMax32 or Arduino Nano

// Stepper Motor Control Logic:
// ============================

//	Stepper Motor Driver keep track of indexM pointing to stepper Motor Drive Table:
//			IndexM	D3 D2 D1 D0  Hex Value
//			=====	== == == ==  =========
//			 0       0  0  0  1      1
//			 1       0  1  0  0      4
//	   	 	 2       0  0  1  0      2
//			 3	 1  0  0  0      8

//  * Wraps around logic is provided by : indexM = indexM & 3
//  * To move clockwise, indexM = indexM + 1
//  * To move counter clockwise, indexM = indexM - 1
//----------------------------------------
//   I/O Assignments:
//   ===============
//   SW1: Run (SW1 = 0: Stop / SW1 = 1: Run)
//   SW2: Direction (SW2= 0: Clockwise/ SW2 = 1: CounterClockWise)
//   SW3: Autoscan (SW3 = 0: Manual / SW3 = 1: Autoscan )
//   SW4: Timing Control (SW4 = 0: Development, SW4=1: Real)

//   LD1: Run Indicator
//   LD2: Direction Indicator
//   LD3: spare
//   LD4: spare

//   Simulation:
//   LD5: Motor Coil D0
//   LD6: Motor Coil D1
//   LD7: Motor Coil D2
//   LD8: Motor Coil D3

//  Physical Motor Drive:
//   MotorCoil_0 : pin0
//   MotorCoil_1 : pin1
//   MotorCoil_2 : pin2
//   MotorCoil_3 : pin3
//------------------------------------------
//   Functional requirements:
//   ======================= 
//   0. Reflect SW1,SW2,SW3,SW4 to LD1,LD2,LD3,LD4

//   1. When the system is not running (Run = 0), disable all outputs
//   2. When the system is running (Run = 1), read Direction switch
//     2.1 If Direction ==0, run motor clockwise
//     2.2 If Direction ==1, run motor counter clockwise

//   3. Auto scan feature:(Note: to be designed & coded by you)
//       SW3: Autoscan (SW3 = 0: Manual / SW3 = 1: Autoscan )
//       When in manual mode, execute function 2.1 & 2.2 
//       When in autoscan mode: stepper motor moves up 16 steps then moves down 16 steps, repeats continuously  

//   4. Timing Control (SW4) input:
//      4.1 When in Development mode (SW4 == 0): motorTime = 500 (ms)
//      4.2 When in Real mode (SW4 == 1): motorTime = 10 (ms)
// =======================================================
// Tasks:

// 0. Review "How Stepper Motor Works" power point

// 1. Read & understand this sample code

// 2. Run & verify that it works as written

// 3. *** Design your Autoscan logic using Flow Chart, review with Coach

// 4. *** Add Code for Your Design prescribed in item 3 above

// 5. Verify your code works as prescribed, troubleshoot & fix it as required

// 6. *** Provide optical report to Coach

// 7. *** Verify at System Bench Test with Laser pointer Assembly
//==========================================================================
 
// set pin numbers:
const int BTN1 = 4;     // the number of the pushbutton pin
const int BTN2 = 78;    //***** Note: label on the board is for Uno32, this is MAX32, see MAX32 Reference Manual

const int ledPin =  13;      // System Operational LED
const int LD1 =  70;     //***** Note: label on the board is for Uno32, this is MAX32, see MAX32 Reference Manual
const int LD2 =  71;     // ******** LD pins are corrected here.
			
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

// variables:
int BTN1_state = 0;         // variable for reading the pushbutton status
int SW1_state = 0; 
int SW2_state = 0; 
int SW3_state = 0; 
int SW4_state = 0; 

int motorTime = 1000;   // 1000 ms = 1s
// Initial Stepper Motor Coil pattern
int indexM =0;
int step_max = 16;
int motor_step = 0;
boolean auto_direction = true;


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

  	// Initial Stepper Motor Coil pattern
 digitalWrite(LD5, LOW); 
 digitalWrite(LD6, LOW); 
 digitalWrite(LD7, LOW); 
 digitalWrite(LD8, LOW); 

} // end setup()

void loop(){
  // System Operation LED ON:
     digitalWrite(ledPin, HIGH); 
     delay(10);                  // wait for x ms
  //----------------------------------------------  
 
  // read switches inputs:
  SW1_state = digitalRead(SW1);
  SW2_state = digitalRead(SW2); 
  SW3_state = digitalRead(SW3);
  SW4_state = digitalRead(SW4); 

// Echo switches to LED Indicators:
  if (SW1_state == HIGH) {digitalWrite(LD1, HIGH);  }
  if (SW1_state == LOW) {digitalWrite(LD1, LOW);  }

  if (SW2_state == HIGH) {digitalWrite(LD2, HIGH);  }
  if (SW2_state == LOW) {digitalWrite(LD2, LOW);  }

  if (SW3_state == HIGH) {digitalWrite(LD3, HIGH);  }
  if (SW3_state == LOW) {digitalWrite(LD3, LOW);  }

  if (SW4_state == HIGH) {digitalWrite(LD4, HIGH);  }
  if (SW4_state == LOW) {digitalWrite(LD4, LOW);  }


// Arm Logic: 
if (SW1_state == LOW) 
{
  // system NOT running:
   digitalWrite(LD5, LOW); 
   digitalWrite(LD6, LOW); 
   digitalWrite(LD7, LOW); 
   digitalWrite(LD8, LOW); 
  
} // end if (SW1_State == LOW)
//==============================
 
if (SW1_state == HIGH) 
{     // system is running

  if (SW3_state == LOW)   // manual mode
  {
  // Direction control:  
  // 2.1 If Direction ==0, run motor clockwise
    if (SW2_state == LOW) {indexM = indexM + 1;  }
 
    // 2.2 If Direction ==1, run motor counter clockwise 
    if (SW2_state == HIGH) {indexM = indexM - 1;  }
   } // end if (SW3_state == LOW)

   if (SW3_state == HIGH)   // autoscan mode
   {
     // *** Add your Autoscan codes here ***********************************************************8
     if(auto_direction)
     {
       motor_step++;
       indexM++;
     }
     else
     {
       motor_step--;
       indexM--;
     }
     
     if(motor_step == step_max)
     {
       auto_direction = false; 
     }
     else if (motor_step == 0)
     {
       auto_direction = true;
     }
    
   }   // end if (SW3_state == HIGH) ******************************************************************8

// Timing Control / Speed select processing:
   if (SW4_state == LOW)   // Development (slow)
   {
     motorTime = 500;     // unit in ms
   } 
   if (SW4_state == HIGH)  // Running real motor (fast)
   {
   motorTime = 10;       // unit in ms
   } 

//=========== Stepper Motor Driver ========

   indexM = indexM & 3;  // wraps-around logic
   switch (indexM)
   {
     case 0:
       digitalWrite(LD5, HIGH); 
       digitalWrite(LD6, LOW); 
       digitalWrite(LD7, LOW); 
       digitalWrite(LD8, LOW); 
       break;

     case 1:
       digitalWrite(LD5, LOW); 
       digitalWrite(LD6, LOW); 
       digitalWrite(LD7, HIGH); 
       digitalWrite(LD8, LOW); 
       break;

     case 2:
       digitalWrite(LD5, LOW); 
       digitalWrite(LD6, HIGH); 
       digitalWrite(LD7, LOW); 
       digitalWrite(LD8, LOW);
       break;

     case 3:
       digitalWrite(LD5, LOW); 
       digitalWrite(LD6, LOW); 
       digitalWrite(LD7, LOW); 
       digitalWrite(LD8, HIGH);
       break;

    } // End Switch (indexM)
  
} // end if (SW1_state == HIGH)

  //------------------------------------
   // System Operation LED OFF:
     digitalWrite(ledPin, LOW); 
     delay(motorTime);           // wait for motorTime ms 
  
} // end loop
//=============================



