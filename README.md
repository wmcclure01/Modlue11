# Modlue11
Homework 11
The code below contains a 'deliberate' bug!  

tukey_multiple <- function(x) {
   outliers <- array(TRUE,dim=dim(x))
   for (j in 1:ncol(x))
    {
    outliers[,j] <- outliers[,j] && tukey.outlier(x[,j])
    }
outlier.vec <- vector(length=nrow(x))
    for (i in 1:nrow(x))
    { outlier.vec[i] <- all(outliers[i,]) } return(outlier.vec) }

> Find the bug and fix it.
>>Report on your blog the success or failure in your debugging procedure.



# Solution
<!-- wp:paragraph -->
<p>First we review the the function in code and see what may be.</p>
<!-- /wp:paragraph -->

<!-- wp:syntaxhighlighter/code {"language":"r"} -->
<pre class="wp-block-syntaxhighlighter-code">
tukey_multiple &lt;- function(x) 
{
  outliers &lt;- array(TRUE,dim=dim(x))
  for (j in 1:ncol(x))
  {
    outliers[,j] &lt;- outliers[,j] &amp;&amp; tukey.outlier(x[,j])
  }
  outlier.vec &lt;- vector(length=nrow(x))
  for (i in 1:nrow(x))
  { outlier.vec[i] &lt;- all(outliers[i,]) } return(outlier.vec) }</pre>
<!-- /wp:syntaxhighlighter/code -->

<!-- wp:syntaxhighlighter/code {"language":"r"} -->
<pre class="wp-block-syntaxhighlighter-code">>   { outlier.vec[i] &lt;- all(outliers[i,]) } return(outlier.vec) }
Error: unexpected symbol in "  { outlier.vec[i] &lt;- all(outliers[i,]) } return"</pre>
<!-- /wp:syntaxhighlighter/code -->

<!-- wp:paragraph -->
<p>Surprise!! An error! The syntax of this function is wrong. Spacing and placement are allowing the compiler to misread the code.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>If we update the syntax with proper formatting (which also makes it easier to read, not just for you but whoever may use it in the future):</p>
<!-- /wp:paragraph -->

<!-- wp:syntaxhighlighter/code {"language":"r"} -->
<pre class="wp-block-syntaxhighlighter-code">tukey_multiple &lt;- function(x)
{
  outliers &lt;- array(TRUE,dim=dim(x))
  for (j in 1:ncol(x))
  {
    outliers[,j] &lt;- outliers[,j] &amp;&amp; tukey.outlier(x[,j])
  }
  outlier.vec &lt;- vector(length=nrow(x))
  for (i in 1:nrow(x))
  { outlier.vec[i] &lt;- all(outliers[i,])
  
  }
  return(outlier.vec)
  
}</pre>
<!-- /wp:syntaxhighlighter/code -->

<!-- wp:paragraph -->
<p>It compiles! Now we can test it with a random data set. I choose the iris dataset built in.</p>
<!-- /wp:paragraph -->

<!-- wp:syntaxhighlighter/code {"language":"r"} -->
<pre class="wp-block-syntaxhighlighter-code">tukey_multiple(df)
Error in tukey.outlier(x[, j]) : could not find function "tukey.outlier"</pre>
<!-- /wp:syntaxhighlighter/code -->

<!-- wp:paragraph -->
<p>So here we see a portion of the function failed because it could not find the other function named <em>tukey.outlier</em>. When the error says it could not find, I typically check the CRAN repositories to see what the function does and where it is loaded/associated with. </p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>According to the website <a href="https://rdrr.io/cran/funModeling/man/tukey_outlier.html">rdrr.io</a> there is a function called <em>tukey_outlier </em>and it exists in the funModeling package. I added the library then, updated the code to reflect the chhange in function name, an '_' instead of '.', and reran.</p>
<!-- /wp:paragraph -->

<!-- wp:syntaxhighlighter/code {"language":"r"} -->
<pre class="wp-block-syntaxhighlighter-code"> tukey_multiple2(df)
 Error in quantile.default(input_cleaned, na.rm = T, names = F) : 
(unordered) factors are not allowed</pre>
<!-- /wp:syntaxhighlighter/code -->

<!-- wp:paragraph -->
<p>In the Iris dataset there is a column called Species and it is a factor datatype. Since this function checks all columns for a numerical outlier type this won't due. Since we are just checking functionality and not actually analyzing the iris dataset, I just removed the column and reran the function.</p>
<!-- /wp:paragraph -->

<!-- wp:syntaxhighlighter/code {"language":"r"} -->
<pre class="wp-block-syntaxhighlighter-code">df &lt;- subset(df, select = -c(Species))
> tukey_multiple2(df)
  [1] TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE
 [36] TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE
 [71] TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE
[106] TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE
[141] TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE</pre>
<!-- /wp:syntaxhighlighter/code -->

<!-- wp:paragraph -->
<p>The function <strong><em>Lives</em></strong>!</p>
<!-- /wp:paragraph -->
