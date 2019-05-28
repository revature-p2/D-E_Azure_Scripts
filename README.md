# Revature Project 2

Co-authors: 

	Eric Allen, Efrain Dorado, David Nelson, Ashish Saxena


Goal:

	Build an alternative cloud service provider on top of azure. 


Work split:

	Eric: Script writing, collabertation on the back end server, researcher, health check

	Efrain: Front end construction, worked in partner with backend team, created presentation

	David: Back end functionality construction, script writing

	Ashish: MSAL login constuction, script writing


Main Aspects:

	Login page

		MSAL authentication - using microsoft's Identity provider to utilize its OAuth service
	
		Constructed with: HTML, CSS, JS
	
	Client Side

		Constucted a HTML page to create a user interface
	
		Forms and inputs were used for GET requests by the back end server
	
		Constucted with: HTML, CSS, JS
	
	Server Side

		Used the node API child-process as a way to "spawn" commands to the terminal and run them. 
	
		A GET request is utilized to interact with the HTML forms 
	
		Request queries of inputs in those forms are used to act as arguments in the scripts "spawned" onto the terminal command 		 line
	
		The forms are run upon a submit on the client side
	
		Constructed with: JS
	
	Bash Scripts

		Multiple scripts that allow our user to construct resources through azure
	
		Gave the user the ability to personalize the resources they create

