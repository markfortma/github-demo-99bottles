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

public class Round {
    // The countdown will start here and a copy will decrement for the
    // performance
    private static final int START = 4;

    public static void main(String[] args) throws InterruptedException {
	// Create a container to host each thread
	Singer[] quartet = new Singer[START];
	for(int i = 0; i < START; i++){
	    // Create a new singer, add it to our list, and then call its start
	    quartet[i] = new Singer(START);
	    quartet[i].start();
	}

	// Loop over our threads and rejoin them to main
	for(int i = 0; i < START; i++){
	    quartet[i].join();
	}
    }
}
