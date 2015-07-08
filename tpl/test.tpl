<!doctype html>
<html>
    <head>
        <meta charset="utf-8">
        <title>busfactor/web4.0</title>
        <script src="http://localhost:9001/js/server.js"></script>
        <link rel="stylesheet" href="static/primer.css">
        <link rel="stylesheet" href="static/octicons.css">
        <link rel="stylesheet" href="static/dontworryaboutit.css">       
    </head>
    <body class="container">
        <header class="columns bf-header">
            <div class="column one-half">
                <a id="logo" href="https://github.com" class="tooltipped tooltipped-se" aria-label="Visit GitHub!">
                    <i class="mega-octicon octicon-mark-github"></i>
                </a>
            <form>
                <input class="input-block" type="text" placeholder="Search..." disabled>
            </form>
            </div>
            <div class="column one-half">
                <nav>
                    <a href="#"><i class="octicon octicon-globe"></i> Lorem</a>
                </nav>
                <nav class="right">
                    <a href="#"><i class="octicon octicon-mortar-board"></i> Ipsum</a>
                    <!--
                    <a href="#" class="tooltipped tooltipped-w" aria-label="Want to buy us a beer?"><i class="octicon octicon-beer"></i></a>
                    <a href="#" class="tooltipped tooltipped-sw" aria-label="Calculate Your Bus Factor!"><i class="octicon octicon-plus"></i></a>
                    -->
                </nav>
            </div>
        </header>
        <main>
            <div style="margin-top: 1em;"></div>
                <div style="background: #fff">
                    <h1>GitHub Repos with Highest Bus Factor</h1>
                    <h3 style="font-weight: normal">&ldquo;if you were to get hit by a bus tomorrow...&rdquo;</h3>

                    <hr>
<!-- {{#invalid}} -->
                    <div class="flash flash-error flash-with-icon">
                        <span class="octicon octicon-alert"></span>
                        Invalid repository!
                    </div>
            <div style="margin-top: 1em;"></div>
<!-- {{/invalid}} -->
                    <form action="test" method="post">
                        <div>
                            <label>Enter a GitHub repo:</label>
                            <input class="input-block input-large" type="text" name="repo" placeholder="e.g. torvalds/linux">
                        </div>
            <div style="margin-top: 1em;"></div>
                        <div class="form-actions">
                                <button type="submit" class="btn btn-primary">Calculate Busfactor<span class="octicon octicon-arrow-right"></span></button>
                        </div>
                    </form>
                </div>
        </main>
        <footer class="columns">
            <div class="column one-third">&copy; 2015 Web Four Point Oh
                <!--&emsp;<a href="#">Terms</a>
                &emsp;<a href="#">Privacy</a>
                &emsp;<a href="#">Security</a>-->
                &emsp;<a href="irc">All</a>
                &emsp;<a href="rizon">Your</a>
                &emsp;<a href="dot">Base</a>
            </div>
            <div class="column one-third center">
                <h1 style="color: #ccc; margin-top: -10px;"><i class="icon-mark-github"></i></h1>
            </div>
            <div class="column one-third right">
                <!--<a href="#">Status</a>
                &emsp;<a href="#">API</a>
                &emsp;<a href="#">Training</a>
                &emsp;<a href="#">Shop</a>
                &emsp;<a href="#">Blog</a>-->
                &emsp;<a href="net">Are</a>
                &emsp;<a href="#">Belong</a>
                &emsp;<a href="web">To</a>
                &emsp;<a href="4.0">Us</a>
            </div>
        </footer>
 <script>
/**
 * don't worry about it */
document.body.onload = function(){
    [].forEach.call(document.querySelectorAll('.bf-graph span'),function(el){
        // i'm not worried about it
        el.style.color = el.style.backgroundColor.replace("rgb","rgba").replace(")",",0.5)");

        var target = document.getElementById(el.parentNode.dataset.repo);
        el.addEventListener('click', function(evt) {
            // it's fine
            [].forEach.call(el.parentNode.querySelectorAll('.glow'),function(thisisreallyshitty){
                thisisreallyshitty.classList.remove('glow');
            });
            el.classList.add('glow');
            target.innerHTML = el.getAttribute('aria-label');
            target.parentNode.style.backgroundColor = el.style.backgroundColor;
            target.parentNode.classList.remove('gone');
        },false);

        // I SAID DON'T WORRY ABOUT IT
        target.parentNode.querySelector('button').addEventListener('click', function(evt) {
            el.classList.remove('glow');
            target.innerHTML = '';
            target.parentNode.classList.add('gone');
        },false);
    });
}
// D:
        </script>
    </body>
</html>
