## cs674-HW2

The goal of this assignment was to use one of the many methods available to find motifs,
repeated patterns in time series data, in order to classify new observed time series. For this assignment
I used R along with the jmotif and mclust packages. Each file was read into as as a dataframe and then
divided into train, test, train labels, and test labels. This was then fed into the the manyseriestobag
method in order to create a bag of patterns from the SAX transformed training data. The bag of
patterns representation. First, the method converts each time series into a SAX representation based on
a specific window size, alphabet, and PAA size. Piecewise Aggregate Approximation is designed to
reduce the input time series dimensionality by splitting it into equally-sized segments (PAA size) and
averaging values of points within each segment. The window size indicates the size of the interval
used to convert to SAX, while the alphabet determines the number of different letters used for the
representation of a time series segment in SAX. The algorithm utilized in this method is the MK
algorithm, which was greatly faster than random projection, which is utilized in the TSMining package,
which was another method I had tried.

After the SAX representation of each time series is processed, the method converts the SAX
representation of each time series into a bag of SAX words for each of the classes. Bags are combined
into a corpus, which is built as a term frequency matrix, whose rows correspond to the set of all SAX
words (terms) found in all classes, whereas each column denotes a class of the training set. Each
element of this matrix is an observed frequency of a term in a class. Because SAX words extracted
from the time series of one class are often not found in others, this matrix is usually sparse. Once all
frequency values are computed, term frequency matrix becomes the term weight matrix, whose
columns used as class’ term weight vectors that facilitate the classification using cosine similarity.
Although I didn’t perform any feature reduction, using the tfidf matrix, you can find the motifs
that are most discriminative of a particular class. The most discriminative SAX words for a particular
class have the highest tfidf weight in that class. I used 1-Nearest Neighbors for classification.
