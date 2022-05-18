#include <BLEDevice.h>
#include <BLEServer.h>
#include <BLEUtils.h>
#include <BLE2902.h>


BLECharacteristic *pCharacteristic;
bool deviceConnected = false;

String knownBLEAddresses = "14:08:06:0f:3f:15";
int RSSI_THRESHOLD = -70;
uint8_t scanTime = 0.5; //In seconds
BLEScan* pBLEScan;
bool setupMade = false;
int timer = 0;
bool connectedToApp = 0;
String deviceName;
String deviceAddress;
int16_t deviceRSSI;
int threshold_light = 0;

const uint8_t LED = 23;// Could be different depending on the dev board. I used the DOIT ESP32 dev board.
const uint8_t INPUT_LIGHT = 36;

TaskHandle_t taskC;
TaskHandle_t taskS;

#define SERVICE_UUID           "f945730e-ca18-11ec-9d64-0242ac120002"
#define CHARACTERISTIC_UUID_RX "f945730e-ca18-11ec-9d64-0242ac120002"
#define CHARACTERISTIC_UUID_TX "f945730e-ca18-11ec-9d64-0242ac120002"

class MyServerCallbacks: public BLEServerCallbacks {
    void onConnect(BLEServer* pServer) {
      deviceConnected = true;
      Serial.println("Device connected.");
    };

    void onDisconnect(BLEServer* pServer) {
      deviceConnected = false;
      Serial.println("Device disconnected.");
      setup();
    }
};

void light_by_app(std::string rxValue) {
  // Do stuff based on the command received from the app
  if (rxValue.find("1") != -1) { 
    Serial.println("Turning ON!");
    digitalWrite(LED, HIGH);
  }
  else if (rxValue.find("0") != -1) {
    Serial.println("Turning OFF!");
    digitalWrite(LED, LOW);
  }
}

class MyCallbacks: public BLECharacteristicCallbacks {
    void onWrite(BLECharacteristic *pCharacteristic) {
      std::string rxValue = pCharacteristic->getValue();
      
      if (rxValue.length() > 0) {
        Serial.println("*********");
        Serial.print("Received Value: ");
        for (int i = 0; i < rxValue.length(); i++) {
          Serial.println(rxValue[i]);
          light_by_app(rxValue);
      }
      Serial.println();
      Serial.println("*********");
    }
  }
};

void light_by_proximity(int deviceRSSI){
  //&& threshold_light < 3000
  if (deviceRSSI > RSSI_THRESHOLD && threshold_light < 3000){
    digitalWrite(LED, HIGH); // Turn on LED
    delay(5000);
  } else {
    Serial.println("Turning OFF!");
    digitalWrite(LED, LOW);
  }
}

class MyAdvertisedDeviceCallbacks: public BLEAdvertisedDeviceCallbacks {
    void onResult(BLEAdvertisedDevice d) {
        if (!deviceConnected) {
        if (strcmp(d.getAddress().toString().c_str(), knownBLEAddresses.c_str()) == 0){
           deviceName = d.getName().c_str();
           deviceAddress = d.getAddress().toString().c_str();
           deviceRSSI = d.getRSSI();

           Serial.println(deviceRSSI);
           light_by_proximity(deviceRSSI);
          
        }
        } else {
          Serial.println("The LED is controlled by app.");
        }
    }
};

void taskSCode(void *param) {
  Serial.print("TaskServer running on core ");
  Serial.println(xPortGetCoreID());

  for (;;) {
    threshold_light = analogRead(INPUT_LIGHT);
    Serial.println(threshold_light);
    delay(100);
  }
  vTaskDelete(NULL);
}

void taskCCode(void *param) {
  Serial.print("TaskClient running on core ");
  Serial.println(xPortGetCoreID());
  
  for (;;) {
    // get env light
    threshold_light = analogRead(INPUT_LIGHT);
    Serial.println(threshold_light);
    delay(100);
    BLEScanResults foundDevices = pBLEScan->start(scanTime, false);
    pBLEScan->clearResults();
  }
  vTaskDelete(NULL);
}

void setup() {
  Serial.begin(115200);

  pinMode(LED, OUTPUT);
  pinMode(INPUT_LIGHT, OUTPUT);

   // Create the BLE Device
  BLEDevice::init("ESP32"); // Give it a name
    
  // Create the BLE Server
  BLEServer *pServer = BLEDevice::createServer();
  pServer->setCallbacks(new MyServerCallbacks());
  
  // Create the BLE Service
  BLEService *pService = pServer->createService(SERVICE_UUID);
  
  // Create a BLE Characteristic
  pCharacteristic = pService->createCharacteristic(
                        CHARACTERISTIC_UUID_TX,
                        BLECharacteristic::PROPERTY_NOTIFY
                      );
                        
  pCharacteristic->addDescriptor(new BLE2902());
  
  BLECharacteristic *pCharacteristic = pService->createCharacteristic(
                                           CHARACTERISTIC_UUID_RX,
                                           BLECharacteristic::PROPERTY_WRITE
                                         );
  
  pCharacteristic->setCallbacks(new MyCallbacks());
  
  // Start the service
  pService->start();
  
  // Start advertising
  pServer->getAdvertising()->start();
  Serial.println("Waiting a client connection to notify..."); 

  // Create the BLE Device
  BLEDevice::init("Dev"); // Give it a name
  Serial.println("Scanning..."); // Print Scanning    
  pBLEScan= BLEDevice::getScan(); //create new scan
  pBLEScan->setAdvertisedDeviceCallbacks(new MyAdvertisedDeviceCallbacks()); //Init Callback Function
  pBLEScan->setActiveScan(true); //active scan uses more power, but get results faster
  pBLEScan->setInterval(200); // set Scan interval
  pBLEScan->setWindow(100);  // less or equal setInterval value;

  xTaskCreatePinnedToCore(
      taskSCode, /* Function to implement the task */
      "taskS", /* Name of the task */
      10000,  /* Stack size in words */
      NULL,  /* Task input parameter */
      0,  /* Priority of the task */
      &taskS,  /* Task handle. */
      0); /* Core where the task should run */

  xTaskCreatePinnedToCore(
      taskCCode, /* Function to implement the task */
      "taskC", /* Name of the task */
      10000,  /* Stack size in words */
      NULL,  /* Task input parameter */
      10,  /* Priority of the task */
      &taskC,  /* Task handle. */
      1); /* Core where the task should run */
}

void loop() {
}
