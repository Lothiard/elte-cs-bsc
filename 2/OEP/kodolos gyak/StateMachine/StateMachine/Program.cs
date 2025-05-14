namespace CarAlarm {
    public class Program {
        static void Main(string[] args) {
            Console.OutputEncoding = System.Text.Encoding.UTF8;
            CarAlarmSystem carAlarmSystem = new CarAlarmSystem(4);

            PrintStates(carAlarmSystem);
            Console.WriteLine("> Opening door 2 on keypress...");
            Console.ReadKey(true);
            carAlarmSystem.Doors[2].Open();

            PrintStates(carAlarmSystem);
            Console.WriteLine("> Closing door 2 on keypress...");
            Console.ReadKey(true);
            carAlarmSystem.Doors[2].Close();

            PrintStates(carAlarmSystem);
            Console.WriteLine("> Arming alarm system on keypress...");
            Console.ReadKey(true);
            carAlarmSystem.Controller.Arm();

            PrintStates(carAlarmSystem);
            Console.WriteLine("> Simulating movement on keypress...");
            Console.ReadKey(true);
            carAlarmSystem.Sensor.MovementDetected = true;
            
            PrintStates(carAlarmSystem);
            Console.WriteLine("> Disarming on keypress...");
            Console.ReadKey(true);
            carAlarmSystem.Controller.Disarm();

            PrintStates(carAlarmSystem);
            Console.WriteLine("> Arming alarm system on keypress...");
            Console.ReadKey(true);
            carAlarmSystem.Controller.Arm();

            PrintStates(carAlarmSystem);
            Console.WriteLine("> Opening door 2 on keypress...");
            Console.ReadKey(true);
            carAlarmSystem.Doors[2].Open();

            PrintStates(carAlarmSystem);
            Console.WriteLine("> Disarming on keypress...");
            Console.ReadKey(true);
            carAlarmSystem.Controller.Disarm();

            PrintStates(carAlarmSystem);
            Console.WriteLine("> Turning off alarm system on keypress...");
            Console.ReadKey(true);
            carAlarmSystem.Stop();

            PrintStates(carAlarmSystem);
        }

        static void PrintStates(CarAlarmSystem carAlarmSystem) {
            Console.Clear();
            for (int i = 0; i < carAlarmSystem.Doors.Count; i++) {
                Door door = carAlarmSystem.Doors[i];
                PrettyPrint($"DOOR #{i}:  ", ConsoleColor.Cyan);
                foreach (DoorState doorState in Enum.GetValues(typeof(DoorState))) {
                    if (door.CurrentState.Equals(doorState)) {
                        PrettyPrint($"{doorState} ", ConsoleColor.Green);
                    } else {
                        PrettyPrint($"{doorState} ", ConsoleColor.DarkGray);
                    }
                }
                Console.WriteLine();
            }

            PrettyPrint($"ALARM:    ", ConsoleColor.Cyan);
            foreach (AlarmState alarmState in Enum.GetValues(typeof(AlarmState))) {
                if (carAlarmSystem.Alarm.CurrentState.Equals(alarmState)) {
                    PrettyPrint($"{alarmState} ", ConsoleColor.Green);
                } else {
                    PrettyPrint($"{alarmState} ", ConsoleColor.DarkGray);
                }
            }
            Console.WriteLine();

            PrettyPrint($"BEEPER:   ", ConsoleColor.Cyan);
            foreach (BeeperState beeperState in Enum.GetValues(typeof(BeeperState))) {
                if (carAlarmSystem.Beeper.CurrentState.Equals(beeperState)) {
                    PrettyPrint($"{beeperState} ", ConsoleColor.Green);
                } else {
                    PrettyPrint($"{beeperState} ", ConsoleColor.DarkGray);
                }
            }
            Console.WriteLine();

            PrettyPrint($"SENSOR:   ", ConsoleColor.Cyan);
            foreach (SensorState sensorState in Enum.GetValues(typeof(SensorState))) {
                if (carAlarmSystem.Sensor.CurrentState.Equals(sensorState)) {
                    PrettyPrint($"{sensorState} ", ConsoleColor.Green);
                } else {
                    PrettyPrint($"{sensorState} ", ConsoleColor.DarkGray);
                }
            }
            Console.WriteLine();
            
            Console.WriteLine();
            PrettyPrint("Logs:", ConsoleColor.DarkGray);
            Console.WriteLine();
            carAlarmSystem.Alarm.FlushLogs();
            carAlarmSystem.Beeper.FlushLogs();
            carAlarmSystem.Sensor.FlushLogs();
            Console.WriteLine();
            Console.WriteLine();
        }

        static void PrettyPrint(string text, ConsoleColor color = ConsoleColor.Gray) {
            Console.ForegroundColor = color;
            Console.Write(text);
            Console.ResetColor();
        }
    }
}
