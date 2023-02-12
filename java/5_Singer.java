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
import java.lang.Runnable;

public class Singer extends Thread {
    private static int currentSingerID = 0;
    private int singerID;
    private int startVerse;

    /* Create a singer with the next available singerID */
    public Singer(int verse){
        super();
	this.singerID = currentSingerID++;
	this.startVerse = verse;
    }

    /* skipping getters and setters for this demonstration */

    /* add a "singIt" method */
    /* when start is called in Thread it calls run
     */
    @Override
    public void run() {
	// A serial countdown as per the performance
	for(int i = this.startVerse; i > 0; i--){
	    System.out.printf("Singer %d: %d bottles of beer on the wall\n", this.singerID, i);
	    System.out.printf("Singer %d: %d bottles of beer\n", this.singerID, i);
	    System.out.printf("Singer %d: Take one down, pass it around\n", this.singerID);
	    System.out.printf("Singer %d: %d bottles of beer on the wall\n", this.singerID, i - 1);
	    try {
		// Pause for next set of verses
		Thread.sleep(2000);
	    } catch(InterruptedException interrupted){
		System.out.println("encountered InterruptedException. ignoring");
	    }
	}
    }
}


    
