package stopwatchswing;

import java.awt.*;
import javax.swing.*;
import java.awt.event.*;

public class Stopwatch extends JFrame {
    enum State { operate, stopped }
    private State currentState;
    private int seconds = 0;
        
    private final static int SECOND = 1000 /* milliseconds */;
    private Timer timer = new Timer(SECOND, null);
    private LcdNumber lcd = new LcdNumber("00:00");    
    private JButton clickButton = new JButton("Start/Stop");
    private JButton zeroButton = new JButton("Null");
    private JPanel buttonPanel = new JPanel();
    
    public Stopwatch() {        
        super("Stopwatch");        
        setBounds(250, 250, 300, 200);        
        setDefaultCloseOperation(EXIT_ON_CLOSE);        
        buttonPanel.setBackground(Color.WHITE);
        buttonPanel.add(clickButton);
        buttonPanel.add(zeroButton);
        add(lcd);
        add(buttonPanel, "South");
        
        clickButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                click();
            }            
        });
        
        zeroButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                zero();
            }     
        });
        
        timer.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                tick();                
            }
        });
        
        currentState = State.stopped;
	lcd.display(seconds);
        timer.start();
        setVisible(true);
    }
    
    @Override
    protected void finalize() throws Throwable {
        if (timer.isRunning()) timer.stop();
        super.finalize();
    }
    
    void click() {
        switch (currentState)   {
            case operate : 
                currentState = State.stopped;
                break;
            case stopped :   
                currentState = State.operate;
                break;    
        } 
    }
     
    void zero() {
        switch (currentState)   {
            case operate : 
                currentState = State.stopped;
                break;
            case stopped :   
                break;    
        } 
        seconds = 0;
        lcd.display(seconds);
    }
    
    void tick() {
        switch (currentState)   {
            case operate : 
                ++seconds;
                lcd.display(seconds);
                break;
            case stopped :   break;    
        }    
    }

    public static void main(String[] args) {
        new Stopwatch();
    }    
} // Stopper

