package stopwatchswing;

import java.awt.*;
import javax.swing.*;

public class LcdNumber extends JLabel {

    public LcdNumber(String text) {
        super(text);
        setHorizontalAlignment(JLabel.CENTER);
        setOpaque(true);
        setBackground(Color.WHITE);
        setForeground(Color.BLUE);
        setFont(new Font(Font.DIALOG, Font.PLAIN, 40));
    }

    public void display(int seconds) {
        setText(String.format("%02d:%02d",
                    (seconds % 3600) / 60,      // minutes 
                    (seconds % 3600) % 60));     // seconds
    }
} // LcdNumber
