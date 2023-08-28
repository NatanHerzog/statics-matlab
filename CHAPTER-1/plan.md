# Objectives

## Gain access to MATLAB

**There are two ways to access MATLAB**:
- Sign in to [MATLAB Online](https://www.mathworks.com/products/matlab-online.html) (recommended)
    - This is a web-based client that can run on any computer as long as you have internet access
    - Because it's hosted on Mathworks' own servers, it is up-to-date and reliable
    - We won't be doing anything intense enough to warrant the potential advantages of the desktop client
    - Files are stored in your MATLAB Drive, so they can be accessed anywhere
- Download the [Desktop Client](https://software.pitt.edu/Home/SoftwareSearch?SearchText=Matlab&PlatformId=0)
    - <img src="../images/sds-matlab-results.png" alt="search results" width="500" />
    - This link takes you to Pitt's Software Download Service, where it provides instructions for installation *be sure to click into the correct one for your computer (windows, mac, or linux)*
    - The desktop client is a pretty beefy application, so make sure you have enough storage
    - Unlike the web-based client, this will run on your local machine and will therefore use up some amount of processing power and memory while you're in MATLAB
    - You *can* install the MATLAB Drive onto your machine, but the desktop client will work from files on your local machine by default
    - I do not think any of you needs to install this, but if you want to use the desktop client instead of MATLAB Online, feel free. The content will not be different.

For the purposes of this course supplementary material, my instructions will correspond with working in MATLAB Online. If you are using the desktop client and have trouble finding buttons, I recommend that you take advantage of this wonderful thing called the internet. It's quite magical.

## Write a `Hello World` script

The MATLAB environment may be slightly intimidating if you are opening it for the first time, or if you just did not feel very comfortable with it during your previous courses. That's okay! We will be ignoring most of the buttons in the ribbon at the top and I'm going to quickly walk through the bigger sections underneath it.

<img src="../images/initial-matlab-environment.png" alt="initial MATLAB environment" width="500" />

There are 4 general sections that will matter to us, 1 of which is currently hidden and we will get to shortly. You can see `Files`, `Workspace`, and `Command Window`.

As you may imagine, the scripts that you write over time will show up in `Files`. `Workspace` houses any variables that get defined in your scripts. As you look through my examples, you can see that several things are listed there. And the `Command Window` is one place where you can write MATLAB code, but it is also the ouptut window for your scripts. We will be writing scripts.

So, let's click on the `New Script` button in the top left. This will create a blank, unnamed script. You can save (Ctrl + s) and name it. Now we can write some code (refer to example script)

## Understand basic conditional looping

Conditionals are an integral part of coding, but even more importantly, they're an integral part of being an engineer. Our job is pretty much entirely about making decisions based on the information we're given. `If this, then that`.

In MATLAB, we can use `if` statements to check whether something is true or false and then to make a decision based on the result.

But an `if` statement on its own might not be enough. You're designing a bridge that has to be strong enough without going over budget. That probably means going through several different designs. You have to repeat the same task a couple times, then "ask" if the new design is satisfactory. That's a loop!

In MATLAB, we have two types of loops: `for` and `while`. When we know exactly how many times to perform an operation, `for` loops are our best friend. They're pretty simple to use. But as engineers, we usually don't know things like that ahead of time. In that case, `while` loops are super awesome. Check out the example to see how they're both used!