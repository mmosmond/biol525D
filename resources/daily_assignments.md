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
I would first trim the tag sequence off (-trim_left 5). Next I would trim off low quality reads at the ends of sequences(-trim_qual_left 10 -trim_qual_right 10). I would then trim off poly A/T tails (-trim_tail_left 5 -trim_tail_right 5). I would then filter out sequences with a high percentage of Ns (-ns_max_p 1). To remove long stretches of repeated bases I would then set a minimum entropy score (-lc_method entropy -lc_threshold 70). Finally, I would remove low quality sequences (-min_qual_mean 25). This leaves us with a pretty nice looking output, although there are still 3 sequences with poly A/T tails of ~10bp that I can't seem to get rid of!

perl ~/programs/prinseq-lite-0.20.4/prinseq-lite.pl -fastq GBS12_brds_Pi_197A2_100k_R1.fastq -fastq2 GBS12_brds_Pi_197A2_100k_R2.fastq -log log1 -out_good GBS_filter1 -trim_left 5 -trim_qual_left 10 -trim_qual_right 10 -trim_tail_left 5 -trim_tail_right 5 -ns_max_p 1 -lc_method entropy -lc_threshold 70 -min_len 30 -min_qual_mean 25

###Topic 4:
I want to reduce the percent of incorrectly mapped reads when using BWA. What setting or settings should I change in BWA?

###Answer:
There are a number of setting you could change in bwa-mem to reduce the proportion of incorrectly mapped reads. For instance, you could increase the minimum seed length (-k) so that incorrect mappings are less likely to be seeded in the first place. You could also lower the band width (-w), preventing the creation of large gaps. Or you could decrease the Z-dropoff (-d), which prevents poor alignments from forming during the Smith-Waterman algorithm. Another option is to lower the length of seed that triggers re-seeding (-r). Perhaps the most obvious choice is to change the SW scoring matrix: e.g., you could increase the mismatch penalty (-B), the gap open penalty (-O), or the gap extension penalty (-E). Then with a reasonably large clipping penalty (-L) incorrect reads will be removed. 

###Topic 5:
Quantify the assembly metrics for your first assembly that you ran without any options (sa_assembly21). Pick two or three different sets of parameters to run. Compare the resulting assemblies with one another and discuss which ones seemed to have improved the assembly and why that might be.

###Answer:
I played around with a few setttings (-min_contig_lgth, -scaffolding, -ins_length) but the one that had the largest impact was coverage cutoff (-cov_cutoff). Increasing minimum coverage obviously reduces the number of sequences assembled and the total length of the assembled region. However, an intermediate cutoff maximizes the average length of a contig and the n50 (and hence improves assembly most). An intermediate coverage cutoff is presumably helping by removing errorenous contigs.

-cov_cutoff 0
File		Number of sequences	Average length		Total length	Median	min	max	n50
contigs.fa	89110			75.059645382112		6688565		65	41	967	74

-cov_cutoff 10
File		Number of sequences	Average length		Total length	Median	min	max	n50
contigs.fa	2615			1063.75564053537	2781721		534	41	11869	2330

-cov_cutoff 100
File		Number of sequences	Average length		Total length	Median	min	max	n50
contigs.fa	83			292.012048192771	24237		164	41	2217	566

####Questions 2-5 are due Monday August 22nd.

###Topic 6:
What expression measure would you use to compare gene expression between different genes and why? Is it appropriate to compare the raw expression counts? Can you get more appropriate data from RSEM?

###Answer:
I would use FPKM (fragments per kilobase of transcript per million reads mapped) because it corrects for transcript length (per kilobase of transcript), allowing for comparisons between genes. It also corrects for the total size of the library (per million reads mapped), allowing for comparisons of gene expression between individuals. It is not appropriate to compare the raw expression counts because of the above issues: (i) longer transcripts will have more fragments sequenced and (ii) because of variability in DNA extraction and processesing individuals will differ in the number of fragments sequenced. RSEM (RNAseq by expectation-maximization) outputs FPKM (rsem-calculate-expression) from FASTA or FASTQ input. 

###Topic 7:
What is strand bias and why would you filter based on it?

###Answer:
As stated on the GATK website, "[s]trand bias is a type of sequencing bias in which one DNA strand is favored over the other...." It is detected by a difference in the number of reference and alternate nucleotides between forward and reverse strands (p-value from Fisher's exact test). You want to filter SNPs with sufficiently likely strand bias because it means the information you are using to detect the SNP is erroneous in some way (sorry, a little vague here because still unsure of where the bias comes from - it sounds like some bias can occur during sequencing and some through filtering). 

###Topic 8:
What is the average Fst between the two populations in our example data? Hint, SNPrelate can calculate Fst.

###Answer:
snpgdsFst gives me an average Fst of roughly 0.499, using 4289 SNPs. 

###Topic 10:
What does it mean when something has 50% bootstrap support? What are two possible reasons that a node may have low support? Include one biological and one methodological reason.

###Answer:
50% bootstrap support means 50% of the analyses run with resampled data (sampling with replacement from orginal data) gave the same result (e.g., produced trees with a particular node). A node can have low support if there was gene flow (or hybridization!) such that some areas of the genome are highly diverged while others are not (and then you can get different results when one area is resampled more than the other by chance). A node can also have low support if the tree is too big, such that there are many possible trees and therefore resampling results are more variable.
