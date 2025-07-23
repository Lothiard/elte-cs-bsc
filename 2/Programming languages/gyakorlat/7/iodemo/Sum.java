package iodemo;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;

public class Sum {
    public static int AddNumbers(String filename) throws NullPointerException {
        int result = 0;
        BufferedReader buffreader = null;

        File inFile = new File(filename);
        try {
            buffreader = new BufferedReader(new FileReader(inFile));
            String line = buffreader.readLine();
            String[] tokens = line.split(",");

            for(String token : tokens) {
                result += Integer.parseInt(token.trim());
            }
        } catch (FileNotFoundException e) {
            System.err.println("Error: " + e.getMessage());
        } catch (IOException e) {
            System.err.println("Error: " + e.getMessage());
        } catch (NumberFormatException e) {
            System.err.println("Error: " + e.getMessage());
        } 
        return result; 
    }
}