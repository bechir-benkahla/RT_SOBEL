# RT_SOBEL
Hardware implementation of an edge detection algorithm (Sobel)

-This is a Hardware implementation of the edge detection Algorithm Sobel

-Considering the real time constraints of the problem, implementation was done through a full custom hardware design based on the following article : 

"Hardware Description of Multi-Directional Fast Sobel Edge Detection Processor by VHDL for Implementing on FPGA"
                                                                                Arash Nosrat & Yousef S. Kavian

link : https://pdfs.semanticscholar.org/db01/7af04855f71d5dccd0980eb5e3e37083474c.pdf

For reading an writting PGM images we used the library provided by Mr Martin Thoompson available at the following a address :
https://github.com/nkkav/image_processing_examples

The General architecture is described by the folloing figure : 

![alt text](https://github.com/bechir-benkahla/RT_SOBEL/blob/master/img/arch_glob.jpg)





project files tree : 

-->src : vhdl source files directory
-->doc : documentation of the project

