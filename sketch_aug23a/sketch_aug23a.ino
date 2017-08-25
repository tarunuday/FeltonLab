int var=0;
int nosamples=1000;
#include <Wire.h>
#include <Adafruit_MotorShield.h>
#include "utility/Adafruit_MS_PWMServoDriver.h"
Adafruit_MotorShield AFMS = Adafruit_MotorShield();
Adafruit_DCMotor *myMotor = AFMS.getMotor(3);
void setup() {
  Serial.begin(230400);
  
  AFMS.begin();
  myMotor->setSpeed(250);
  myMotor->run(FORWARD);
  
  pinMode(6, INPUT);
  pinMode(7, INPUT);
}

void loop() {
  delay(3000);
  while(var<nosamples)
  {
    Serial.println(digitalRead(6));
    Serial.println(digitalRead(7));
    var++;
  }
  
  Serial.println(millis());
  myMotor->run(RELEASE);
  delay(10000000);
}
