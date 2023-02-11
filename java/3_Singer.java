/*
 * author    Matt Markfort
 * date      2023-02-11
 *
 * description
 *           This class will represent a Singer
 * the constructor will receive its starting point
 * and a method will print out the verses performed by that singer.
 *
 */

import java.lang.String;
import java.lang.Thread;

public class Singer {
    private static int currentSingerID = 0;
    private int singerID;
    private int startVerse;

    /* Create a singer with the next available singerID */
    public Singer(int verse){
	this.singerID = currentSingerID++;
	this.startVerse = verse;
    }

    /* skipping getters and setters for this demonstration */

    /* add a "singIt" method */
    public void singIt() throws InterruptedException {
	// A serial countdown as per the performance
	for(int i = this.startVerse; i > 0; i--){
	    System.out.printf("%d bottles of beer on the wall\n", i);
	    System.out.printf("%d bottles of beer\n", i);
	    System.out.printf("Take one down, pass it around\n");
	    System.out.printf("%d bottles of beer on the wall\n", i - 1);
	    // Pause for next set of verses
	    Thread.sleep(2000);
	}
    }
}


    
