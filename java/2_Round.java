/*
 * author   Matt Markfort
 * date     2023-02-11
 *
 * description
 *          The number preceding this file name is to ensure that
 * the correct order of changes to the commit occur.
 *
 *          This will perform "99 Bottles of Beer on the Wall" 
 * (starting at 4, for brevity).
 */

import java.lang.String;
import java.lang.Thread;

public class Round {
    // The countdown will start here and a copy will decrement for the
    // performance
    private static final int START = 4;

    public static void main(String[] args) throws InterruptedException {
	// A serial countdown as per the performance
	for(int i = START; i > 0; i--){
	    System.out.printf("%d bottles of beer on the wall\n", i);
	    System.out.printf("%d bottles of beer\n", i);
	    System.out.printf("Take one down, pass it around\n");
	    System.out.printf("%d bottles of beer on the wall\n", i - 1);
	    // Pause for next set of verses
	    Thread.sleep(2000);
	}
    }
}
