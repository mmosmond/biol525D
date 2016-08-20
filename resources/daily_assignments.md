# Daily assignments
These are the questions selected for marking. Reminder, answers should be <= 1 paragraph in length. 
Answers should be sent to gregory.owens@alumni.ubc.ca

###Topic 2:
Why is piping directly between programs faster than writing each consecutive output to the disk? Explain using information about computer hardware.

###Answer:

i) If piping from process A to B, then B can start working on the data that A has processed, before A is finished with all the data.

ii) Piping also avoids writing the intermediate product to disk (storage) and instead the information is kept in the computers memory. Keeping information in memory is faster than putting it in storage because memory is physically closer to the CPU (central processing unit), which processes the information, and because memory has parallel high bandwidth connections to the CPU while storage is connect by a serial cable that is much slower. Finally, traditional hard drives rely on magnetism and moving parts while memory is non-moving and relies on voltage, which means things can happen at nearly the speed of light.    

###Topic 3:
Try different filtering options for the GBS data (see http://prinseq.sourceforge.net/manual.html for options) and plot some QC graphs. Which options you would choose to implement if this was your data and why?

###Answer:

###Topic 4:
I want to reduce the percent of incorrectly mapped reads when using BWA. What setting or settings should I change in BWA?
###Topic 5:

####Questions 2-5 are due Monday August 22nd.
###Topic 6:

###Topic 7:

###Topic 8:

###Topic 9:

###Topic 10:

####Questions 6-10 are due Monday August 29th.
