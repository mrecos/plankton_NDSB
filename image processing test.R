library("EBImage")
working_file <- paste("c://data/plankton/train/acantharia_protist/2441.jpg",sep="") #"101260.jpg"
img <- readImage(working_file)
im(img)

imgT <- img < mean(img) # threshold at mean
imgT2 <- img < median(img) # threshold at median
imgT3 <- thresh(img, offset=0.01)

fhi = matrix(1, nc=3, nr=3)
fhi[2,2] = -8
imgfhi = filter2(img, fhi)

kern = makeBrush(5, shape='diamond')
imgD <- dilate(img, kern)
imgE <- erode(img, kern)


lblT <- bwlabel(imgT)
lbl2 <- bwlabel(img < 0.98)
lbl3 <- bwlabel(imgT3)

### method similar to https://www.kaggle.com/c/datasciencebowl/details/tutorial
# img2 <- thresh(img, w=30, h=30, offset=0.02)
# img2 <- thresh(img)
img2 <- img > mean(img)
img2 <- ifelse(img2 == TRUE, 0, 1)
kern = makeBrush(3, shape='diamond')
# img22 <- dilate(erode(img2, kern), kern)
img22 <- dilate(img2, kern)
img2LBL <- bwlabel(img22)
im(img2LBL)
cat('Number of parts=', max(img2LBL),'\n')

for(i in 1:max(img2LBL)){
  im(img2LBL == i)
}

img3 <- img2LBL == 1
extract_stats(img3) # processed
extract_stats(img) # original
