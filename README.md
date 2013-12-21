A simple MVC example & callback with blocks. I made this as a test when applying for an iOS position.

============================================

This is an assignment designed specifically to test how much a candidate knows about code quality, object oriented principles, programming best practices, design patterns and written communication skills. The output of this assignment would be the base for evaluation and will be followed by a technical interview if qualified.

Write a simple program to meet the following specifications and emphasize your knowledge and fluency in object oriented programming.

Main types of objects to be implemented in the program 
-	Main: Should be an iOS app with 
  o	a single button to run the requests SIMULTANEOUSLY
  o	one textview for each request to be updated as soon as the processing of corresponding request finishes
-	Request: This is a type of object, which grabs some data from a web resource through a URL. It should take the needed URL as a parameter, get the contents of that URL (assume a webpage), hold the response in a field locally, and process the response and prepare an output for the main program.

Functionality
The main should define and run 3 requests SIMULTANEOUSLY, each request is defined below;
1) 10thLetterRequest: 
 - Grab a website’s content from the web
 - Hold the web page content as a String and make it accessible from the Main 
 - Process the web page content: Find the 10th letter in the web page text and report it back to the Main program via a callback. 

2) Every10thLetterRequest:
 - Grab a website’s content from the web
 - Hold the web page content as a String and make it accessible from the Main 
 - Process the web page content: Find every 10th letter(i.e: 10th, 20th, 30th etc.) in the web page text and report it back to the Main program via a callback. This callback should bring an appropriate data structure.

3) WordCounterRequest
 - Grab a website’s content from the web
 - Hold the web page content as a String and make it accessible from the Main 
 - Process the web page content: Split the text into words by using whitespace characters (i.e: space, linefeed etc.) and write a simple algorithm to count every word in the document and report it back to the Main program via a callback. You can disregard html/javascript etc. and treat every word equally. The callback should bring an appropriate data structure of words and counts. So the main program should be able to ask how many times a certain word appears in the website.

No need to make the Main app parametric, you can define the website’s URL and such as constants. The reason for this assignment is to show how fluent the candidate is in OOP practices. So design your assignment accordingly, follow best practices, design patterns where relevant, and collect common things together, utilize code-reuse etc.


